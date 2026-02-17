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
2. Details â†’ Add to Siri
3. Record: "Log food"

For "Nutrition Summary":
1. Long press shortcut
2. Details â†’ Add to Siri
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
- Settings â†’ Privacy â†’ Data Jar
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


## Note on Downloaded Filenames

When downloading shortcuts from GitHub releases, filenames will
show periods instead of spaces (e.g., Log.Nutrition.shortcut).
This is normal GitHub behavior.

Once imported to iPhone, the shortcut will have the correct name
with spaces (e.g., Log Nutrition). The filename does not affect
the imported shortcut name.
