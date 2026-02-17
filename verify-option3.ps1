# verify-option3.ps1
# Verifies the Option 3 implementation is correct before committing

$repoRoot = "C:\Users\chris\nutrition-tracker"
$passed = 0
$failed = 0
$warnings = 0

Write-Host "========================================" -ForegroundColor White
Write-Host "  Nutrition Tracker - Pre-Commit Check  " -ForegroundColor White
Write-Host "========================================" -ForegroundColor White
Write-Host ""

# Helper functions
function Pass($message) {
    Write-Host "  PASS: $message" -ForegroundColor Green
    $script:passed++
}

function Fail($message) {
    Write-Host "  FAIL: $message" -ForegroundColor Red
    $script:failed++
}

function Warn($message) {
    Write-Host "  WARN: $message" -ForegroundColor Yellow
    $script:warnings++
}

function Section($title) {
    Write-Host ""
    Write-Host "--- $title ---" -ForegroundColor Cyan
}

# =============================================
# CHECK 1: Folder Structure
# =============================================
Section "Folder Structure"

$folders = @(
    "shortcuts\latest",
    "shortcuts\release",
    "docs",
    "docs\logic",
    "tests",
    ".github\ISSUE_TEMPLATE"
)

foreach ($folder in $folders) {
    if (Test-Path "$repoRoot\$folder") {
        Pass "Folder exists: $folder"
    } else {
        Fail "Folder missing: $folder"
    }
}

# =============================================
# CHECK 2: Latest Folder (Hyphenated Names)
# =============================================
Section "shortcuts/latest/ Files (Hyphenated)"

$latestFiles = @(
    "log-nutrition.shortcut",
    "nutrition-summary.shortcut",
    "edit-recent-entry.shortcut",
    "get-entries.shortcut",
    "calculate-stats.shortcut",
    "README.md"
)

foreach ($file in $latestFiles) {
    if (Test-Path "$repoRoot\shortcuts\latest\$file") {
        Pass "Found: $file"
    } else {
        Fail "Missing: $file"
    }
}

# =============================================
# CHECK 3: Release Folder (iOS Names)
# =============================================
Section "shortcuts/release/ Files (iOS Names)"

$releaseFiles = @(
    "Log Nutrition.shortcut",
    "Nutrition Summary.shortcut",
    "Edit Recent Entry.shortcut",
    "Nutrition Get Entries.shortcut",
    "Nutrition Calculate Stats.shortcut",
    "README.md"
)

foreach ($file in $releaseFiles) {
    if (Test-Path "$repoRoot\shortcuts\release\$file") {
        Pass "Found: $file"
    } else {
        Fail "Missing: $file"
    }
}

# =============================================
# CHECK 4: File Sizes Match (not empty/corrupt)
# =============================================
Section "File Size Validation"

$filePairs = @(
    @{ Latest = "log-nutrition.shortcut";        Release = "Log Nutrition.shortcut" },
    @{ Latest = "nutrition-summary.shortcut";    Release = "Nutrition Summary.shortcut" },
    @{ Latest = "edit-recent-entry.shortcut";    Release = "Edit Recent Entry.shortcut" },
    @{ Latest = "get-entries.shortcut";          Release = "Nutrition Get Entries.shortcut" },
    @{ Latest = "calculate-stats.shortcut";      Release = "Nutrition Calculate Stats.shortcut" }
)

foreach ($pair in $filePairs) {
    $latestPath  = "$repoRoot\shortcuts\latest\$($pair.Latest)"
    $releasePath = "$repoRoot\shortcuts\release\$($pair.Release)"

    if ((Test-Path $latestPath) -and (Test-Path $releasePath)) {
        $latestSize  = (Get-Item $latestPath).Length
        $releaseSize = (Get-Item $releasePath).Length

        if ($latestSize -eq 0) {
            Fail "Latest file is empty: $($pair.Latest)"
        } elseif ($releaseSize -eq 0) {
            Fail "Release file is empty: $($pair.Release)"
        } elseif ($latestSize -eq $releaseSize) {
            Pass "Sizes match: $($pair.Latest) ($latestSize bytes)"
        } else {
            Fail "Size mismatch: $($pair.Latest) ($latestSize) vs $($pair.Release) ($releaseSize)"
        }
    } else {
        Warn "Could not compare (one or both files missing): $($pair.Latest)"
    }
}

# =============================================
# CHECK 5: Main Documentation Files
# =============================================
Section "Main Documentation Files"

$mainFiles = @(
    "README.md",
    "CHANGELOG.md",
    "LICENSE",
    "CONTRIBUTING.md",
    ".gitignore"
)

foreach ($file in $mainFiles) {
    $path = "$repoRoot\$file"
    if (Test-Path $path) {
        $size = (Get-Item $path).Length
        if ($size -gt 0) {
            Pass "Found and not empty: $file ($size bytes)"
        } else {
            Fail "File is empty: $file"
        }
    } else {
        Fail "Missing: $file"
    }
}

# =============================================
# CHECK 6: Docs Files
# =============================================
Section "Documentation Files (docs/)"

$docFiles = @(
    "docs\architecture.md",
    "docs\user-guide.md",
    "docs\installation.md",
    "docs\quick-start.md"
)

foreach ($file in $docFiles) {
    $path = "$repoRoot\$file"
    if (Test-Path $path) {
        $size = (Get-Item $path).Length
        if ($size -gt 0) {
            Pass "Found and not empty: $file ($size bytes)"
        } else {
            Fail "File is empty: $file"
        }
    } else {
        Fail "Missing: $file"
    }
}

