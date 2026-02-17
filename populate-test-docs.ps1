# populate-test-docs.ps1
# Creates test documentation files

$repoRoot = "C:\Users\chris\nutrition-tracker"

Write-Host "Creating test documentation..." -ForegroundColor Green

# Create tests/test-plan.md
$content = @'
# Test Plan - Nutrition Tracker

Comprehensive testing strategy for validating system functionality.

## Test Environment

### Hardware
- Device: iPhone
- iOS Version: 26.0+
- Storage: Minimum 500MB free
- Network: Wi-Fi or cellular (for Siri)

### Software
- Data Jar installed
- All 5 shortcuts imported
- Siri enabled

## Test Phases

1. Installation Testing
2. Unit Testing
3. Integration Testing
4. End-to-End Testing
5. Field Testing

## Phase 1: Installation Testing

### TC-INST-001: Data Jar Installation
**Objective:** Verify Data Jar installs and opens

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Open App Store | App Store opens |
| 2 | Search "Data Jar" | Data Jar appears |
| 3 | Install | Completes |
| 4 | Open Data Jar | Opens to empty state |

### TC-INST-002: Shortcut Import
**Objective:** Verify all shortcuts import

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1-5 | Import each .shortcut file | All 5 imported |

### TC-INST-003: Siri Configuration
**Objective:** Verify Siri phrases work

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Add phrase to Log Nutrition | Recorded |
| 2 | Say "Hey Siri, [phrase]" | Activates |

## Phase 2: Unit Testing

### TC-UNIT-001: Log Nutrition - Complete Entry
**Objective:** Test logging with all known values

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Run "Log Nutrition" | Prompts for item |
| 2 | Enter "Test Gel" | Prompts for calories |
| 3 | Enter 100 | Prompts for carbs |
| 4 | Enter 25 | Prompts for timing |
| 5 | Select "Just now" | Shows confirmation |
| 6 | Tap "Log It" | Success notification |
| 7 | Check Data Jar | Entry exists |

**Pass Criteria:** Entry saved with all fields

### TC-UNIT-002: Log Nutrition - Backdated Entry
**Objective:** Test backdating functionality

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1-4 | Enter item details | As above |
| 5 | Select "Earlier" | Prompts for minutes |
| 6 | Enter 30 | Shows confirmation |
| 7 | Tap "Log It" | Success |
| 8 | Check Data Jar | Timestamp 30 min ago |

### TC-UNIT-003: Log Nutrition - Unknown Values
**Objective:** Test with zero values

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1-2 | Enter item, 0 calories | Continues |
| 3-6 | Complete entry | Saves with 0 values |

### TC-UNIT-006: Nutrition Summary - With Data
**Objective:** Test summary display

**Preconditions:** At least 2 entries in last hour

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Run "Nutrition Summary" | Prompts for hours |
| 2 | Enter 1 | Shows summary |
| 3 | Verify | Correct totals |

### TC-UNIT-009: Edit Recent Entry
**Objective:** Test edit functionality

**Preconditions:** Entry with 0 calories logged

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Run "Edit Recent Entry" | Shows menu |
| 2 | Select entry | Shows current values |
| 3 | Enter new calories | Prompts for carbs |
| 4 | Enter new carbs | Success |
| 5 | Check Data Jar | Updated |

## Phase 3: Integration Testing

### TC-INT-001: Log and Summarize
**Objective:** Test full flow

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Log entry | Saved |
| 2 | Check summary | Entry appears |

### TC-INT-002: Log, Edit, Summarize
**Objective:** Test edit affecting summary

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Log with 0 calories | Saved |
| 2 | Check summary | Shows 0 |
| 3 | Edit to 200 | Updated |
| 4 | Check summary | Shows 200 |

## Phase 4: End-to-End Testing

