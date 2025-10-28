# DailyPulse - Quick Start Guide

## 🚀 Run the App in 3 Steps

### Step 1: Check Prerequisites
Make sure you have:
- Flutter SDK installed (3.x or higher)
- Android Studio / VS Code with Flutter extensions
- Android Emulator or Physical Device

### Step 2: Install Dependencies
Open terminal in project directory and run:
```bash
flutter pub get
```

### Step 3: Run the App
```bash
flutter run
```

That's it! The app will launch on your emulator/device.

---

## 📱 What You'll See

### Main Features
1. **Log Mood Tab** (Default)
   - Select from 20 emojis
   - Add an optional note
   - Tap "Save My Mood"

2. **History Tab**
   - View all past mood entries
   - Scrollable list with dates
   - Delete individual entries or clear all

3. **Analytics Tab**
   - Total entries count
   - Positive/Neutral/Negative day breakdown
   - Your most common mood

### Bonus Features
- **Dark Mode**: Tap 🌙 icon in app bar to toggle
- **Animations**: Smooth emoji selection and screen transitions

---

## ✅ Assignment Requirements Fulfilled

### Core Requirements (50 pts)
- ✅ Mood logging with emoji selector
- ✅ Optional text notes
- ✅ History view with ListView.builder
- ✅ Data persistence using shared_preferences
- ✅ Basic analytics (positive/negative counts)
- ✅ Clean Material Design 3 UI

### Bonus Features
- ✅ Dark mode toggle
- ✅ Custom animations

---

## 📂 Project Structure

```
lib/
├── main.dart                    # App entry & navigation
├── models/
│   └── mood_entry.dart         # Data model
├── services/
│   └── mood_storage.dart       # Local storage
└── screens/
    ├── mood_log_screen.dart
    ├── mood_history_screen.dart
    └── analytics_screen.dart
```

---

## 🎯 Testing Checklist

Test these features to verify everything works:
- [ ] Log a mood entry with emoji + note
- [ ] View the entry in History tab
- [ ] Check Analytics shows correct stats
- [ ] Close and reopen app (data persists)
- [ ] Toggle dark mode
- [ ] Delete an entry
- [ ] Clear all entries

---

## 🐛 Troubleshooting

**Problem**: "flutter: command not found"
**Solution**: Install Flutter SDK and add to PATH

**Problem**: "SDK not found"
**Solution**: Run `flutter doctor` and follow instructions

**Problem**: Build fails
**Solution**: 
```bash
flutter clean
flutter pub get
flutter run
```

---

## 📖 More Information

- **Detailed Setup**: See `SETUP_GUIDE.md`
- **Technical Analysis**: See `ANALYSIS.md`
- **Project Summary**: See `PROJECT_SUMMARY.md`
- **Features Overview**: See `README.md`

---

## 💡 Usage Tips

1. **Consistency**: Log your mood every day for better analytics
2. **Notes**: Adding notes helps track what affects your mood
3. **Analytics**: Check weekly to see your patterns
4. **Dark Mode**: Better for low-light environments

---

## 🎓 Learning Outcomes

This project demonstrates:
- Flutter mobile app development
- State management with setState
- Local data persistence
- ListView.builder for efficient rendering
- Material Design 3
- Clean code architecture

---

Built with ❤️ using Flutter

