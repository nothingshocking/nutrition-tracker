# implement-option3.ps1
# Creates release folder with correct names and updates documentation

$repoRoot = "C:\Users\chris\nutrition-tracker"

Write-Host "Implementing Option 3 - Dual folder structure..." -ForegroundColor Green

# Step 1: Create release folder
Write-Host ""
Write-Host "Step 1: Creating release folder..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "$repoRoot\shortcuts\release" -Force
Write-Host "Created shortcuts/release/" -ForegroundColor Cyan

# Step 2: Copy files with correct names
Write-Host ""
Write-Host "Step 2: Copying files with correct names..." -ForegroundColor Yellow

$copies = @(
    @{ From = "log-nutrition.shortcut";        To = "Log Nutrition.shortcut" },
    @{ From = "nutrition-summary.shortcut";    To = "Nutrition Summary.shortcut" },
    @{ From = "edit-recent-entry.shortcut";    To = "Edit Recent Entry.shortcut" },
    @{ From = "get-entries.shortcut";          To = "Nutrition Get Entries.shortcut" },
    @{ From = "calculate-stats.shortcut";      To = "Nutrition Calculate Stats.shortcut" }
)

foreach ($copy in $copies) {
    $from = "$repoRoot\shortcuts\latest\$($copy.From)"
    $to = "$repoRoot\shortcuts\release\$($copy.To)"
    
    if (Test-Path $from) {
        Copy-Item $from $to
        Write-Host "Copied: $($copy.From) -> $($copy.To)" -ForegroundColor Cyan
    } else {
        Write-Host "WARNING: Source file not found: $($copy.From)" -ForegroundColor Red
    }
}

# Step 3: Create release folder README
Write-Host ""
Write-Host "Step 3: Creating release folder README..." -ForegroundColor Yellow

$content = @'
# Shortcuts - Release Versions

This folder contains shortcuts with the correct names for importing to iPhone.

## Files

| File | Shortcut Name After Import |
|------|---------------------------|
| Log Nutrition.shortcut | Log Nutrition |
| Nutrition Summary.shortcut | Nutrition Summary |
| Edit Recent Entry.shortcut | Edit Recent Entry |
| Nutrition Get Entries.shortcut | Nutrition: Get Entries |
| Nutrition Calculate Stats.shortcut | Nutrition: Calculate Stats |

## Important: Helper Shortcut Names

After importing the helper shortcuts, verify their names in the
Shortcuts app. They MUST match exactly:

- Nutrition: Get Entries (note the colon)
- Nutrition: Calculate Stats (note the colon)

iOS may import them without the colon. If so, rename manually:
1. Long press shortcut in Shortcuts app
2. Tap "Rename"
3. Add the colon after "Nutrition"

## How to Import

1. Download all 5 files to your iPhone
2. Tap each file
3. Tap "Add Shortcut"
4. Verify names in Shortcuts app (see table above)
5. Fix colon in helper names if needed

## Difference Between latest/ and release/