### TC-E2E-001: Complete Workflow
**Scenario:** Training ride with tracking

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1-2 | Log gel (100, 25) | Logged |
| 3-4 | Log bar (0, 0) | Logged unknown |
| 5-6 | Check stats | Shows 2 items |
| 7-8 | Log gel backdated | Logged |
| 9-10 | Edit bar, check final | All correct |

## Phase 5: Field Testing

### TC-FIELD-001: Short Ride (1-2 hours)
**Conditions:** Outdoor, voice activation, movement

**Test Plan:**
1. Log 3-5 items
2. Check summary mid-ride
3. Verify after ride

**Success:** All entries captured, no errors

### TC-FIELD-002: Long Ride (4+ hours)
**Conditions:** Extended usage, battery considerations

**Test Plan:**
1. Log 8-12 items over 4+ hours
2. Check summary multiple times
3. Verify completeness

## Performance Testing

### TC-PERF-001: Log Entry Time
**Target:** < 30 seconds

### TC-PERF-002: Summary Query Time
**Target:** < 3 seconds

### TC-PERF-003: Edit Function Time
**Target:** < 45 seconds

## Regression Testing

### Quick Regression Suite (15 minutes)
1. TC-UNIT-001: Log complete
2. TC-UNIT-002: Log backdated
3. TC-UNIT-006: Summary
4. TC-UNIT-009: Edit
5. TC-INT-001: Log and summarize

**Pass Criteria:** All 5 pass

## Test Results Log Template

| Test ID | Result | Notes |
|---------|--------|-------|
| TC-UNIT-001 | Pass | |
| TC-UNIT-002 | Pass | |

**Summary:**
- Total: XX
- Passed: XX
- Failed: XX
- Pass Rate: XX%

## Acceptance Criteria for v1.0

**Mandatory:**
- All installation tests pass
- Core unit tests pass
- Log and summarize works
- At least one field test
- No critical bugs

**Last Updated:** February 16, 2026
'@
Set-Content -Path "$repoRoot\tests\test-plan.md" -Value $content -Encoding UTF8
Write-Host "Created tests/test-plan.md" -ForegroundColor Cyan

# Create tests/field-test-template.md
$content = @'
# Field Test Report Template

Use this template to document real-world testing sessions.

## Test Session Information

**Date:** YYYY-MM-DD  
**Test ID:** FIELD-YYYY-MM-DD-[SESSION]  
**Tester:** [Your Name]  
**Version:** 1.0.0

## Activity Details

**Activity Type:** [ ] Cycling [ ] Running [ ] Other: _______

**Duration:** _____ hours _____ minutes

**Distance:** _____ miles

**Conditions:**
- Weather: [ ] Clear [ ] Rain [ ] Wind [ ] Cold [ ] Hot
- Temperature: _____°F
- Terrain: [ ] Flat [ ] Hilly [ ] Mountainous

## System Configuration

**Device:** iPhone [model]  
**iOS Version:** 26.X.X  
**Battery at Start:** _____%  
**Battery at End:** _____%

**Accessories:**
- [ ] Helmet
- [ ] Earbuds
- [ ] Gloves

**Network:** [ ] Cellular [ ] Wi-Fi [ ] Offline

## Usage Statistics

### Logging Activity

**Total Entries Logged:** _____

**Method Breakdown:**
- Voice activation: _____ attempts, _____ successful
- Manual: _____ entries

**Entry Types:**
- Complete: _____
- Partial (0 values): _____
- Backdated: _____

**Items Logged:**
1. _____________________ (___cal, ___g)
2. _____________________ (___cal, ___g)
3. _____________________ (___cal, ___g)

### Summary Checks

**Summary Queries:** _____ times

| Time | Hours Back | Purpose |
|------|------------|---------|
| HH:MM | X | Check rate |

### Edit Activity

**Edits Performed:** _____

## Performance Metrics

**Average time to log:** _____ seconds

**Summary query time:** _____ seconds

**Voice recognition success:** _____% 

## What Worked Well

1. ___________________________________________________________

2. ___________________________________________________________