# =============================================
# CHECK 7: Logic Documentation Files
# =============================================
Section "Logic Documentation Files (docs/logic/)"

$logicFiles = @(
    "docs\logic\log-nutrition.md",
    "docs\logic\nutrition-summary.md",
    "docs\logic\edit-recent-entry.md",
    "docs\logic\get-entries.md",
    "docs\logic\calculate-stats.md"
)

foreach ($file in $logicFiles) {
    $path = "$repoRoot\$file"
    if (Test-Path $path) {
        $size = (Get-Item $path).Length
        if ($size -gt 0) {
            Pass "Found and not empty: $file ($size bytes)"
        } else {
            Fail "File is empty: $file"
        }
    } else {
        Fail "Missing: $file"
    }
}

# =============================================
# CHECK 8: Test Documentation Files
# =============================================
Section "Test Documentation Files (tests/)"

$testFiles = @(
    "tests\test-plan.md",
    "tests\field-test-template.md"
)

foreach ($file in $testFiles) {
    $path = "$repoRoot\$file"
    if (Test-Path $path) {
        $size = (Get-Item $path).Length
        if ($size -gt 0) {
            Pass "Found and not empty: $file ($size bytes)"
        } else {
            Fail "File is empty: $file"
        }
    } else {
        Fail "Missing: $file"
    }
}

# =============================================
# CHECK 9: GitHub Templates
# =============================================
Section "GitHub Issue Templates"

$githubFiles = @(
    ".github\ISSUE_TEMPLATE\bug_report.md",
    ".github\ISSUE_TEMPLATE\feature_request.md"
)

foreach ($file in $githubFiles) {
    $path = "$repoRoot\$file"
    if (Test-Path $path) {
        Pass "Found: $file"
    } else {
        Fail "Missing: $file"
    }
}

# =============================================
# CHECK 10: Content Validation
# =============================================
Section "Content Validation"

# Check README mentions release folder
$readmeContent = Get-Content "$repoRoot\README.md" -Raw
if ($readmeContent -match "shortcuts/release") {
    Pass "README references shortcuts/release/"
} else {
    Fail "README does not reference shortcuts/release/"
}

# Check README mentions colon requirement
if ($readmeContent -match "colon") {
    Pass "README mentions colon requirement for helpers"
} else {
    Warn "README does not mention colon requirement"
}

# Check installation guide mentions release folder
$installContent = Get-Content "$repoRoot\docs\installation.md" -Raw
if ($installContent -match "shortcuts/release") {
    Pass "Installation guide references shortcuts/release/"
} else {
    Fail "Installation guide does not reference shortcuts/release/"
}

# Check installation guide mentions colon
if ($installContent -match "colon") {
    Pass "Installation guide mentions colon requirement"
} else {
    Fail "Installation guide does not mention colon requirement"
}

# Check release README mentions colon
$releaseReadme = Get-Content "$repoRoot\shortcuts\release\README.md" -Raw
if ($releaseReadme -match "colon") {
    Pass "Release README mentions colon requirement"
} else {
    Fail "Release README does not mention colon requirement"
}

# Check latest README mentions release folder
$latestReadme = Get-Content "$repoRoot\shortcuts\latest\README.md" -Raw
if ($latestReadme -match "release") {
    Pass "Latest README points users to release folder"
} else {
    Warn "Latest README does not mention release folder"
}

# =============================================
# CHECK 11: Git Status
# =============================================
Section "Git Status"

$gitStatus = git -C $repoRoot status 2>&1
if ($LASTEXITCODE -eq 0) {
    Pass "Git repository initialized"

    # Check for uncommitted changes
    if ($gitStatus -match "nothing to commit") {
        Warn "No changes staged - run git add . before committing"
    } elseif ($gitStatus -match "Changes to be committed") {
        Pass "Changes are staged and ready to commit"
    } elseif ($gitStatus -match "Changes not staged") {
        Warn "Changes exist but not yet staged - run git add ."
    } else {
        Warn "Untracked files present - run git add ."
    }
} else {
    Fail "Git not initialized or not found"
}

# =============================================
# FINAL SUMMARY
# =============================================
Write-Host ""
Write-Host "========================================" -ForegroundColor White
Write-Host "  Results Summary                       " -ForegroundColor White
Write-Host "========================================" -ForegroundColor White
Write-Host ""
Write-Host "  Passed:   $passed" -ForegroundColor Green
Write-Host "  Warnings: $warnings" -ForegroundColor Yellow
Write-Host "  Failed:   $failed" -ForegroundColor Red
Write-Host ""

if ($failed -eq 0 -and $warnings -eq 0) {
    Write-Host "  ALL CHECKS PASSED!" -ForegroundColor Green
    Write-Host "  Safe to commit and push." -ForegroundColor Green
    Write-Host ""
    Write-Host "  Run these commands:" -ForegroundColor Cyan
    Write-Host "    git add ." -ForegroundColor White
    Write-Host "    git commit -m 'Add release folder with iOS-ready shortcut names'" -ForegroundColor White
    Write-Host "    git push origin main" -ForegroundColor White
} elseif ($failed -eq 0 -and $warnings -gt 0) {
    Write-Host "  PASSED WITH WARNINGS" -ForegroundColor Yellow
    Write-Host "  Review warnings above before committing." -ForegroundColor Yellow
    Write-Host "  Warnings are not blocking but worth reviewing." -ForegroundColor Yellow
} else {
    Write-Host "  FAILED - DO NOT COMMIT YET" -ForegroundColor Red
    Write-Host "  Fix the failed checks above before committing." -ForegroundColor Red
}

Write-Host ""