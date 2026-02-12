import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/theme_provider.dart'; // если файл в lib/providers

void main() {
  runApp(const ProviderScope(child: ArcticVpnApp()));
}

class ArcticVpnApp extends ConsumerWidget {
  const ArcticVpnApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Arctic VPN',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF40C4FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF40C4FF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0A1421),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arctic VPN'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // твоя логика подключения позже
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: isDark
                        ? [const Color(0xFF40C4FF), const Color(0xFF01579B)]
                        : [Colors.blueAccent, Colors.lightBlue],
                  ),
                  boxShadow: isDark
                      ? [BoxShadow(color: Colors.blueAccent.withOpacity(0.6), blurRadius: 50)]
                      : [],
                ),
                child: const Icon(Icons.ac_unit_rounded, size: 160, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Disconnected', // потом динамически
              style: TextStyle(
                fontSize: 32,
                color: isDark ? Colors.redAccent : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
