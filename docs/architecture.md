# System Architecture

## Overview

The Nutrition Tracker is built using iOS Shortcuts and Data Jar, following a modular architecture with separation of concerns between user-facing features and reusable business logic.

## High-Level Architecture
```
User Interface Layer
  - Siri Voice Commands
  - Shortcuts UI (dialogs/menus)
  - Data Jar UI (data inspection)

Business Logic Layer
  Main Shortcuts:
    - Log Nutrition
    - Nutrition Summary
    - Edit Recent Entry
  Helper Shortcuts:
    - Nutrition: Get Entries
    - Nutrition: Calculate Stats

Data Layer
  - Data Jar
  - nutrition_2026_02_16 (today)
  - nutrition_2026_02_15 (yesterday)
  - nutrition_2026_02_14 (2 days ago)
```

## Component Details

### User-Facing Shortcuts

#### 1. Log Nutrition
**Purpose:** Create new nutrition entries  
**Type:** User-facing  
**Invocation:** Siri voice command

**Flow:**
1. Collect user input (item, calories, carbs, timing)
2. Generate timestamp (current or backdated)
3. Generate session_id
4. Create data key (nutrition_YYYY_MM_DD)
5. Load existing entries for that date (or create empty list)
6. Append new entry
7. Save back to Data Jar
8. Confirm to user

#### 2. Nutrition Summary
**Purpose:** Display nutrition statistics  
**Type:** User-facing  
**Invocation:** Siri voice command

**Flow:**
1. Get hours back from user
2. Call Get Entries helper
3. Call Calculate Stats helper
4. Extract statistics
5. Calculate per-hour rates
6. Format and display summary

#### 3. Edit Recent Entry
**Purpose:** Update entries with missing data  
**Type:** User-facing  
**Invocation:** Manual (Shortcuts app)

**Flow:**
1. Query last 72 hours
2. Filter for incomplete entries
3. Build menu
4. User selects entry
5. Display current values
6. Prompt for new values
7. Update in Data Jar

### Helper Shortcuts

#### 4. Nutrition: Get Entries
**Purpose:** Retrieve entries within time window  
**Interface:** Input: hours_back, Output: entries list

**Flow:**
1. Calculate time window
2. Query 3 date keys (today, yesterday, 2 days ago)
3. Combine entries
4. Filter by timestamp
5. Return filtered list

#### 5. Nutrition: Calculate Stats
**Purpose:** Aggregate nutrition statistics  
**Interface:** Input: entries list, Output: stats dictionary

**Flow:**
1. Initialize counters
2. Process each entry
3. Sum totals
4. Count unknowns
5. Return statistics

## Data Models

### Entry Schema
- timestamp: Date
- item: String
- calories: Number
- carbs: Number
- session_id: String

### Storage Structure
Keys: nutrition_YYYY_MM_DD
Each key contains: List of entries

## Design Decisions

### Modular Architecture
- Helper shortcuts extract common logic
- Single source of truth
- Easier testing and maintenance

### Date-Based Partitioning
- Query only relevant dates
- Scales to thousands of entries
- Natural for events

### Allow Zero Values
- Partial data better than no data
- Log and fix workflow
- Edit function targets 0-value entries

## Performance

**Query Performance:**
- Get Entries: < 1 second (typical)
- Calculate Stats: < 0.5 seconds
- Edit: 2-3 seconds

**Scalability:**
- Handles ~10,000 entries
- Typical usage: 500-2000 entries/year

## Security & Privacy

- All data stored locally
- No network transmission
- Optional iCloud sync (encrypted)
- No third-party access

**Last Updated:** February 16, 2026  
**Version:** 1.0.0
