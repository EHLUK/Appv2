$ErrorActionPreference = "Stop"

$repoUrl = "https://github.com/EHLUK/Planningappv10.git"
$work = Join-Path $env:TEMP "Planningappv10-flat-repair"
$source = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Preparing GitHub repair workspace..." -ForegroundColor Cyan
if (Test-Path -LiteralPath $work) {
  Remove-Item -LiteralPath $work -Recurse -Force
}

git clone $repoUrl $work
Push-Location $work

Write-Host "Replacing repository root with flat Render upload files..." -ForegroundColor Cyan
Get-ChildItem -Force | Where-Object { $_.Name -ne ".git" } | Remove-Item -Recurse -Force
Copy-Item -Path (Join-Path $source "*") -Destination $work -Recurse -Force
Copy-Item -Path (Join-Path $source ".dockerignore") -Destination $work -Force

git add -A
git commit -m "Fix Render deployment with flat upload structure"
git push origin main

Pop-Location
Write-Host "Complete. Rebuild on Render." -ForegroundColor Green
