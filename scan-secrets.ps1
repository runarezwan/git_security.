# Git Security Secret Scanner
# Run this script to check for potential secrets or sensitive data before committing.

Write-Host "--- Starting Security Scan ---" -ForegroundColor Cyan

# Define patterns to search for
$patterns = @(
    "password", 
    "secret", 
    "api[_-]?key", 
    "token", 
    "bearer", 
    "private[_-]?key", 
    "credentials",
    "access[_-]?key",
    "ghp_", # GitHub Personal Access Tokens
    "sk_live", # Stripe Secret Keys
    "AIza" # Google API Keys
)

$patternString = $patterns -join "|"

Write-Host "`n1. Checking STAGED changes (git diff --cached)..." -ForegroundColor Yellow
$stagedResults = git diff --cached | Select-String -Pattern $patternString

if ($stagedResults) {
    Write-Host "[!] WATCH OUT: Potential secrets found in staged changes!" -ForegroundColor Red
    $stagedResults | ForEach-Object { Write-Host "    $($_.Line.Trim())" -ForegroundColor Gray }
} else {
    Write-Host "[OK] No secrets found in staged changes." -ForegroundColor Green
}

Write-Host "`n2. Checking all LOCAL files (excluding .git and .gitignore)..." -ForegroundColor Yellow
$fileResults = Get-ChildItem -Recurse -File -Exclude ".git", ".gitignore", "scan-secrets.ps1" | Select-String -Pattern $patternString

if ($fileResults) {
    Write-Host "[!] Potential secrets found in local files:" -ForegroundColor Red
    # Filtering out Security.md since it's documentation ABOUT secrets
    $fileResults | Where-Object { $_.Path -notmatch "Security.md" } | ForEach-Object {
        Write-Host "    File: $($_.Filename):$($_.LineNumber)" -ForegroundColor Gray
        Write-Host "    Match: $($_.Line.Trim())" -ForegroundColor Cyan
    }
    
    # Mention documentation separately
    $docMatches = $fileResults | Where-Object { $_.Path -match "Security.md" }
    if ($docMatches) {
        Write-Host "`n[NOTE] Found matches in Security.md (Documentation). These are likely safe." -ForegroundColor Blue
    }
} else {
    Write-Host "[OK] No secrets found in local files." -ForegroundColor Green
}

Write-Host "`n--- Scan Complete ---" -ForegroundColor Cyan
