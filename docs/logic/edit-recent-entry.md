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
  Format Date: Now ->' yyyy_MM_dd
  Text: "nutrition_[date]"
  Get Value: If does not exist ->' Empty List
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
Format Date ->' yyyy_MM_dd
Text: "nutrition_[date]"
Set Variable: Entry Date Key
```

### Step 13: Extract Current Values
```
Get from Entry to Edit:
  - item ->' Current Item
  - calories ->' Current Calories
  - carbs ->' Current Carbs
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
