# Firebase Setup Instructions

## Overview

DailyPulse uses Firebase Authentication and Cloud Firestore for secure user accounts and cloud sync of mood entries.

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `dailypulse` (or your preferred name)
4. Click "Continue"
5. Disable Google Analytics (optional)
6. Click "Create project"

## Step 2: Add Android App to Firebase

1. In Firebase Console, click "Add app" → Android
2. Enter package name: `com.dailypulse.app`
3. Register app
4. Download `google-services.json`
5. Place it in `android/app/` directory

## Step 3: Enable Authentication

1. In Firebase Console, go to "Authentication" → "Get started"
2. Click "Sign-in method" tab
3. Enable "Email/Password" provider
4. Click "Save"

## Step 4: Set Up Firestore Database

1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location (choose closest to you)
5. Click "Enable"

### Set Up Security Rules

1. Go to "Firestore Database" → "Rules" tab
2. Replace the default rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Mood entries collection
    match /mood_entries/{entryId} {
      allow read, write: if request.auth != null && request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && request.auth.uid == request.resource.data.userId;
    }
  }
}
```

3. Click "Publish"

## Step 5: Configure Flutter

1. Install Firebase CLI (if not already installed):
```bash
npm install -g firebase-tools
```

2. Login to Firebase:
```bash
firebase login
```

3. In your project directory, run:
```bash
flutter pub add firebase_core firebase_auth cloud_firestore
```

4. Configure Firebase (optional, for automatic setup):
```bash
firebase init
# Or manually add the configuration
```

## Step 6: Update Firebase Options in main.dart

After setting up Firebase, you should use the `firebase_options.dart` file (auto-generated) or manually update the Firebase configuration in `lib/main.dart`:

```dart
await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
  ),
);
```

## Step 7: Run the App

```bash
flutter pub get
flutter run
```

## Verification

1. Create a test account through the app
2. Log some mood entries
3. Check Firebase Console:
   - Authentication tab: Should show your user
   - Firestore Database: Should show mood entries with userId field

## Security Notes

- In production, update Firestore security rules
- Enable additional authentication methods if needed
- Set up Firebase App Check for additional security

## Troubleshooting

### "Firebase initialization failed"
- Check that `google-services.json` is in the correct location
- Verify package name matches Firebase project
- Run `flutter clean` and `flutter pub get`

### Authentication not working
- Verify Email/Password is enabled in Firebase Console
- Check network connection
- Review error messages in app logs

### Firestore not syncing
- Verify security rules allow current user
- Check Firestore is enabled in Firebase Console
- Ensure app has internet connection

## Production Checklist

Before releasing to production:

- [ ] Update Firestore security rules (remove test mode)
- [ ] Enable Firebase App Check
- [ ] Test authentication flow
- [ ] Test data sync across devices
- [ ] Set up data backup
- [ ] Configure error reporting
- [ ] Set up performance monitoring

