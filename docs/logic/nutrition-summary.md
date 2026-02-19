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
  - item_count ->' Item Count
  - total_calories ->' Total Calories
  - total_carbs ->' Total Carbs
  - unknown_count ->' Unknown Count
```

### Step 10: Calculate Calories Per Hour
```
Calculate: Total Calories / Hours Back
Round to: Ones Place
Set Variable: Cal Per Hour
```

**Note:** Earlier versions (v1.0.0) incorrectly used + (addition) instead of ÷ (division), 
resulting in Cal Per Hour showing as Total Calories + Hours Back instead of the proper rate.
This was fixed in v1.0.1.


### Step 11: Calculate Carbs Per Hour
```
Calculate: Total Carbs / Hours Back
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
