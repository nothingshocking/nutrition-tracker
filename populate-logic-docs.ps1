# populate-logic-docs.ps1
# Creates logic documentation for all shortcuts

$repoRoot = "C:\Users\chris\nutrition-tracker"

Write-Host "Creating logic documentation..." -ForegroundColor Green

# Create docs/logic/log-nutrition.md
$content = @'
# Log Nutrition - Logic Flow

**Purpose:** Create new nutrition entry with voice input  
**Type:** User-facing shortcut  
**Invocation:** Siri voice command

## Input Parameters

None (prompts user for all inputs)

## Output

- Entry saved to Data Jar
- Confirmation notification shown

## Logic Flow

### Step 1: Collect Item Name
```
ACTION: Ask for Input
  Type: Text
  Prompt: "What did you consume?"
OUTPUT: Item (Text variable)
```

### Step 2: Collect Calories
```
ACTION: Ask for Input
  Type: Number
  Prompt: "Calories?"
  Default: 0
  Allow Negatives: No
OUTPUT: Calories (Number variable)
```

### Step 3: Collect Carbs
```
ACTION: Ask for Input
  Type: Number
  Prompt: "Carbs in grams?"
  Default: 0
  Allow Negatives: No
OUTPUT: Carbs (Number variable)
```

### Step 4: Determine Entry Time
```
ACTION: Choose from Menu
  Prompt: "When did you consume this?"
  Options: "Just now" / "Earlier"

OPTION 1: "Just now"
  Current Date → Entry Time

OPTION 2: "Earlier"
  Ask for Input: Minutes ago
  Current Date - Minutes → Entry Time
```

### Step 5: Generate Session ID
```
Format Date: Entry Time → yyyyMMdd_HHmm
Text: "session_" + Formatted Date
Set Variable: Session ID
```

### Step 6: Generate Data Key
```
Format Date: Entry Time → yyyy_MM_dd
Text: "nutrition_" + Formatted Date
Set Variable: Data Key
```

### Step 7: Format Display Time
```
Format Date: Entry Time → HH:mm
```

### Step 8: Build Confirmation Text
```
Text: "Time: [time]\nItem: [item]\nCalories: [cal]\nCarbs: [carbs]g"
```

### Step 9: Show Confirmation Menu
```
Choose from Menu: "Confirm this entry?"
  Options: "Log It" / "Cancel"
```

### Step 10: Log It - Get Existing Entries
```
Get Value (Data Jar): Data Key
  If value does not exist: Empty List

If Value does not have any value
  THEN: List (empty) → Existing Entries
  OTHERWISE: Value → Existing Entries
```

### Step 11: Create Entry Dictionary
```
Dictionary:
  - timestamp: Entry Time
  - item: Item
  - calories: Calories
  - carbs: Carbs
  - session_id: Session ID
```

### Step 12: Add Entry to List
```
Add to Variable: Existing Entries = Dictionary
```

### Step 13: Save to Data Jar
```
Set Value (Data Jar):
  Key Path: Data Key
  Value: Existing Entries
  Allow Overwriting: Yes
```

### Step 14: Show Success Notification
```
Show Notification: "Logged: [Item] at [time]"
```

### Step 15: Cancel Option
```
Show Notification: "Entry cancelled"
```

## Error Handling

- Data Jar unavailable: Empty list default prevents error
- Invalid input: iOS Shortcuts validation
- Missing fields: All required

## Variables

| Variable | Type | Purpose |
|----------|------|---------|
| Item | Text | Item name |
| Calories | Number | Calorie value |
| Carbs | Number | Carbs in grams |
| Entry Time | Date | Consumption timestamp |
| Session ID | Text | Session identifier |
| Data Key | Text | Data Jar key name |

## Performance

**Typical Execution:** 20-30 seconds (including user input)

**Data Jar Operations:**
- 1 Get Value
- 1 Set Value

**Last Updated:** February 16, 2026
'@
Set-Content -Path "$repoRoot\docs\logic\log-nutrition.md" -Value $content -Encoding UTF8
Write-Host "Created docs/logic/log-nutrition.md" -ForegroundColor Cyan

# Create docs/logic/nutrition-summary.md
$content = @'
# Nutrition Summary - Logic Flow

**Purpose:** Display nutrition statistics for a time window  
**Type:** User-facing shortcut  
**Invocation:** Siri voice command

