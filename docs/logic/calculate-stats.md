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
