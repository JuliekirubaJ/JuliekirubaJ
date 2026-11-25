<#
.SYNOPSIS
  Quick AI-search (AEO) readiness check for any public website.

  Checks:
    1. /llms.txt exists and lists links
    2. robots.txt rules for common AI crawlers (GPTBot, ClaudeBot, PerplexityBot, Google-Extended, CCBot)
    3. For each page: JSON-LD schema types, H1 count, meta description, question-style H2s

.EXAMPLE
  .\aeo-check.ps1 -Site https://example.com -Pages /,/pricing,/blog/what-is-xyz
#>
param(
  [Parameter(Mandatory)][string]$Site,
  [string[]]$Pages = @('/'),
  [string]$OutFile = 'aeo-results.csv'
)

$ErrorActionPreference = 'Stop'
$Site = $Site.TrimEnd('/')
$ua = @{ 'User-Agent' = 'aeo-portfolio-check/1.0' }

function Get-Text([string]$url) {
  try { (Invoke-WebRequest -Uri $url -Headers $ua -UseBasicParsing -TimeoutSec 20).Content } catch { $null }
}

# 1. llms.txt
$llms = Get-Text "$Site/llms.txt"
$llmsLinks = if ($llms) { ([regex]::Matches($llms, '\]\((https?://[^)]+)\)')).Count } else { 0 }
Write-Host ("llms.txt: " + $(if ($llms) { "found, $llmsLinks links" } else { 'missing' }))

# 2. AI crawler rules in robots.txt
$robots = Get-Text "$Site/robots.txt"
foreach ($bot in 'GPTBot', 'ClaudeBot', 'PerplexityBot', 'Google-Extended', 'CCBot') {
  $status = 'allowed (no rule)'
  if ($robots -and $robots -match "(?ims)User-agent:\s*$bot\s*(.*?)(?=User-agent:|\z)") {
    if ($Matches[1] -match '(?im)^\s*Disallow:\s*/\s*$') { $status = 'BLOCKED' } else { $status = 'has rule, not fully blocked' }
  }
  Write-Host ("  {0,-16} {1}" -f $bot, $status)
}

# 3. Page answer-readiness
$rows = foreach ($p in $Pages) {
  $url = $Site + $p
  $html = Get-Text $url
  if (-not $html) { [pscustomobject]@{ Url = $url; Status = 'fetch failed' }; continue }

  $types = [regex]::Matches($html, '"@type"\s*:\s*"([^"]+)"') | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
  $h1 = ([regex]::Matches($html, '<h1[\s>]', 'IgnoreCase')).Count
  $meta = [regex]::Match($html, '<meta[^>]+name=["'']description["''][^>]+content=["'']([^"'']*)', 'IgnoreCase').Groups[1].Value
  $h2s = [regex]::Matches($html, '<h2[^>]*>(.*?)</h2>', 'IgnoreCase,Singleline') | ForEach-Object { ($_.Groups[1].Value -replace '<[^>]+>', '').Trim() }
  $questions = @($h2s | Where-Object { $_ -match '\?$|^(what|how|why|when|which|can|does|is)\b' }).Count

  [pscustomobject]@{
    Url             = $url
    Status          = 'ok'
    SchemaTypes     = ($types -join '; ')
    H1Count         = $h1
    MetaDescLength  = $meta.Length
    QuestionH2s     = $questions
    Ready           = [bool]($types -and $h1 -eq 1 -and $meta.Length -ge 70 -and $questions -ge 1)
  }
}

$rows | Format-Table -AutoSize
$rows | Export-Csv -Path $OutFile -NoTypeInformation -Encoding UTF8
Write-Host "Saved $OutFile"
