import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    super.key,
    this.message = 'Halaman yang kamu cari tidak tersedia.',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.travel_explore_rounded,
                size: 72,
                color: Color(0xFF087E8B),
              ),
              const SizedBox(height: 16),
              const Text(
                '404',
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF075985),
                ),
              ),
              const Text(
                'Halaman tidak ditemukan',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                ),
                icon: const Icon(Icons.home_rounded),
                label: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
