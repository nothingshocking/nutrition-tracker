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