## Input Parameters

None (prompts user for hours back)

## Output

Formatted summary text with statistics

## Logic Flow

### Step 1: Get Time Window
```
Ask for Input: "How many hours back?"
  Type: Number
  Default: 3
OUTPUT: Hours Back
```

### Step 2: Call Get Entries Helper
```
Run Shortcut: "Nutrition: Get Entries"
  Input: Hours Back
  Show When Run: No
OUTPUT: Shortcut Result (List of entries)
```

### Step 3: Check for Empty Results
```
Count: Shortcut Result

If Count is 0
  THEN:
    Show Alert: "No entries found"
    Stop Shortcut
```

### Step 4: Call Calculate Stats Helper
```
Run Shortcut: "Nutrition: Calculate Stats"
  Input: Shortcut Result
  Show When Run: No
OUTPUT: Shortcut Result (Stats dictionary)
```

### Step 5: Check for Helper Failure
```
If Shortcut Result does not have any value
  THEN:
    Show Alert: "Failed to calculate statistics"
    Stop Shortcut
```

### Step 6-9: Extract Statistics
```
Extract from dictionary:
  - item_count → Item Count
  - total_calories → Total Calories
  - total_carbs → Total Carbs
  - unknown_count → Unknown Count
```

### Step 10: Calculate Calories Per Hour
```
Calculate: Total Calories ÷ Hours Back
Round to: Ones Place
Set Variable: Cal Per Hour
```

### Step 11: Calculate Carbs Per Hour
```
Calculate: Total Carbs ÷ Hours Back
Round to: Ones Place
Set Variable: Carbs Per Hour
```

### Step 12: Build Summary Text
```
Text:
  "Last [Hours Back] hours:\n\n"
  "Items: [Item Count]\n"
  "Calories: [Total Calories] ([Cal Per Hour]/hr)\n"
  "Carbs: [Total Carbs]g ([Carbs Per Hour]g/hr)\n\n"
  "Items without data: [Unknown Count]"
```

### Step 13: Display Result
```
Show Result: Summary Text
```

## Error Handling

- No entries: Clear message, graceful stop
- Helper failure: Error message, stop
- Division by zero: Not possible (input validation)

## Performance

**Typical Execution:** 2-3 seconds

**Helper Calls:**
- 1 call to Get Entries
- 1 call to Calculate Stats

**Last Updated:** February 16, 2026
'@
Set-Content -Path "$repoRoot\docs\logic\nutrition-summary.md" -Value $content -Encoding UTF8
Write-Host "Created docs/logic/nutrition-summary.md" -ForegroundColor Cyan

# Create docs/logic/edit-recent-entry.md
$content = @'
# Edit Recent Entry - Logic Flow

**Purpose:** Update entries with missing nutrition data  
**Type:** User-facing shortcut  
**Invocation:** Manual (Shortcuts app)

## Input Parameters

None (user selects from menu)

## Output

- Updated entry in Data Jar
- Success notification

## Logic Flow

### Step 1: Get Recent Entries
```
Number: 72
Run Shortcut: "Nutrition: Get Entries"
  Input: 72
OUTPUT: Shortcut Result (Last 72 hours)
```

### Step 2-5: Query Last 3 Days from Data Jar
```
Initialize: All Recent Entries (empty list)

Query Today:
  Format Date: Now → yyyy_MM_dd
  Text: "nutrition_[date]"
  Get Value: If does not exist → Empty List
  Add all to All Recent Entries

Query Yesterday:
  (Same pattern, -1 day)

Query 2 Days Ago:
  (Same pattern, -2 days)
```

### Step 6: Filter for Incomplete Entries
```
Initialize: Incomplete Entries (empty list)

Repeat with Each in Shortcut Result:
  Get calories from entry
  Get carbs from entry
  
  If calories is 0 OR carbs is 0
    THEN: Add to Incomplete Entries
```

### Step 7: Check if Any Incomplete
```
Count: Incomplete Entries

If Count is 0
  THEN:
    Show Alert: "No items to edit"
    Stop Shortcut
```

### Step 8: Build Menu Options
```
Initialize: Menu Options (empty list)

Repeat with Each in Incomplete Entries:
  Extract: item, timestamp, calories, carbs
  Format: "[Item] at [HH:MM] ([cal]cal, [carbs]g)"
  Add to Menu Options
```