- **latest/** - Hyphenated names for repository convention (developers)
- **release/** - Correct iOS names for importing (end users)
'@
Set-Content -Path "$repoRoot\shortcuts\release\README.md" -Value $content -Encoding UTF8
Write-Host "Created shortcuts/release/README.md" -ForegroundColor Cyan

# Step 4: Update latest/ README
Write-Host ""
Write-Host "Step 4: Updating latest/ README..." -ForegroundColor Yellow

$content = @'
# Shortcuts - Latest Development Versions

This folder contains shortcuts using hyphenated naming for repository
convention. These are the working development files.

## Files

| File | Description |
|------|-------------|
| log-nutrition.shortcut | Main logging interface |
| nutrition-summary.shortcut | Statistics display |
| edit-recent-entry.shortcut | Edit incomplete entries |
| get-entries.shortcut | Helper: Query entries |
| calculate-stats.shortcut | Helper: Calculate statistics |

## Important

These files use hyphenated names for repository consistency.
For importing to iPhone, use the files in the release/ folder
which have the correct iOS shortcut names.

## Exporting Updated Shortcuts

When you update shortcuts and need to save new versions:

1. Export from iPhone via Share → Save to Files
2. Save to this folder (latest/)
3. Also copy to release/ with correct names:
   - log-nutrition.shortcut → Log Nutrition.shortcut
   - nutrition-summary.shortcut → Nutrition Summary.shortcut
   - edit-recent-entry.shortcut → Edit Recent Entry.shortcut
   - get-entries.shortcut → Nutrition Get Entries.shortcut
   - calculate-stats.shortcut → Nutrition Calculate Stats.shortcut
4. Commit both folders to Git
'@
Set-Content -Path "$repoRoot\shortcuts\latest\README.md" -Value $content -Encoding UTF8
Write-Host "Updated shortcuts/latest/README.md" -ForegroundColor Cyan

# Step 5: Update docs/installation.md
Write-Host ""
Write-Host "Step 5: Updating installation guide..." -ForegroundColor Yellow

$content = @'
# Installation Guide

## Prerequisites

- iPhone with iOS 26.0+
- Internet connection
- iCloud account (recommended)
- ~10 minutes

## Step 1: Install Data Jar

1. Open App Store
2. Search "Data Jar"
3. Install (free)
4. Open to initialize

## Step 2: Download Shortcuts

Download all 5 files from the shortcuts/release/ folder:

1. Log Nutrition.shortcut
2. Nutrition Summary.shortcut
3. Edit Recent Entry.shortcut
4. Nutrition Get Entries.shortcut
5. Nutrition Calculate Stats.shortcut

IMPORTANT: Use files from shortcuts/release/ NOT shortcuts/latest/
The release folder has the correct names for iOS importing.

## Step 3: Import Shortcuts

1. Tap each .shortcut file
2. Tap "Add Shortcut"
3. Repeat for all 5

Verify: All 5 appear in Shortcuts app

## Step 4: Verify Shortcut Names

This is a critical step. Open Shortcuts app and verify
each shortcut has EXACTLY the correct name:

| Shortcut | Required Name |
|----------|---------------|
| Main logger | Log Nutrition |
| Stats display | Nutrition Summary |
| Edit tool | Edit Recent Entry |
| Helper 1 | Nutrition: Get Entries |
| Helper 2 | Nutrition: Calculate Stats |

### Fix Helper Names (If Needed)

iOS may import the helpers without the colon:
- "Nutrition Get Entries" instead of "Nutrition: Get Entries"
- "Nutrition Calculate Stats" instead of "Nutrition: Calculate Stats"

If this happens:
1. Long press the shortcut
2. Tap "Rename"
3. Add the colon: "Nutrition: Get Entries"
4. Repeat for Calculate Stats

The colons are REQUIRED. Without them the system will not work.

## Step 5: Configure Siri

For "Log Nutrition":
1. Long press shortcut
2. Details → Add to Siri
3. Record: "Log food"

For "Nutrition Summary":
1. Long press shortcut
2. Details → Add to Siri
3. Record: "Fuel check"

Tip: Choose phrases that are easy to say while active.
Keep them short and distinct.

## Step 6: Grant Permissions

Run each main shortcut once to grant Data Jar access:
1. Tap "Log Nutrition" manually
2. Tap "Allow" when prompted for Data Jar access
3. Cancel the shortcut (no need to complete it)
4. Repeat for "Nutrition Summary" and "Edit Recent Entry"

## Step 7: Test the System

Test 1: Log Entry
1. "Hey Siri, log food"
2. Enter: "Test Gel", 100, 25, "Just now"
3. Tap "Log It"
4. Should see success notification

Test 2: Check Summary
1. "Hey Siri, fuel check"
2. Enter: 1
3. Should see your test entry

Test 3: Verify in Data Jar
1. Open Data Jar app
2. Find nutrition_YYYY_MM_DD (today)
3. Verify entry exists with all 5 fields

Test 4: Edit Function
1. Log an entry with 0 calories
2. Run "Edit Recent Entry"
3. Select and update the entry
4. Verify in summary

## Step 8: Clean Up Test Data

1. Open Data Jar
2. Find today's key (nutrition_YYYY_MM_DD)
3. Swipe left to delete
4. Confirm

## Troubleshooting

### "Shortcut not found" Error
Cause: Helper shortcut name is wrong
Fix: Rename helper to exact name (see Step 4)

### "No value found" Error
Cause: First entry of new day
Solution: Normal - system creates key automatically

### Shortcuts Won't Import
- Update iOS
- Restart iPhone
- Use Safari to download files

### Siri Does Not Work
- Check "Hey Siri" is enabled
- Verify internet connection
- Re-record Siri phrase
- Test in quiet environment first

### Data Jar Permission Denied
- Settings → Privacy → Data Jar
- Ensure Shortcuts has permission
- Reinstall Data Jar if needed

## Uninstalling

1. Delete all 5 shortcuts from Shortcuts app
2. Delete nutrition_* keys from Data Jar
3. Optionally delete Data Jar app

## Version

**Version:** 1.0.0  
**Last Updated:** February 16, 2026  
**iOS Requirement:** 26.0+
'@
Set-Content -Path "$repoRoot\docs\installation.md" -Value $content -Encoding UTF8
Write-Host "Updated docs/installation.md" -ForegroundColor Cyan

# Step 6: Update README.md installation section
Write-Host ""
Write-Host "Step 6: Updating README installation section..." -ForegroundColor Yellow

$content = @'
# Nutrition Tracker for Endurance Sports

A voice-activated nutrition tracking system built on iOS Shortcuts,
designed for endurance athletes who need hands-free logging and
real-time statistics during long training sessions and events.

## Overview

Track nutrition intake during cycling, running, triathlon,
ultramarathon, or any endurance activity without breaking focus.
Voice commands enable logging while moving, with real-time
summaries to monitor fueling strategy.

## Key Features

- Voice-Activated Logging - Log items hands-free via Siri
- Backdated Entries - Record items consumed minutes ago
- Real-Time Statistics - Check calories/hr and carbs/hr mid-activity
- Edit Incomplete Entries - Update items where values were unknown
- Session Tracking - Automatic grouping of entries by date/time
- Performance Optimized - Efficient queries with thousands of entries

## Quick Start

See [docs/quick-start.md](docs/quick-start.md) for 10-minute setup.

## Installation

### Prerequisites

- iPhone with iOS 26.0 or later
- Data Jar app (free from App Store)
- iCloud enabled (recommended)

### Download Shortcuts

Download all 5 files from shortcuts/release/:

1. Log Nutrition.shortcut
2. Nutrition Summary.shortcut
3. Edit Recent Entry.shortcut
4. Nutrition Get Entries.shortcut
5. Nutrition Calculate Stats.shortcut

IMPORTANT: Use shortcuts/release/ files (not shortcuts/latest/)

### Import to iPhone

1. Tap each .shortcut file
2. Tap "Add Shortcut"
3. Verify all 5 appear in Shortcuts app

### Critical: Verify Helper Names

After importing, check these exact names in Shortcuts app:

| Shortcut | Required Name |
|----------|---------------|
| Helper 1 | Nutrition: Get Entries |
| Helper 2 | Nutrition: Calculate Stats |

Note the colon after "Nutrition" - this is required.

If missing, long press → Rename → add the colon.

### Set Up Siri

- "Log food" → Log Nutrition
- "Fuel check" → Nutrition Summary

See [docs/installation.md](docs/installation.md) for full details.

## Usage

### Log Nutrition

"Hey Siri, log food"

1. Speak item name
2. Enter calories (0 if unknown)
3. Enter carbs in grams (0 if unknown)
4. Choose timing (Just now / Earlier)
5. Confirm to save

### Check Statistics

"Hey Siri, fuel check"

Enter hours to review. Output example:
```
Last 3 hours:

Items: 5
Calories: 450 (150/hr)
Carbs: 95g (32g/hr)

Items without data: 1
```

### Edit Incomplete Entries

1. Open Shortcuts app
2. Run "Edit Recent Entry"
3. Select item
4. Enter correct values

## Repository Structure
```
nutrition-tracker/
├── shortcuts/
│   ├── latest/     <- Development files (hyphenated names)
│   └── release/    <- Import-ready files (correct iOS names)
├── docs/
│   ├── quick-start.md
│   ├── user-guide.md
│   ├── installation.md
│   ├── architecture.md
│   └── logic/      <- Pseudocode for each shortcut
└── tests/
    ├── test-plan.md
    └── field-test-template.md
```

## Documentation

- [Quick Start](docs/quick-start.md)
- [User Guide](docs/user-guide.md)
- [Installation](docs/installation.md)
- [Architecture](docs/architecture.md)

## Roadmap

**v1.0** (Current)
- Core logging and summary
- Voice activation
- Edit functionality
- Performance optimization

**v1.1** (Planned)
- Quick Log menu
- CSV export
- Automated backup

**v2.0** (Future)
- Apple Watch support
- Training platform integration
- Predictive alerts

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - See [LICENSE](LICENSE) for details.

## Version

**Version:** 1.0.0  
**Last Updated:** February 16, 2026  
**Compatibility:** iOS 26.0+
'@
Set-Content -Path "$repoRoot\README.md" -Value $content -Encoding UTF8
Write-Host "Updated README.md" -ForegroundColor Cyan

# Step 7: Update quick-start.md
Write-Host ""
Write-Host "Step 7: Updating quick-start guide..." -ForegroundColor Yellow

$content = @'
# Quick Start Guide

Get up and running in 10 minutes.

## 1. Install Data Jar (2 minutes)

1. Open App Store
2. Search "Data Jar"
3. Install (free)

## 2. Import Shortcuts (3 minutes)

Download from shortcuts/release/ folder:
1. Log Nutrition.shortcut
2. Nutrition Summary.shortcut
3. Edit Recent Entry.shortcut
4. Nutrition Get Entries.shortcut
5. Nutrition Calculate Stats.shortcut

Tap each file → "Add Shortcut"

## 3. Verify Helper Names (1 minute)

CRITICAL STEP - Open Shortcuts app and check:

- "Nutrition: Get Entries" (colon required)
- "Nutrition: Calculate Stats" (colon required)

If missing colon: Long press → Rename → add colon

## 4. Set Up Voice (2 minutes)

Log Nutrition:
1. Long press → Details → Add to Siri
2. Record: "Log food"

Nutrition Summary:
1. Long press → Details → Add to Siri
2. Record: "Fuel check"

## 5. Test It (2 minutes)

1. Say "Hey Siri, log food"
2. Enter: "Test Gel", 100 calories, 25g carbs, "Just now"
3. Tap "Log It"
4. Say "Hey Siri, fuel check"
5. Enter: 1 hour

You should see your test entry!

## You Are Ready!

Core commands:
- LOG: "Hey Siri, log food"
- CHECK: "Hey Siri, fuel check"
- EDIT: Shortcuts app → "Edit Recent Entry"

## Common Issues

Problem: "Shortcut not found" error
Fix: Check helper names have colons (Step 3)

Problem: Siri does not activate
Fix: Verify Hey Siri enabled, internet connected

Problem: "No value found" error
Fix: Normal on first use - system creates key automatically

See docs/installation.md for full troubleshooting guide.

**Version:** 1.0.0  
**Last Updated:** February 16, 2026
'@
Set-Content -Path "$repoRoot\docs\quick-start.md" -Value $content -Encoding UTF8
Write-Host "Updated docs/quick-start.md" -ForegroundColor Cyan

# Step 8: Verify final structure
Write-Host ""
Write-Host "Step 8: Verifying structure..." -ForegroundColor Yellow
Write-Host ""
Write-Host "shortcuts/latest/:" -ForegroundColor White
Get-ChildItem "$repoRoot\shortcuts\latest\" | ForEach-Object { Write-Host "  $($_.Name)" -ForegroundColor Gray }
Write-Host ""
Write-Host "shortcuts/release/:" -ForegroundColor White
Get-ChildItem "$repoRoot\shortcuts\release\" | ForEach-Object { Write-Host "  $($_.Name)" -ForegroundColor Gray }

Write-Host ""
Write-Host "All done!" -ForegroundColor Green
Write-Host ""
Write-Host "Summary of changes:" -ForegroundColor Yellow
Write-Host "  Created: shortcuts/release/ folder with iOS-ready names"
Write-Host "  Updated: shortcuts/latest/README.md"
Write-Host "  Updated: shortcuts/release/README.md"
Write-Host "  Updated: docs/installation.md"
Write-Host "  Updated: docs/quick-start.md"
Write-Host "  Updated: README.md"
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. git add ."
Write-Host "2. git commit -m 'Add release folder with iOS-ready shortcut names'"
Write-Host "3. git push origin main"
Write-Host "4. Update GitHub release to attach files from shortcuts/release/"