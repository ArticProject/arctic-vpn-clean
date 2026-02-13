import 'package:flutter/material.dart';

void main() {
  runApp(const ArcticApp());
}

class ArcticApp extends StatelessWidget {
  const ArcticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArcticScreen(),
    );
  }
}

class ArcticScreen extends StatelessWidget {
  const ArcticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F3142),
      body: Center(
        child: Container(
          width: 344,
          height: 640,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3F7),
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
                children: const [
                  Text(
                    "Arctic VPN",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.settings, size: 20, color: Colors.black54),
                      SizedBox(width: 18),
                      Icon(Icons.send, size: 20, color: Colors.black54),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 46),
              Center(
                child: Container(
                  width: 260,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F3F7),
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
              const SizedBox(height: 54),
              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF2F3F7),
                    boxShadow: [
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
                  child: const Center(
                    child: Icon(
                      Icons.ac_unit,
                      size: 42,
                      color: Color(0xFF2E8BFF),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  BottomCard(
                    title: "Скорость с VPN",
                    value: "85 Mbps",
                  ),
                  BottomCard(
                    title: "Подписка активна до",
                    value: "24.03.2026",
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
    return Container(
      width: 140,
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F7),
        
