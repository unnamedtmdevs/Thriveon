# Thriveon - Personal Lifestyle & Habit Tracking App

![iOS](https://img.shields.io/badge/iOS-15.6+-blue.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0+-orange.svg)

## Overview

Thriveon is a vibrant lifestyle app designed to enrich everyday life, promote personal development, and cultivate hobbies. This app offers users tools and insights to enhance their daily routines dynamically and interactively.

## Features

### 🎯 Core Features

- **Onboarding Flow**: Smooth, interactive onboarding experience with personalized setup
- **Personal Dashboard**: Comprehensive view of daily habits, progress tracking, and motivational content
- **Habit Tracker**: Create, manage, and track custom habits with beautiful visualizations
- **Analytics & Insights**: Detailed analysis of productivity, habits, and personal growth trends
- **Daily Motivation**: Rotating daily quotes to inspire and motivate users
- **User Profile & Settings**: Customizable user preferences and data management
- **Seed Data**: Pre-populated test data for immediate demonstration and testing (8 sample habits with realistic history)

### 📊 Analytics Features

- Current streak tracking
- Longest streak achievements
- Completion rate calculations
- Weekly progress visualization
- Category breakdown analysis
- Top performing habits

### 🎨 Design

- **Background Color**: `#1D1F30` - Deep, calming background
- **Accent Color**: `#FE284A` - Vibrant, energetic accent
- **Design Style**: Modern, clean, gesture-based navigation with smooth animations
- **Responsive**: Fully responsive design supporting iPhone (all sizes) and iPad Air 11-inch

## Project Structure

```
Thriveon/
├── App/
│   └── ThriveonApp.swift           # Main app entry point
├── Core/
│   ├── Theme.swift                 # App-wide theme and styling
│   └── PreviewHelpers.swift        # SwiftUI preview utilities
├── Models/
│   ├── UserProfile.swift           # User data model
│   └── HabitModel.swift            # Habit tracking model
├── Services/
│   ├── DataService.swift           # Data persistence and management
│   └── AnalyticsService.swift     # Analytics and insights generation
├── ViewModels/
│   ├── OnboardingViewModel.swift   # Onboarding logic
│   └── DashboardViewModel.swift    # Dashboard data management
├── Views/
│   ├── OnboardingView.swift        # Onboarding screens
│   ├── MainView.swift              # Main container with tab navigation
│   ├── DashboardView.swift         # Home dashboard
│   ├── HabitsView.swift            # Habits list
│   ├── AddHabitView.swift          # Habit creation
│   ├── HabitDetailView.swift       # Individual habit details
│   ├── AnalyticsView.swift         # Analytics and insights
│   └── SettingsView.swift          # User settings
├── Components/
│   ├── HabitCard.swift             # Reusable habit card
│   ├── StatCard.swift              # Statistics display card
│   └── ProgressBar.swift           # Progress visualization
├── Utilities/
│   └── Constants.swift             # App-wide constants
└── Resources/
    └── Assets.xcassets             # Colors and images
```

## Architecture

### MVVM Pattern

The app follows the Model-View-ViewModel (MVVM) architecture:

- **Models**: Pure data structures (UserProfile, Habit)
- **Views**: SwiftUI views for UI presentation
- **ViewModels**: Business logic and state management
- **Services**: Data persistence, analytics, and shared functionality

### State Management

- `@StateObject` and `@ObservedObject` for reactive state
- `@AppStorage` for persistent onboarding state
- `UserDefaults` for data persistence via DataService
- Combine framework for reactive data flow

## Key Components

### Data Service
Centralized data management using UserDefaults for:
- User profile storage
- Habit CRUD operations
- Completion tracking
- Streak calculations

### Analytics Service
Generates insights including:
- Completion rates
- Weekly progress charts
- Category breakdowns
- Top performing habits
- Daily motivational quotes

### Theme System
Centralized theming with:
- Color tokens from Assets.xcassets
- Consistent spacing scale (4, 8, 12, 16, 24, 32)
- Typography system using SF Rounded
- Corner radius standards

## Building & Running

### Requirements
- Xcode 14.0+
- iOS 15.6+ Simulator or Device
- macOS 12.0+

### Build Instructions

```bash
# Clone the repository
cd Thriveon

# Build for simulator
xcodebuild build -scheme "Thriveon" -destination 'generic/platform=iOS Simulator'

# Or open in Xcode
open Thriveon.xcodeproj
```

### Seed Data (Test Data)

The app can optionally include pre-populated test data for demonstration:
- **8 sample habits** with realistic completion history
- **User profile** with statistics (200+ completions, 15+ day streaks)
- **Varied categories**: Mindfulness, Health & Fitness, Learning, Productivity, Creativity

**Current state: DISABLED** - App starts empty by default

To enable seed data:
- Open `Services/SeedDataService.swift`
- Set `static let useSeedData = true`

For more details, see [SEED_DATA.md](SEED_DATA.md)

### Preview Devices

The app includes SwiftUI previews for:
- iPhone SE (3rd generation) - Small screen
- iPhone 15 Pro Max - Large screen
- iPad Air 11-inch (M2) - Tablet

## Features Implementation

### Habit Tracking
- ✅ Create custom habits with categories
- ✅ Set goals and reminders
- ✅ Daily completion tracking
- ✅ Streak calculation
- ✅ Completion rate analytics

### Analytics
- ✅ Visual progress charts
- ✅ Category distribution
- ✅ Weekly completion graphs
- ✅ Top performers ranking
- ✅ Real-time statistics

### User Experience
- ✅ Smooth onboarding
- ✅ Gesture-based interactions
- ✅ Responsive layouts
- ✅ Dark theme optimized
- ✅ No placeholders - all features functional

## Data Persistence

All data is stored locally using UserDefaults:
- User profile and preferences
- Habit definitions
- Completion history
- Daily quote rotation

## Accessibility

- VoiceOver support through semantic SwiftUI components
- Dynamic Type support
- High contrast color scheme
- Minimum 44pt touch targets

## iOS Compatibility

- **Minimum**: iOS 15.6
- **Target**: iOS 17.5
- No iOS 16/17 exclusive features used
- Full backward compatibility maintained

## Privacy & Compliance

- All data stored locally on device
- No external data collection
- No third-party analytics
- Complies with App Store guidelines

## Future Enhancements

Potential features for future releases:
- iCloud sync
- Widgets
- Apple Watch companion app
- Notifications and reminders
- Export data functionality
- Social sharing

## 📚 Documentation

- **README.md** - Project overview (this file)
- **FEATURES.md** - Detailed feature documentation
- **PROJECT_SUMMARY.md** - Complete project summary
- **QUICK_START.md** - 60-second getting started guide
- **SEED_DATA.md** - Test data documentation (NEW!)

## License

Copyright © 2026 Simon Bakhanets. All rights reserved.

## Contact

For questions or support, please contact the development team.

---

**Built with ❤️ using SwiftUI**
