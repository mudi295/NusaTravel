import 'package:flutter/material.dart';
import '../models/tour_package.dart';
import 'booking_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.package});

  final TourPackage package;

  Future<void> _book(BuildContext context) async {
    final result = await Navigator.push<BookingResult>(
      context,
      MaterialPageRoute(
        builder: (_) => BookingScreen(package: package),
      ),
    );

    if (!context.mounted) return;
    if (result != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Pemesanan berhasil! ${result.customerName}, '
              '${result.participantCount} peserta.',
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Wisata')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              package.imageUrl,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 250,
                color: const Color(0xFFDCEFF2),
                child: const Icon(Icons.landscape_rounded, size: 72),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            package.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF12343B),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            package.description,
            style: const TextStyle(fontSize: 16, height: 1.65),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFE4F5F5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.sell_rounded, color: Color(0xFF087E8B)),
                const SizedBox(width: 12),
                const Expanded(child: Text('Harga per peserta')),
                Text(
                  package.formattedPrice,
                  style: const TextStyle(
                    color: Color(0xFF087E8B),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _book(context),
            icon: const Icon(Icons.luggage_rounded),
            label: const Text('Pesan Sekarang'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 17),
            ),
          ),
        ],
      ),
    );
  }
}
