# find-encoding-issues.ps1
# Finds problematic characters in documentation files

$repoRoot = "C:\Users\chris\nutrition-tracker"

Write-Host "Scanning for encoding issues..." -ForegroundColor Yellow
Write-Host ""

$files = Get-ChildItem -Path $repoRoot -Recurse -Include *.md

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Check for common problematic characters
    $issues = @()
    
    if ($content -match '[^\x00-\x7F]') {
        $relativePath = $file.FullName.Replace($repoRoot, "")
        Write-Host "File: $relativePath" -ForegroundColor Cyan
        
        # Find line numbers with non-ASCII characters
        $lines = Get-Content $file.FullName -Encoding UTF8
        for ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -match '[^\x00-\x7F]') {
                Write-Host "  Line $($i+1): $($lines[$i].Substring(0, [Math]::Min(80, $lines[$i].Length)))" -ForegroundColor Yellow
            }
        }
        Write-Host ""
    }
}

Write-Host "Scan complete." -ForegroundColor Green