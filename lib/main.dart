import 'package:flutter/material.dart';

void main() {
  runApp(const ArcticApp());
}

class ArcticApp extends StatelessWidget {
  const ArcticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arctic VPN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF2F3F7),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF2F3142),
      ),
      themeMode: ThemeMode.light, // по умолчанию светлая, можно менять
      home: const ArcticScreen(),
    );
  }
}

class ArcticScreen extends StatefulWidget {
  const ArcticScreen({super.key});

  @override
  State<ArcticScreen> createState() => _ArcticScreenState();
}

class _ArcticScreenState extends State<ArcticScreen> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF2F3142) : const Color(0xFFF2F3F7),
      body: Center(
        child: Container(
          width: 344,
          height: 640,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1A1D2E) : const Color(0xFFF2F3F7),
            borderRadius: BorderRadius.circular(36),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 40,
                offset: Offset(0, 25),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Arctic VPN",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.settings, size: 20, color: isDark ? Colors.white70 : Colors.black54),
                      const SizedBox(width: 18),
                      Icon(Icons.send, size: 20, color: isDark ? Colors.white70 : Colors.black54),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 46),
              Center(
                child: AnimatedOpacity(
                  opacity: !isConnected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    width: 260,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2F3142) : const Color(0xFFF2F3F7),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-8, -8),
                          blurRadius: 16,
                        ),
                        BoxShadow(
                          color: Color(0x22000000),
                          offset: Offset(8, 8),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: const Text(
                      "Чтобы выключить\nВПН нажмите на\nкнопку",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.35,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 54),
              Center(
                child: GestureDetector(
                  onTap: () => setState(() => isConnected = !isConnected),
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? const Color(0xFF2F3142) : const Color(0xFFF2F3F7),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-10, -10),
                          blurRadius: 18,
                        ),
                        BoxShadow(
                          color: Color(0x22000000),
                          offset: Offset(10, 10),
                          blurRadius: 18,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.ac_unit,
                        size: 42,
                        color: isConnected ? const Color(0xFF4CAF50) : const Color(0xFF2E8BFF),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomCard(
                    title: "Скорость",
                    value: isConnected ? "45.2 ↓ / 12.8 ↑ Мбит/с" : "0 Мбит/с",
                  ),
                  BottomCard(
                    title: "Потрачено трафика",
                    value: "31.3 ГБ / 100 ГБ",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomCard extends StatelessWidget {
  final String title;
  final String value;

  const BottomCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 140,
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2F3142) : const Color(0xFFF2F3F7),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Color(0x22000000),
            offset: Offset(8, 8),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
