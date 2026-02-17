# Nutrition Tracker for Endurance Sports

A voice-activated nutrition tracking system built on iOS Shortcuts, designed for endurance athletes who need hands-free logging and real-time statistics during long training sessions and events.

## Overview

Track nutrition intake during cycling, running, triathlon, ultramarathon, or any endurance activity without breaking focus. Voice commands enable logging while moving, with real-time summaries to monitor fueling strategy.

### Key Features

- **Voice-Activated Logging** - Log items hands-free via Siri
- **Backdated Entries** - Record items consumed minutes or hours ago
- **Real-Time Statistics** - Check calories/hour and carbs/hour mid-activity
- **Edit Incomplete Entries** - Update items where nutrition info was unknown
- **Session Tracking** - Automatic grouping of entries by date/time
- **Performance Optimized** - Efficient queries even with thousands of entries

## Quick Start

### Prerequisites

- iPhone with iOS 26.0 or later
- [Data Jar](https://apps.apple.com/app/data-jar/id1453273600) app (free)
- iCloud enabled (recommended for data sync)

### Installation

1. **Install Data Jar** from the App Store

2. **Import Shortcuts**
   - Download all `.shortcut` files from [shortcuts/latest/](shortcuts/latest/)
   - Open each file on your iPhone
   - Tap "Add Shortcut" to import

3. **Set Up Siri Commands** (Recommended)
   - Open each shortcut in Shortcuts app
   - Long press → Details
   - Add to Siri with your preferred phrase:
     - "Log food" → Log Nutrition
     - "Fuel check" → Nutrition Summary

4. **Test the System**
   - Say "Hey Siri, log food"
   - Log a test entry
   - Say "Hey Siri, fuel check"
   - Verify it shows your test entry

See [docs/installation.md](docs/installation.md) for detailed setup instructions.

## Usage

### Logging Nutrition

**Voice Command:** "Hey Siri, log food"

1. Speak the item name when prompted
2. Enter calories (or 0 if unknown)
3. Enter carbs in grams (or 0 if unknown)
4. Choose timing: "Just now" or "Earlier"
5. Confirm to save

### Checking Statistics

**Voice Command:** "Hey Siri, fuel check"

Enter the number of hours to look back (e.g., 3 for last 3 hours).

**Output Example:**
```
Last 3 hours:

Items: 5
Calories: 450 (150/hr)
Carbs: 95g (32g/hr)

Items without data: 1
```

### Editing Incomplete Entries

1. Open Shortcuts app
2. Run "Edit Recent Entry"
3. Select the item from the list
4. Enter correct calories and carbs
5. Entry is updated in your history

## Documentation

- [Quick Start Guide](docs/quick-start.md) - Get running in 10 minutes
- [User Guide](docs/user-guide.md) - Comprehensive usage instructions
- [Installation Guide](docs/installation.md) - Detailed setup
- [Architecture](docs/architecture.md) - System design and technical details
- [Test Plan](tests/test-plan.md) - Testing strategy and results

## System Architecture

### Components

**User-Facing Shortcuts:**
- Log Nutrition - Create new nutrition entry
- Nutrition Summary - Display statistics for a time window
- Edit Recent Entry - Update entries with missing data

**Helper Shortcuts:**
- Nutrition: Get Entries - Retrieve entries within time range
- Nutrition: Calculate Stats - Compute totals and averages

### Data Structure

Entries stored in Data Jar using hierarchical date-based keys for efficient querying.

See [docs/architecture.md](docs/architecture.md) for complete technical details.

## Roadmap

**v1.0** ✅ (Current)
- Core logging and summary features
- Voice activation
- Edit functionality
- Performance optimization

**v1.1** (Planned)
- Quick Log menu for common items
- CSV export for analysis
- Automated backup to iCloud Drive

**v2.0** (Future)
- Apple Watch companion app
- Integration with training platforms
- Predictive alerts
- Advanced analytics

## Contributing

Feedback and contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

To report issues or suggest features, please use GitHub Issues.

## License

MIT License - See [LICENSE](LICENSE) for details.

## Support

- [User Guide](docs/user-guide.md) for detailed instructions
- [Troubleshooting](docs/user-guide.md#troubleshooting) for common issues
- GitHub Issues for bugs and feature requests

---

**Version:** 1.0.0  
**Last Updated:** February 16, 2026  
**Compatibility:** iOS 26.0+
