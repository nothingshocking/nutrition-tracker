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
Shortcut Input â†’ Hours Back
```

### Step 2: Calculate Time Boundaries
```
Current Date â†’ Now
Adjust Date: Now - Hours Back hours â†’ Start Time
Adjust Date: Now - 24 hours â†’ 24 Hours Ago
```

### Step 3: Initialize Collections
```
List (empty) â†’ All Entries
List (empty) â†’ Empty List (for defaults)
```

### Step 4: Query Today
```
Format Date: Now â†’ yyyy_MM_dd
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
Format Date â†’ yyyy_MM_dd
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
List (empty) â†’ Filtered Entries
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
    List (empty) â†’ Filtered Entries
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
