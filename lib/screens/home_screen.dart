import 'package:flutter/material.dart';
import '../models/tour_package.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari aplikasi?'),
        content: const Text(
          'Kamu akan kembali ke halaman awal dan riwayat halaman dihapus.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.splash,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final packages = TourPackage.samples;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NusaTravel',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF075985), Color(0xFF08A6A6)],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jelajahi Indonesia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Destinasi pilihan, pengalaman tak terlupakan.',
                  style: TextStyle(color: Colors.white70, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            'Paket wisata pilihan',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: Color(0xFF12343B),
            ),
          ),
          const SizedBox(height: 14),
          for (final package in packages) ...[
            _TourCard(
              package: package,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.detail,
                arguments: package,
              ),
            ),
            const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _TourCard extends StatelessWidget {
  const _TourCard({required this.package, required this.onTap});

  final TourPackage package;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              package.imageUrl,
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 170,
                color: const Color(0xFFDCEFF2),
                child: const Center(
                  child: Icon(Icons.landscape_rounded, size: 52),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    package.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    package.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.blueGrey.shade600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        package.formattedPrice,
                        style: const TextStyle(
                          color: Color(0xFF087E8B),
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Text('Lihat detail'),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
