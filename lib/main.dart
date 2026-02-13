import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/theme_provider.dart'; // если есть

void main() {
  runApp(
    const ProviderScope(child: ArcticVpnApp()),
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

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  bool isConnected = false;
  late AnimationController _controller;

  // Фейковые данные (потом заменить на реальные)
  final double speedDown = 45.2; // Мбит/с
  final double speedUp = 12.8;
  final double usedGB = 31.3;
  final double totalGB = 100.0;
  final String expiryDate = "19.03.2026";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Arctic VPN'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Экран настроек (потом добавим)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Настройки открыты')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Telegram или поделиться
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Telegram открывается')),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0A1421), const Color(0xFF001F3F)]
                : [Colors.blue[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isConnected = !isConnected;
                          });
                          if (isConnected) {
                            _controller.repeat(reverse: true);
                          } else {
                            _controller.stop();
                          }
                        },
                        child: RotationTransition(
                          turns: Tween(begin: -0.03, end: 0.03).animate(_controller),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 240,
                            height: 240,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: isConnected
                                    ? [const Color(0xFF4CAF50), const Color(0xFF1B5E20)]
                                    : [const Color(0xFF40C4FF), const Color(0xFF01579B)],
                              ),
                              boxShadow: isConnected
                                  ? [
                                      BoxShadow(
                                        color: Colors.greenAccent.withOpacity(0.6),
                                        blurRadius: 60,
                                        spreadRadius: 30,
                                      )
                                    ]
                                  : [],
                            ),
                            child: const Icon(
                              Icons.ac_unit_rounded,
                              size: 180,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        isConnected ? 'Connected ❄️' : 'Disconnected',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: isConnected ? Colors.greenAccent : Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Подписка до $expiryDate',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Нижние карточки
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCard(
                      title: 'Скорость',
                      value: isConnected ? '${speedDown.toStringAsFixed(1)} ↓ / ${speedUp.toStringAsFixed(1)} ↑ Мбит/с' : '0 Мбит/с',
                      icon: Icons.speed,
                    ),
                    _buildCard(
                      title: 'Потрачено трафика',
                      value: '${usedGB.toStringAsFixed(1)} ГБ / $totalGB ГБ',
                      icon: Icons.data_usage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 32),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}
