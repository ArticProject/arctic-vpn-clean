import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/theme_provider.dart'; // импорт провайдера

void main() {
  runApp(
    const ProviderScope(  // обязательно!
      child: ArcticVpnApp(),
    ),
  );
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
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
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
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              final current = ref.read(themeModeProvider);
              ref.read(themeModeProvider.notifier).setTheme(
                current == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
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
              onTap: () {}, // сюда потом логику VPN
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? Colors.blueGrey[800] : Colors.blue[200],
                ),
                child: Icon(
                  Icons.ac_unit,
                  size: 120,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Disconnected',
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
