# DailyPulse - Setup & Run Guide

## Prerequisites

Before running this project, make sure you have:

1. **Flutter SDK** installed (version 3.x or higher)
   - Download from: https://flutter.dev/docs/get-started/install
   - Verify installation: Run `flutter doctor`

2. **Android Studio** or **VS Code** with Flutter extensions
3. **Android SDK** (for Android development)
4. **Android Emulator** or **Physical Device**

## Setup Steps

### 1. Install Dependencies

Open terminal in the project root directory and run:

```bash
flutter pub get
```

This will install all required packages:
- `shared_preferences` - For local data storage
- `google_fonts` - For beautiful typography
- `intl` - For date/time formatting

### 2. Run the App

#### On Android Emulator
1. Start an Android emulator
2. Run the command:
```bash
flutter run
```

#### On Physical Android Device
1. Enable USB debugging on your device
2. Connect via USB
3. Run: `flutter run`

#### On iOS Simulator (Mac only)
1. Open iOS Simulator
2. Run: `flutter run`

### 3. Build for Release

To create an APK for testing:
```bash
flutter build apk
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

## Project Structure Explained

```
dailypulse/
├── lib/
│   ├── main.dart                 # App entry point, theme & navigation
│   ├── models/
│   │   └── mood_entry.dart       # Mood data model with JSON serialization
│   ├── services/
│   │   └── mood_storage.dart     # Local storage service using SharedPreferences
│   └── screens/
│       ├── mood_log_screen.dart      # Emoji selection & mood logging
│       ├── mood_history_screen.dart   # Scrollable history with ListView
│       └── analytics_screen.dart      # Statistics & mood insights
├── android/                      # Android-specific files
├── pubspec.yaml                  # Dependencies & project config
└── README.md                     # Project documentation
```

## Troubleshooting

### Common Issues

#### 1. "SDK not found" error
**Solution**: Make sure Flutter SDK is properly installed and added to PATH
- Run: `flutter doctor` to check setup
- Run: `flutter doctor --android-licenses` to accept licenses

#### 2. "Gradle build failed"
**Solution**: 
- Delete `android/.gradle` folder
- Delete `build` folder
- Run: `flutter clean`
- Run: `flutter pub get`
- Run: `flutter run` again

#### 3. "Package not found"
**Solution**: 
- Run: `flutter pub get`
- Make sure you have internet connection
- Check `pubspec.yaml` for correct package names

#### 4. Emulator not starting
**Solution**:
- Check Android Studio SDK settings
- Verify emulator is created in AVD Manager
- Try: `flutter emulators --launch <emulator_id>`

## Testing the App

### Basic Functionality Tests

1. **Mood Logging**
   - Open the app
   - Select an emoji
   - Add optional note
   - Tap "Save My Mood"
   - Verify success message

2. **View History**
   - Navigate to "History" tab
   - Verify mood entry appears
   - Try deleting an entry

3. **Analytics**
   - Navigate to "Analytics" tab
   - Verify statistics appear
   - Check positive/negative day counts

4. **Dark Mode**
   - Tap theme toggle icon in app bar
   - Verify dark mode activates
   - Test all screens in dark mode

5. **Data Persistence**
   - Close the app completely
   - Reopen the app
   - Verify mood history persists

## Development Notes

### Adding Features
- New screens should be added to `lib/screens/`
- New services should be added to `lib/services/`
- Models go in `lib/models/`

### State Management
- Currently uses `setState` as required
- Can be easily upgraded to Provider, Bloc, or Riverpod

### Styling
- Uses Material Design 3
- Google Fonts (Inter) for typography
- Consistent spacing: 8, 12, 16, 20, 32, 40
- Border radius: 12-16px for cards

## Performance Tips

- ListView.builder is used for efficient scrolling
- SharedPreferences is lightweight for small data
- No unnecessary rebuilds with proper state management
- Images are replaced with emojis for zero external resources

## Support

For issues or questions:
1. Check Flutter documentation: https://flutter.dev/docs
2. Review error messages in terminal
3. Use `flutter doctor` for setup issues
4. Check dependencies in `pubspec.yaml`

## License

Educational project - Free to use and modify.

