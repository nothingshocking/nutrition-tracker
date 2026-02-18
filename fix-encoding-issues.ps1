# fix-encoding-issues-v2.ps1
# Comprehensive fix for all encoding issues

$repoRoot = "C:\Users\chris\nutrition-tracker"

Write-Host "Fixing all encoding issues..." -ForegroundColor Yellow

$files = Get-ChildItem -Path $repoRoot -Recurse -Include *.md

$fixedCount = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $original = $content
    
    # Smart quotes
    $content = $content -replace [char]0x201C, '"'
    $content = $content -replace [char]0x201D, '"'
    $content = $content -replace [char]0x2018, "'"
    $content = $content -replace [char]0x2019, "'"
    
    # Dashes
    $content = $content -replace [char]0x2014, '--'
    $content = $content -replace [char]0x2013, '-'
    
    # Arrows - THIS WAS MISSING
    $content = $content -replace [char]0x2192, '->'
    $content = $content -replace [char]0x2190, '<-'
    
    # Division sign - THIS WAS MISSING  
    $content = $content -replace [char]0x00F7, '/'
    
    # Degree symbol
    $content = $content -replace [char]0x00B0, ' degrees'
    
    # Checkboxes
    $content = $content -replace [char]0x2610, '[ ]'
    $content = $content -replace [char]0x2611, '[x]'
    $content = $content -replace [char]0x2713, '[x]'
    $content = $content -replace [char]0x2714, '[x]'
    
    # Stars
    $content = $content -replace [char]0x2605, '*'
    $content = $content -replace [char]0x2606, '*'
    
    # Warning sign
    $content = $content -replace [char]0x26A0, 'WARNING:'
    
    # Box drawing characters (for tree structure)
    $content = $content -replace [char]0x251C, '|--'  # ├
    $content = $content -replace [char]0x2500, '-'     # ─
    $content = $content -replace [char]0x2502, '|'     # │
    $content = $content -replace [char]0x2514, '`--'   # └
    
    # Remove any remaining emojis
    $content = $content -replace '\p{So}', ''
    
    # Check if file was modified
    if ($content -ne $original) {
        $relativePath = $file.FullName.Replace("$repoRoot\", "")
        Write-Host "Fixed: $relativePath" -ForegroundColor Cyan
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        $fixedCount++
    }
}

Write-Host ""
Write-Host "Processed $($files.Count) files, fixed $fixedCount files" -ForegroundColor Green
Write-Host ""
Write-Host "Verifying fix..." -ForegroundColor Yellow

# Run a quick verification
$remaining = 0
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    if ($content -match '[^\x00-\x7F]') {
        $remaining++
    }
}

if ($remaining -eq 0) {
    Write-Host "SUCCESS: All non-ASCII characters removed!" -ForegroundColor Green
} else {
    Write-Host "WARNING: $remaining files still contain non-ASCII characters" -ForegroundColor Yellow
    Write-Host "Run find-encoding-issues.ps1 to see what remains" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  git diff" -ForegroundColor White
Write-Host "  git add ." -ForegroundColor White
Write-Host "  git commit -m 'fix: Replace all Unicode characters with ASCII'" -ForegroundColor White
Write-Host "  git push origin main" -ForegroundColor White