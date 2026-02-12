import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:portfolio/core/theme/app_theme.dart';
import 'package:portfolio/features/home/home_page.dart';
import 'package:portfolio/firebase_options.dart';

const String _prefThemeKey = 'theme_mode'; // 'light' | 'dark'

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase when config has been set (after running flutterfire configure)
  if (!DefaultFirebaseOptions.currentPlatform.apiKey.startsWith('YOUR_')) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAnalytics.instance.logAppOpen();
  }

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_prefThemeKey);
    if (stored == null) return;
    setState(() {
      if (stored == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }
    });
  }

  Future<void> _setThemeMode(ThemeMode mode) async {
    setState(() => _themeMode = mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefThemeKey,
      mode == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  void _toggleTheme() {
    final next = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _setThemeMode(next);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdallah Gaber – Senior Mobile Team Lead',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _themeMode,
      home: HomePage(
        isDark: _themeMode == ThemeMode.dark,
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}
