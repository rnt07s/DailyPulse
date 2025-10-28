import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/mood_log_screen.dart';
import 'screens/mood_history_screen.dart';
import 'screens/analytics_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase (will be configured with firebase_options.dart)
  // For now, handle gracefully if Firebase is not configured
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDUMMY-KEY-PLACEHOLDER',
        appId: '1:123456789:android:abcdef',
        messagingSenderId: '123456789',
        projectId: 'dailypulse-demo',
      ),
    );
  } catch (e) {
    print('Firebase initialization failed: $e');
    print('App will run with local storage only');
  }
  
  runApp(const DailyPulseApp());
}

class DailyPulseApp extends StatefulWidget {
  const DailyPulseApp({Key? key}) : super(key: key);

  @override
  State<DailyPulseApp> createState() => _DailyPulseAppState();
}

class _DailyPulseAppState extends State<DailyPulseApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DailyPulse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  bool _showSignUp = false;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _isLoading = false;
    });
  }

  void _toggleAuthMode() {
    setState(() {
      _showSignUp = !_showSignUp;
    });
  }

  Future<void> _handleLogin(String email, String password) async {
    try {
      await _authService.signInWithEmailPassword(email, password);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _handleSignUp(String name, String email, String password) async {
    try {
      await _authService.signUpWithEmailPassword(name, email, password);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _handleSignOut() async {
    await _authService.signOut();
    setState(() {});
  }

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    return StreamBuilder(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        final user = snapshot.data;
        
        if (user == null) {
          // Not authenticated - show login/signup
          if (_showSignUp) {
            return SignUpScreen(
              onToggleAuth: _toggleAuthMode,
              onSignUp: _handleSignUp,
            );
          } else {
            return LoginScreen(
              onToggleAuth: _toggleAuthMode,
              onLogin: _handleLogin,
            );
          }
        } else {
          // Authenticated - show main app
          return MainScreen(
            onThemeChanged: _toggleTheme,
            isDarkMode: _isDarkMode,
            onSignOut: _handleSignOut,
          );
        }
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;
  final VoidCallback onSignOut;

  const MainScreen({
    Key? key,
    required this.onThemeChanged,
    required this.isDarkMode,
    required this.onSignOut,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      const MoodLogScreen(),
      const MoodHistoryScreen(),
      AnalyticsScreen(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              'DailyPulse',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              widget.onThemeChanged(!widget.isDarkMode);
            },
            tooltip: widget.isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: widget.onSignOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Log Mood',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}

