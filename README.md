# DailyPulse - Daily Mood Tracker

A modern Flutter mobile application that helps users log their daily emotional state, view past entries, and reflect on their mood patterns. Features Firebase Authentication for secure user accounts and Cloud Firestore for cross-device synchronization.

## 🌟 Features

### Core Features

#### Mood Logging Interface
- Select your mood from 20 different emojis (😊 to 😭)
- Add optional notes describing your day
- Automatic date tracking
- Beautiful and intuitive grid-based emoji picker

#### Mood History View
- View all previous mood entries in a scrollable list
- Built with `ListView.builder` for optimal performance
- Delete individual entries or clear all
- Pull-to-refresh functionality
- Card-based UI with mood color coding

#### Basic Mood Analytics
- Total mood entries count
- Positive vs Negative vs Neutral days breakdown
- Most common mood emoji calculation
- Clean card-based statistics display

#### Data Persistence & Cloud Sync
- **Local Storage**: Uses SharedPreferences for offline access
- **Cloud Firestore**: Sync mood entries across devices
- Automatic data synchronization
- Works offline with local fallback

#### Authentication
- Email/Password authentication via Firebase
- Secure user registration and login
- Persistent sessions
- User-specific mood data

#### Clean UI/UX Design
- Modern Material Design 3
- Responsive layout for different screen sizes
- Google Fonts (Inter) for typography
- Consistent spacing and alignment
- Card-based layouts with rounded corners

### Bonus Features
- 🌙 **Dark Mode Toggle** - Switch between light and dark themes
- 🎨 **Custom Animations** - Smooth transitions and emoji selection animations
- 📱 **Bottom Navigation** - Easy navigation between screens
- ☁️ **Cloud Sync** - Access your mood data from any device

## 📋 Getting Started

### Prerequisites
- Flutter SDK (3.x or higher)
- Android Studio / VS Code with Flutter extensions
- Android emulator or physical device
- Firebase account (for cloud features)

### Installation

#### 1. Clone the Repository
```bash
git clone https://github.com/rnt07s/DailyPulse
cd dailypulse
```

#### 2. Install Dependencies
```bash
flutter pub get
```

#### 3. Set Up Firebase (Optional but Recommended)

See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for detailed instructions.

Quick setup:
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android app with package name: `com.dailypulse.app`
3. Download `google-services.json` and place in `android/app/`
4. Enable Authentication (Email/Password)
5. Enable Firestore Database
6. Update Firestore security rules (see FIREBASE_SETUP.md)

#### 4. Run the App
```bash
flutter run
```

> **Note**: The app works offline with local storage, but requires Firebase setup for authentication and cloud sync features.

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point, Firebase init, auth flow
├── models/
│   └── mood_entry.dart            # Mood data model with JSON serialization
├── services/
│   ├── auth_service.dart          # Firebase Authentication service
│   └── mood_storage.dart          # Dual storage (local + Firestore)
└── screens/
    ├── login_screen.dart          # User login interface
    ├── signup_screen.dart         # User registration interface
    ├── mood_log_screen.dart       # Mood logging interface
    ├── mood_history_screen.dart   # History view with ListView.builder
    └── analytics_screen.dart      # Analytics and insights

android/
└── app/
    └── google-services.json       # Firebase config (add your own)

Firebase Collections:
├── users/                         # User profiles
└── mood_entries/                  # Mood entries with userId
```

## 🔧 Technical Details

### Dependencies
- `shared_preferences: ^2.2.2` - Local data persistence
- `google_fonts: ^6.1.0` - Beautiful typography (Inter font)
- `intl: ^0.19.0` - Date/time formatting
- `firebase_core: ^2.24.2` - Firebase initialization
- `firebase_auth: ^4.16.0` - User authentication
- `cloud_firestore: ^4.13.6` - Cloud database

### State Management
- Uses `setState` for state management (as required)
- Future-proof for adding Provider, Bloc, or Riverpod if needed

### Key Implementation Details

1. **Dual Storage**: Local (SharedPreferences) + Cloud (Firestore) sync
2. **Authentication**: Firebase Auth with secure email/password login
3. **ListView.builder**: Efficient rendering of mood history with dynamic item building
4. **Emoji Selection**: Grid-based emoji picker (5x4) with visual feedback
5. **Analytics**: Real-time calculation of mood statistics from stored data
6. **Dark Mode**: System-level theme switching with Material 3 support
7. **User Isolation**: Each user only sees their own mood entries via userId filtering

## 📱 Usage

### Initial Setup
1. **Sign Up**: Create an account with email and password
2. **Login**: Sign in to access your mood data

### Daily Usage
1. **Log Your Mood**: 
   - Tap an emoji that best represents how you feel
   - Add an optional note describing your day
   - Tap "Save My Mood" to record the entry
   
2. **View History**: 
   - Navigate to History tab
   - Scroll through past mood entries
   - Delete entries by tapping the delete icon
   
3. **Check Analytics**: 
   - Open Analytics tab
   - View total entries, mood distribution, and most common mood

4. **Switch Theme**: 
   - Tap the theme icon (🌙/☀️) in app bar
   - Toggle between light and dark modes

5. **Sign Out**: 
   - Tap the logout icon in app bar
   - Data persists in cloud and local storage

## 🎨 UI/UX Design Rationale

### Emotional Logic Design
The app uses emoji-based mood selection because:
- **Universal**: Emojis transcend language barriers
- **Fast**: Quick visual selection beats text input
- **Emotional**: Symbols capture feelings better than words
- **Intuitive**: No learning curve for users

### UI Choices
1. **Emoji Grid (5x4)**: Shows all 20 options at once, reducing decision fatigue
2. **Color Coding**: Visual distinction (green=positive, red=negative) helps quick scanning
3. **Card Layout**: Provides visual hierarchy and breathing room
4. **Bottom Navigation**: Thumb-friendly, shows all main sections
5. **Material 3**: Modern design language with elevation and motion

## 🚀 Future Enhancements

Potential features for expansion:
- Calendar view with mood indicators
- Chart visualization using fl_chart
- Export mood data as CSV
- Push notifications for daily reminders
- Mood tags/categories for better tracking
- Weekly/monthly mood summaries
- Multi-device sync improvements
- Social features (optional mood sharing)

## 🧪 Testing

### Manual Testing Checklist
- [ ] Create account and login
- [ ] Log multiple mood entries
- [ ] Verify data persists after app restart
- [ ] Test analytics calculations
- [ ] Switch themes and verify UI
- [ ] Test sign out and sign in again
- [ ] Verify mood entries sync to Firestore

## 🤝 Contributing

This is an educational project, but contributions are welcome:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is created for educational purposes.

## 🙏 Credits

Built with ❤️ 

---

**Note**: Requires Firebase setup for authentication and cloud sync features. See [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for configuration instructions.

