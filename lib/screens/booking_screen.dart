import 'package:flutter/material.dart';
import '../models/tour_package.dart';

class BookingResult {
  const BookingResult({
    required this.customerName,
    required this.participantCount,
    required this.departureDate,
  });

  final String customerName;
  final int participantCount;
  final DateTime departureDate;
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.package});

  final TourPackage package;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _participantController = TextEditingController(text: '1');
  DateTime? _departureDate;
  bool _allowPop = false;
  bool _dialogOpen = false;

  @override
  void dispose() {
    _nameController.dispose();
    _participantController.dispose();
    super.dispose();
  }

  String _dateLabel(DateTime? date) {
    if (date == null) return 'Pilih tanggal keberangkatan';
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _chooseDate() async {
    final now = DateTime.now();
    final chosen = await showDatePicker(
      context: context,
      initialDate: _departureDate ?? DateTime(now.year, now.month, now.day),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(now.year + 3),
      helpText: 'Pilih tanggal keberangkatan',
    );
    if (chosen != null && mounted) setState(() => _departureDate = chosen);
  }

  Future<void> _confirmBack() async {
    if (_dialogOpen || !mounted) return;
    _dialogOpen = true;
    final cancelBooking = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Batalkan pemesanan?'),
        content: const Text(
          'Data yang sudah diisi tidak akan disimpan jika kamu keluar.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Lanjutkan Pemesanan'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Ya, Batalkan'),
          ),
        ],
      ),
    );
    _dialogOpen = false;

    if (!mounted) return;
    if (cancelBooking == true) {
      setState(() => _allowPop = true);
      Navigator.pop<BookingResult?>(context, null);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_departureDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih tanggal keberangkatan.')),
      );
      return;
    }
    final result = BookingResult(
      customerName: _nameController.text.trim(),
      participantCount: int.parse(_participantController.text.trim()),
      departureDate: _departureDate!,
    );
    setState(() => _allowPop = true);
    Navigator.pop<BookingResult>(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope<BookingResult?>(
      canPop: _allowPop,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && !_allowPop) _confirmBack();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Form Pemesanan')),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFE4F5F5),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Paket pilihanmu',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.package.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('${widget.package.formattedPrice} / peserta'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Nama pemesan'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              const Text('Jumlah peserta'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _participantController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Contoh: 2',
                  prefixIcon: Icon(Icons.groups_2_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final count = int.tryParse(value?.trim() ?? '');
                  if (count == null || count < 1) {
                    return 'Jumlah peserta harus bilangan positif.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              const Text('Tanggal keberangkatan'),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _chooseDate,
                icon: const Icon(Icons.calendar_month_rounded),
                label: Text(_dateLabel(_departureDate)),
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 28),
              FilledButton(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 17),
                ),
                child: const Text('Konfirmasi Pemesanan'),
              ),
              const SizedBox(height: 12),
              Text(
                'Dengan mengonfirmasi, data pemesanan akan dikembalikan '
                'ke halaman detail sebagai simulasi pemesanan.',
                style: TextStyle(color: Colors.blueGrey.shade600, height: 1.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