### Step 9: Show Menu
```
Choose from List: Menu Options
  Prompt: "Which entry to edit?"
OUTPUT: Selected Text
```

### Step 10: Find Selected Entry Index
```
Index = 0
Repeat with Each in Menu Options:
  Index = Index + 1
  If Repeat Item is Selected Text
    THEN: Selected Index = Index
```

### Step 11: Get Entry Object
```
Get Item from List:
  List: Incomplete Entries
  Index: Selected Index
OUTPUT: Entry to Edit
```

### Step 12: Remember Entry's Date Key
```
Get timestamp from Entry to Edit
Format Date → yyyy_MM_dd
Text: "nutrition_[date]"
Set Variable: Entry Date Key
```

### Step 13: Extract Current Values
```
Get from Entry to Edit:
  - item → Current Item
  - calories → Current Calories
  - carbs → Current Carbs
```

### Step 14: Show Current Values
```
Text: "Current values:\n[calories] calories\n[carbs] grams carbs"
Show Alert: Current Item (title), Text (message)
```

### Step 15: Get New Values
```
Ask for Input: "New calories?"
  Default: Current Calories
OUTPUT: New Calories

Ask for Input: "New carbs?"
  Default: Current Carbs
OUTPUT: New Carbs
```

### Step 16: Build Updated Entry
```
Get timestamp and session_id from Entry to Edit

Dictionary:
  - timestamp: Timestamp
  - item: Current Item
  - calories: New Calories
  - carbs: New Carbs
  - session_id: Session ID
OUTPUT: Updated Entry
```

### Step 17: Load Date's Entries
```
Get Value (Data Jar): Entry Date Key
OUTPUT: Date Entries
```

### Step 18: Remove Old Entry
```
Initialize: Updated Date Entries (empty list)

Repeat with Each in Date Entries:
  If Repeat Item is not Entry to Edit
    THEN: Add to Updated Date Entries
```

### Step 19: Add Updated Entry
```
Add to Variable: Updated Date Entries = Updated Entry
```

### Step 20: Save Back
```
Set Value (Data Jar):
  Key Path: Entry Date Key
  Value: Updated Date Entries
  Allow Overwriting: Yes
```

### Step 21: Show Success
```
Show Notification:
  "Updated [Item] to [calories]cal, [carbs]g"
```

## Error Handling

- No incomplete entries: Clear message, stop
- Missing date keys: Empty list default
- Entry not found: Should not occur

## Performance

**Typical Execution:** 30-40 seconds (including user interaction)

**Data Jar Operations:**
- 3 Get Value (3 days)
- 1 Get Value (specific date)
- 1 Set Value (update)

**Last Updated:** February 16, 2026
'@
Set-Content -Path "$repoRoot\docs\logic\edit-recent-entry.md" -Value $content -Encoding UTF8
Write-Host "Created docs/logic/edit-recent-entry.md" -ForegroundColor Cyan

# Create docs/logic/get-entries.md
$content = @'
# Nutrition: Get Entries - Logic Flow

**Purpose:** Retrieve entries within a time window  
**Type:** Helper shortcut  
**Invocation:** Via "Run Shortcut" action

## Input Parameters

- **hours_back** (Number): How many hours to look back

## Output

- **Filtered Entries** (List): Entries within the time window

## Logic Flow

### Step 1: Receive Input
```
Shortcut Input → Hours Back
```

### Step 2: Calculate Time Boundaries
```
Current Date → Now
Adjust Date: Now - Hours Back hours → Start Time
Adjust Date: Now - 24 hours → 24 Hours Ago
```

### Step 3: Initialize Collections
```
List (empty) → All Entries
List (empty) → Empty List (for defaults)
```

### Step 4: Query Today
```
Format Date: Now → yyyy_MM_dd
Text: "nutrition_[date]"
Get Value (Data Jar):
  If value does not exist: Empty List

If Value has any value
  THEN:
    Repeat with Each in Value:
      Add to All Entries
```

### Step 5: Query Yesterday
```
Adjust Date: Now - 1 day
Format Date → yyyy_MM_dd
Text: "nutrition_[date]"
Get Value (Data Jar):
  If value does not exist: Empty List

If Value has any value
  THEN:
    Repeat: Add to All Entries
```

