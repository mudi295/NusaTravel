# NusaTravel 🌊

Aplikasi Flutter sederhana untuk praktikum **Navigation dan Routing**. NusaTravel menampilkan pilihan destinasi wisata Indonesia dan simulasi form pemesanan.

## Fitur
- Splash screen dengan `pushReplacementNamed()`.
- Home screen dengan empat paket wisata.
- Detail paket memakai `pushNamed()` dan `arguments`.
- Form booking dengan validasi dan pemilihan tanggal.
- `Navigator.push()` dan `Navigator.pop()` untuk mengembalikan hasil booking.
- `PopScope` dengan dialog konfirmasi ketika tombol Back ditekan.
- `SnackBar` setelah pemesanan berhasil.
- Logout menggunakan `pushNamedAndRemoveUntil()`.
- Routing dengan `initialRoute`, `routes`, `onGenerateRoute`, dan `onUnknownRoute`.
- Halaman Error 404.

## Teknologi
- Flutter
- Dart
- Material 3

## Struktur folder
```text
lib/
├── models/
│   └── tour_package.dart
├── routes/
│   └── app_routes.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   ├── booking_screen.dart
│   └── not_found_screen.dart
└── main.dart
```

## Menjalankan aplikasi
Pastikan Flutter SDK telah terpasang.

```bash
flutter pub get
flutter run
```

Validasi kode dan jalankan test:

```bash
dart format lib test
flutter analyze
flutter test
```

## Ringkasan navigasi
- `pushReplacementNamed()` mengganti Splash dengan Home.
- `pushNamed()` membuka Detail dan mengirim objek `TourPackage` melalui `arguments`.
- `Navigator.push()` membuka Booking secara imperatif.
- `Navigator.pop(context, result)` mengembalikan hasil booking ke Detail.
- `PopScope` mencegat Back dan menampilkan dialog pembatalan.
- `SnackBar` menampilkan notifikasi booking berhasil.
- `pushNamedAndRemoveUntil()` membersihkan riwayat saat logout.
- `onGenerateRoute` memvalidasi argumen rute Detail.
- `onUnknownRoute` menampilkan halaman 404.

## Screenshot untuk pengumpulan

Simpan screenshot asli dari emulator/HP ke folder `screenshots/` dengan nama berikut:

| Nama file | Halaman yang perlu ditangkap |
|---|---|
| `splash.png` | Splash screen |
| `home.png` | Daftar paket wisata |
| `detail.png` | Detail salah satu paket |
| `booking.png` | Form booking |
| `booking_back_dialog.png` | Dialog saat tombol Back ditekan |
| `booking_success_snackbar.png` | SnackBar setelah booking berhasil |
| `logout.png` | Dialog konfirmasi logout |
| `not_found.png` | Halaman 404 |

Screenshot belum disertakan dalam paket sumber ini karena harus diambil dari aplikasi yang benar-benar dijalankan. Setelah diambil, letakkan di folder `screenshots/` dan tampilkan menggunakan Markdown, misalnya:

```markdown
![Splash Screen](screenshots/splash.png)
```

## Catatan pengujian
Paket ini berisi source code dan test dasar. Jalankan perintah validasi pada perangkat/lingkungan Flutter kamu sebelum mengumpulkan. Gambar destinasi memakai URL internet; fallback ikon disediakan jika gambar gagal dimuat.

## GitHub
Setelah validasi dan screenshot selesai, buat repository GitHub baru lalu jalankan:

```bash
git init
git add .
git commit -m "Initial NusaTravel Flutter app"
git branch -M main
git remote add origin https://github.com/USERNAME/nusa_travel.git
git push -u origin main
```

Ganti `USERNAME` dengan username GitHub kamu.
