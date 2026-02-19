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

### Step 4: Show Confirmation Menu with Timing Choice
```
ACTION: Current Date
OUTPUT: Current Date

ACTION: Format Date
  Date: Current Date
  Format: Custom "HH:mm"
OUTPUT: Formatted Date

ACTION: Text
  Content: 
    "Item: " + Item + "\n"
    "Calories: " + Calories + "\n"
    "Carbs: " + Carbs + "g\n"
    "Time: " + Formatted Date
OUTPUT: Confirmation Text

ACTION: Choose from Menu
  Prompt: Confirmation Text + "\nLog Now, Log Earlier, or Cancel?"
  Options:
    - "Log Now"
    - "Log Earlier"
    - "Cancel"
```

### OPTION 1: "Log Now"
```
ACTION: Current Date
OUTPUT: Current Date

ACTION: Set Variable
  Name: Entry Time
  Value: Current Date

[Continue with Session ID generation, save logic...]
```

### OPTION 2: "Log Earlier"
```
ACTION: Ask for Input
  Type: Number
  Prompt: "How many minutes ago?"
  Default: 15

ACTION: Current Date
OUTPUT: Current Date

ACTION: Adjust Date
  Operation: Subtract
  Amount: Provided Input
  Units: minutes
OUTPUT: Adjusted Date

ACTION: Set Variable
  Name: Entry Time
  Value: Adjusted Date

[Continue with Session ID generation, save logic...]
```

### OPTION 3: "Cancel"
```
ACTION: Show Notification
  Text: "Entry cancelled"

ACTION: Stop Shortcut
```

### Step 5: Get Existing Entries
```
Get Value (Data Jar): Data Key
  If value does not exist: Empty List

If Value does not have any value
  THEN: List (empty) ->' Existing Entries
  OTHERWISE: Value ->' Existing Entries
```

### Step 6: Create Entry Dictionary
```
Dictionary:
  - timestamp: Entry Time
  - item: Item
  - calories: Calories
  - carbs: Carbs
  - session_id: Session ID
```

### Step 7: Add Entry to List
```
Add to Variable: Existing Entries = Dictionary
```

### Step 8: Save to Data Jar
```
Set Value (Data Jar):
  Key Path: Data Key
  Value: Existing Entries
  Allow Overwriting: Yes
```

### Step 9: Show Success Notification
```
Show Notification: "Logged: [Item] at [time]"
```

### Step 10: Cancel Option
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
