# Nutrition Tracker for Endurance Sports

A voice-activated nutrition tracking system built on iOS Shortcuts,
designed for endurance athletes who need hands-free logging and
real-time statistics during long training sessions and events.

## Overview

Track nutrition intake during cycling, running, triathlon,
ultramarathon, or any endurance activity without breaking focus.
Voice commands enable logging while moving, with real-time
summaries to monitor fueling strategy.

## Key Features

- Voice-Activated Logging - Log items hands-free via Siri
- Backdated Entries - Record items consumed minutes ago
- Real-Time Statistics - Check calories/hr and carbs/hr mid-activity
- Edit Incomplete Entries - Update items where values were unknown
- Session Tracking - Automatic grouping of entries by date/time
- Performance Optimized - Efficient queries with thousands of entries

## Quick Start

See [docs/quick-start.md](docs/quick-start.md) for 10-minute setup.

## Installation

### Prerequisites

- iPhone with iOS 26.0 or later
- Data Jar app (free from App Store)
- iCloud enabled (recommended)

### Download Shortcuts

Download all 5 files from shortcuts/release/:

1. Log Nutrition.shortcut
2. Nutrition Summary.shortcut
3. Edit Recent Entry.shortcut
4. Nutrition Get Entries.shortcut
5. Nutrition Calculate Stats.shortcut

IMPORTANT: Use shortcuts/release/ files (not shortcuts/latest/)

### Import to iPhone

1. Tap each .shortcut file
2. Tap "Add Shortcut"
3. Verify all 5 appear in Shortcuts app

### Critical: Verify Helper Names

After importing, check these exact names in Shortcuts app:

| Shortcut | Required Name |
|----------|---------------|
| Helper 1 | Nutrition: Get Entries |
| Helper 2 | Nutrition: Calculate Stats |

Note the colon after "Nutrition" - this is required.

If missing, long press ->' Rename ->' add the colon.

### Set Up Siri

- "Log food" ->' Log Nutrition
- "Fuel check" ->' Nutrition Summary

See [docs/installation.md](docs/installation.md) for full details.

## Usage

### Log Nutrition

"Hey Siri, log food"

1. Speak item name
2. Enter calories (0 if unknown)
3. Enter carbs in grams (0 if unknown)
4. Choose timing (Just now / Earlier)
5. Confirm to save

### Check Statistics

"Hey Siri, fuel check"

Enter hours to review. Output example:
```
Last 3 hours:

Items: 5
Calories: 450 (150/hr)
Carbs: 95g (32g/hr)

Items without data: 1
```

### Edit Incomplete Entries

1. Open Shortcuts app
2. Run "Edit Recent Entry"
3. Select item
4. Enter correct values

## Repository Structure
```
nutrition-tracker/
|-- shortcuts/
|   |-- latest/     <- Development files (hyphenated names)
|   -- release/    <- Import-ready files (correct iOS names)
|-- docs/
|   |-- quick-start.md
|   |-- user-guide.md
|   |-- installation.md
|   |-- architecture.md
|   -- logic/      <- Pseudocode for each shortcut
-- tests/
    |-- test-plan.md
    -- field-test-template.md
```

## Documentation

- [Quick Start](docs/quick-start.md)
- [User Guide](docs/user-guide.md)
- [Installation](docs/installation.md)
- [Architecture](docs/architecture.md)

## Roadmap

**v1.0** (Current)
- Core logging and summary
- Voice activation
- Edit functionality
- Performance optimization

**v1.1** (Planned)
- Quick Log menu for common items
- CSV export for analysis
- Automated backup to iCloud Drive
- Enhanced edit function: Edit any recent entry (not just incomplete)

**v2.0** (Future)
- Apple Watch support
- Training platform integration
- Predictive alerts

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - See [LICENSE](LICENSE) for details.

## Version

**Version:** 1.0.1  
**Last Updated:** February 18, 2026  
**Compatibility:** iOS 26.0+
