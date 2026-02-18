cd C:\Users\chris\nutrition-tracker

$files = Get-ChildItem -Recurse -Include *.md

foreach ($file in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $content = [System.Text.Encoding]::UTF8.GetString($bytes)
    $original = $content
    
    $content = $content.Replace([char]0xE2 + [char]0x86 + [char]0x92, '->')
    $content = $content.Replace([char]0xC3 + [char]0xB7, '/')
    $content = $content.Replace([char]0xC2 + [char]0xB0, ' degrees')
    $content = $content.Replace([char]0xE2 + [char]0x94 + [char]0x9C + [char]0xE2 + [char]0x94 + [char]0x80 + [char]0xE2 + [char]0x94 + [char]0x80, '|--')
    $content = $content.Replace([char]0xE2 + [char]0x94 + [char]0x9C, '|--')
    $content = $content.Replace([char]0xE2 + [char]0x94 + [char]0x80, '-')
    $content = $content.Replace([char]0xE2 + [char]0x94 + [char]0x82, '|')
    $content = $content.Replace([char]0xE2 + [char]0x94 + [char]0x94, '`--')
    
    if ($content -ne $original) {
        Write-Host "Fixed: $($file.Name)" -ForegroundColor Cyan
        $utf8 = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8)
    }
}

Write-Host "Done!" -ForegroundColor Green