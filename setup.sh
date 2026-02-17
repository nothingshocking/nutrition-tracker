#!/bin/bash

# Nutrition Tracker Repository Setup Script
# Version 1.0.0

echo "Setting up Nutrition Tracker repository..."

# Create directory structure
echo "Creating folder structure..."
mkdir -p shortcuts/latest
mkdir -p docs/logic
mkdir -p tests
mkdir -p .github/ISSUE_TEMPLATE

# Create main files
echo "Creating main files..."

cat > README.md << 'EOF'
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
EOF

cat > CHANGELOG.md << 'EOF'
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned
- Quick Log menu for common items
- CSV export functionality
- Automated backup to iCloud Drive
- Session-based filtering and views

## [1.0.0] - 2026-02-16

### Added
- Voice-activated nutrition logging via Siri
- Real-time nutrition summary with per-hour statistics
- Backdated entry support (specify minutes ago)
- Edit function for incomplete entries (last 72 hours)
- Automatic session ID generation for ride grouping
- Hierarchical date-based data structure
- Modular architecture with reusable helper shortcuts
- Comprehensive error handling
- Performance optimization (queries only last 3 days)
- Input validation (prevents negative values, decimals)

### Technical
- Created 5 shortcuts: Log Nutrition, Nutrition Summary, Edit Recent Entry, Get Entries (helper), Calculate Stats (helper)
- Implemented "If value does not exist" handling for missing Data Jar keys
- Date-based key partitioning for efficient queries

### Documentation
- Complete README with installation and usage
- Architecture documentation
- Pseudocode logic documentation
- User guide with troubleshooting
- Test plan and test results

### Fixed
- Carbs total showing double value
- Variable name conflicts
- Entry duplication on edit

### Known Issues
- Data Jar offline behavior untested
- No automated backup

---

**Version History:**
- **1.0.0** - MVP complete, ready for field testing
EOF

cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2026 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

cat > .gitignore << 'EOF'
# macOS
.DS_Store
.AppleDouble
.LSOverride
._*

# Directories potentially created on remote AFP share
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns

# Test data
test-data/
*.csv

# Personal notes
notes/
todo.md
scratch.md

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# Backup files
*.bak
*.backup

# Logs
*.log
EOF

cat > CONTRIBUTING.md << 'EOF'
# Contributing to Nutrition Tracker

Thank you for your interest in contributing!

## How to Contribute

### Reporting Bugs

1. Check existing issues to see if it's already reported
2. Use the bug report template
3. Provide detailed information with steps to reproduce

### Suggesting Features

1. Check existing feature requests
2. Use the feature request template
3. Describe the use case

### Documentation Contributions

Documentation improvements are always welcome! Fork, make changes, and submit a PR.

### Shortcut Contributions

1. Document the change in pseudocode
2. Update relevant `.md` files in `docs/logic/`
3. Export the modified `.shortcut` file
4. Submit PR with description and test results

## Development Guidelines

### Shortcut Design Principles

1. **Modularity** - Extract reusable logic
2. **Error handling** - Gracefully handle failures
3. **User feedback** - Clear notifications
4. **Performance** - Minimize operations
5. **Simplicity** - Fewest steps to goal

### Testing Requirements

- Runs without errors
- Tested with empty data
- Tested with existing data
- Edge cases considered
- Documentation updated

## License

By contributing, you agree your contributions will be licensed under the MIT License.

---

**Last Updated:** February 16, 2026
EOF

# Create placeholder for shortcuts
cat > shortcuts/latest/README.md << 'EOF'
# Shortcuts

Place the following `.shortcut` files in this directory:

1. `log-nutrition.shortcut` - Main logging interface
2. `nutrition-summary.shortcut` - Statistics display
3. `edit-recent-entry.shortcut` - Edit incomplete entries
4. `get-entries.shortcut` - Helper: Query entries
5. `calculate-stats.shortcut` - Helper: Calculate statistics

## Exporting from iPhone

1. Open Shortcuts app
2. Long press each shortcut
3. Tap "Share"
4. Save to Files or AirDrop to computer
5. Place in this directory

## Importing to iPhone

1. Transfer `.shortcut` files to iPhone
2. Tap each file
3. Tap "Add Shortcut"
EOF

# Create docs files
cat > docs/quick-start.md << 'EOF'
# Quick Start Guide

Get up and running in 10 minutes.

## 1. Install (3 minutes)

1. Install Data Jar from App Store
2. Download all 5 `.shortcut` files
3. Tap each to import → "Add Shortcut"

## 2. Set Up Voice (2 minutes)

1. Long-press "Log Nutrition" → Details → Add to Siri: "Log food"
2. Long-press "Nutrition Summary" → Details → Add to Siri: "Fuel check"

## 3. Test It (5 minutes)

1. Say "Hey Siri, log food"
2. Enter: "Test Gel", 100 calories, 25g carbs, "Just now"
3. Say "Hey Siri, fuel check"
4. Enter: 1 hour

✅ You should see your test entry!

## Next Steps

- Read [User Guide](user-guide.md)
- Test on short training session
- Explore edit function

---

**You're ready!** 🚴‍♂️
EOF

# Create GitHub issue templates
cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug report
about: Report a bug or issue
title: '[BUG] '
labels: bug
---

**Describe the bug**
Clear description of what the bug is.

**To Reproduce**
1. Run shortcut '...'
2. Enter values '...'
3. See error

**Expected behavior**
What you expected to happen.

**Environment:**
 - Device: [e.g. iPhone 14 Pro]
 - iOS Version: [e.g. 26.2.1]
 - System Version: [e.g. v1.0.0]

**Screenshots**
If applicable, add screenshots.
EOF

cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature request
about: Suggest an idea
title: '[FEATURE] '
labels: enhancement
---

**Is your feature request related to a problem?**
Description of the problem.

**Describe the solution you'd like**
What you want to happen.

**Use case**
When and how you would use this.

**Priority**
- [ ] Critical
- [ ] High
- [ ] Medium
- [ ] Low
EOF

# Create placeholder files for docs
touch docs/architecture.md
touch docs/user-guide.md
touch docs/installation.md
touch docs/logic/log-nutrition.md
touch docs/logic/nutrition-summary.md
touch docs/logic/edit-recent-entry.md
touch docs/logic/get-entries.md
touch docs/logic/calculate-stats.md
touch tests/test-plan.md
touch tests/field-test-template.md

echo ""
echo "✅ Repository structure created!"
echo ""
echo "Next steps:"
echo "1. The main files (README, CHANGELOG, LICENSE, etc.) are complete"
echo "2. Documentation files in docs/ are created as placeholders"
echo "3. Copy the full content for documentation files from the conversation"
echo "4. Add your .shortcut files to shortcuts/latest/"
echo "5. Run: git init && git add . && git commit -m 'Initial commit'"
echo ""
echo "Repository is ready at: $(pwd)"