3. ___________________________________________________________

## Friction Points

**Issue 1:**
- Description: _________________________________________________
- Severity: [ ] Critical [ ] High [ ] Medium [ ] Low
- Frequency: [ ] Once [ ] Occasional [ ] Frequent
- Workaround: ______________________________________________

**Issue 2:**
- Description: _________________________________________________
- Severity: [ ] Critical [ ] High [ ] Medium [ ] Low

## Bugs/Errors

**Bug 1:**
- Description: _________________________________________________
- Steps to Reproduce:
  1. 
  2. 
  3. 
- Expected: ________________________________________________
- Actual: __________________________________________________

## Feature Requests

1. **Feature:** ___________________________________________________
   **Use Case:** _________________________________________________
   **Priority:** [ ] Must Have [ ] Should Have [ ] Nice to Have

2. **Feature:** ___________________________________________________

## Data Quality

**Data Accuracy:** [ ] 100% [ ] >95% [ ] >90% [ ] <90%

**Missing Entries:** _____

**Verification:**
- [ ] Checked Data Jar
- [ ] All entries present
- [ ] Timestamps correct

## User Experience

**Overall Rating:** [ ] 5 [ ] 4 [ ] 3 [ ] 2 [ ] 1 stars

**Would use again?** [ ] Yes [ ] Maybe [ ] No

**Why?** _________________________________________________________

**Cognitive Load:** [ ] Low [ ] Medium [ ] High

**Distraction Level:** [ ] Minimal [ ] Moderate [ ] Significant

## Post-Activity Review

**Total nutrition:**
- Calories: _____ (_____/hr)
- Carbs: _____g (_____g/hr)

**Fueling effectiveness:** [ ] Excellent [ ] Good [ ] Adequate [ ] Poor

**Did tracking help?** [ ] Yes [ ] Somewhat [ ] No

**Insights gained:** __________________________________________

## Recommendations

**Priority 1 (Critical):**
________________________________________________________________

**Priority 2 (Important):**
________________________________________________________________

**Priority 3 (Nice to have):**
________________________________________________________________

## Next Steps

**Will you:**
- [ ] Continue using as-is
- [ ] Wait for improvements
- [ ] Test specific scenarios
- [ ] Try alternatives

**Planned next test:** [ ] Yes (when: _______) [ ] No

## Additional Notes

________________________________________________________________

________________________________________________________________

________________________________________________________________

## Attachments

**Screenshots:** [ ] Yes (_____ files) [ ] No

**Data exports:** [ ] Yes [ ] No

## Test Completion

**Test completed:** [ ] Yes [ ] Partial [ ] No

**Data recorded:** [ ] Yes [ ] No

**Ready for next test:** [ ] Yes [ ] No

**Signature:** _____________________ **Date:** __________

**Last Updated:** February 16, 2026
'@
Set-Content -Path "$repoRoot\tests\field-test-template.md" -Value $content -Encoding UTF8
Write-Host "Created tests/field-test-template.md" -ForegroundColor Cyan

Write-Host ""
Write-Host "Test documentation created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "All documentation is now complete!" -ForegroundColor Yellow
Write-Host ""
Write-Host "Repository structure:" -ForegroundColor Cyan
Write-Host "  Main files: README, CHANGELOG, LICENSE, CONTRIBUTING, .gitignore"
Write-Host "  Documentation: docs/*.md (5 files)"
Write-Host "  Logic docs: docs/logic/*.md (5 files)"
Write-Host "  Test docs: tests/*.md (2 files)"
Write-Host "  GitHub templates: .github/ISSUE_TEMPLATE/*.md (2 files)"
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Green
Write-Host "1. Add your .shortcut files to shortcuts/latest/"
Write-Host "2. Initialize Git: git init"
Write-Host "3. Add files: git add ."
Write-Host "4. Commit: git commit -m 'Initial commit: v1.0.0'"
Write-Host "5. Create GitHub repo and push"