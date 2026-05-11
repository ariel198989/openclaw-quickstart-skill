# OpenClaw Quickstart — installer for Windows (PowerShell 7+)
$ErrorActionPreference = "Stop"

$RepoUrl  = if ($env:OPENCLAW_REPO) { $env:OPENCLAW_REPO } else { "https://github.com/ariel198989/openclaw-quickstart-skill" }
$SkillName = "openclaw-quickstart"
$SkillDir = Join-Path $env:USERPROFILE ".claude\skills\$SkillName"

Write-Host "OpenClaw Quickstart installer" -ForegroundColor Cyan
Write-Host ""

# Check Claude Code
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Write-Host "X Claude Code not found in PATH." -ForegroundColor Red
    Write-Host "  Install from: https://claude.com/claude-code"
    exit 1
}
Write-Host "OK Claude Code found"

# Check git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "X git not found in PATH." -ForegroundColor Red
    exit 1
}
Write-Host "OK git found"

# Clone or update
if (Test-Path $SkillDir) {
    Write-Host "Updating existing install at $SkillDir"
    Push-Location $SkillDir
    git pull --ff-only
    Pop-Location
} else {
    Write-Host "Cloning into $SkillDir"
    $parent = Split-Path $SkillDir -Parent
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
    git clone --depth 1 $RepoUrl $SkillDir
}
Write-Host "OK Skill installed"

# Install Playwright MCP if missing
$mcpList = & claude mcp list 2>$null
if ($mcpList -notmatch "playwright") {
    Write-Host "Installing Playwright MCP"
    & claude mcp add playwright npx '@playwright/mcp@latest'
    Write-Host "OK Playwright MCP installed"
} else {
    Write-Host "OK Playwright MCP already present"
}

Write-Host ""
Write-Host "Done. Restart Claude Code, then run:  /openclaw-quickstart" -ForegroundColor Green
