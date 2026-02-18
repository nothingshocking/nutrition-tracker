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
  Current Date ->' Entry Time

OPTION 2: "Earlier"
  Ask for Input: Minutes ago
  Current Date - Minutes ->' Entry Time
```

### Step 5: Generate Session ID
```
Format Date: Entry Time ->' yyyyMMdd_HHmm
Text: "session_" + Formatted Date
Set Variable: Session ID
```

### Step 6: Generate Data Key
```
Format Date: Entry Time ->' yyyy_MM_dd
Text: "nutrition_" + Formatted Date
Set Variable: Data Key
```

### Step 7: Format Display Time
```
Format Date: Entry Time ->' HH:mm
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
  THEN: List (empty) ->' Existing Entries
  OTHERWISE: Value ->' Existing Entries
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