### Step 6: Query 2 Days Ago
```
(Same pattern as Step 5, -2 days)
```

### Step 7: Set Entries List
```
Set Variable: Entries List = All Entries
```

### Step 8: Initialize Filtered List
```
List (empty) → Filtered Entries
```

### Step 9: Filter by Time Window
```
Count: Entries List

If Count > 0
  THEN:
    Repeat with Each in Entries List:
      Get timestamp from entry
      
      If timestamp is after 24 Hours Ago
        AND timestamp is after Start Time
        THEN:
          Add to Filtered Entries
```

### Step 10: Ensure Valid Output
```
If Filtered Entries does not have any value
  THEN:
    List (empty) → Filtered Entries
```

### Step 11: Return Results
```
Output: Filtered Entries
```

## Error Handling

- Missing date keys: Empty list default
- Empty results: Valid empty list returned
- Invalid timestamps: Not explicitly handled

## Performance

**Query Scope:** Always queries 3 date keys

**Execution Time:**
- Empty days: < 0.5 seconds
- Typical (20 entries): ~1 second
- Heavy (100 entries): ~2 seconds

**Last Updated:** February 16, 2026
'@
Set-Content -Path "$repoRoot\docs\logic\get-entries.md" -Value $content -Encoding UTF8
Write-Host "Created docs/logic/get-entries.md" -ForegroundColor Cyan

# Create docs/logic/calculate-stats.md
$content = @'
# Nutrition: Calculate Stats - Logic Flow

**Purpose:** Aggregate nutrition statistics from entry list  
**Type:** Helper shortcut  
**Invocation:** Via "Run Shortcut" action

## Input Parameters

- **entries** (List): List of nutrition entry dictionaries

## Output

- **stats** (Dictionary): Aggregated statistics

## Output Schema
```json
{
  "item_count": Number,
  "total_calories": Number,
  "total_carbs": Number,
  "unknown_count": Number
}
```

## Logic Flow

### Step 1: Receive Input
```
Shortcut Input (entries list)
```

### Step 2: Initialize Counters
```
Total Calories = 0
Total Carbs = 0
Item Count = 0
Unknown Count = 0
```

### Step 3: Check if Entries Exist
```
Count: Shortcut Input

If Count > 0
  THEN: Continue to Step 4
  OTHERWISE: Skip to Step 5 with zeros
```

### Step 4: Process Each Entry
```
Repeat with Each in Shortcut Input:
  
  Increment Item Count
  
  Get calories:
    If does not have value
      THEN: Entry Calories = 0
      OTHERWISE: Entry Calories = value
  
  Get carbs:
    If does not have value
      THEN: Entry Carbs = 0
      OTHERWISE: Entry Carbs = value
  
  If Entry Calories is 0
    THEN: Increment Unknown Count
  
  Add Entry Calories to Total Calories
  Add Entry Carbs to Total Carbs
```

### Step 5: Build Result Dictionary
```
Dictionary:
  - item_count: Item Count
  - total_calories: Total Calories
  - total_carbs: Total Carbs
  - unknown_count: Unknown Count
```

### Step 6: Return Result
```
Output: Dictionary
```

## Error Handling

- Empty input: Returns all zeros
- Missing dictionary keys: Default to 0
- Invalid values: Not explicitly handled

## Calculation Logic

**Unknown Count:** An entry is "unknown" if calories = 0

## Performance

**Typical Execution:**
- 10 entries: < 0.3 seconds
- 50 entries: < 0.5 seconds
- 100 entries: < 1 second

**Operations per Entry:** ~6 operations

**Last Updated:** February 16, 2026
'@
Set-Content -Path "$repoRoot\docs\logic\calculate-stats.md" -Value $content -Encoding UTF8
Write-Host "Created docs/logic/calculate-stats.md" -ForegroundColor Cyan

Write-Host ""
Write-Host "Logic documentation created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Files created:" -ForegroundColor Yellow
Write-Host "  - docs/logic/log-nutrition.md"
Write-Host "  - docs/logic/nutrition-summary.md"
Write-Host "  - docs/logic/edit-recent-entry.md"
Write-Host "  - docs/logic/get-entries.md"
Write-Host "  - docs/logic/calculate-stats.md"
Write-Host ""
Write-Host "Next: Run populate-test-docs.ps1 for test documentation" -ForegroundColor Cyan