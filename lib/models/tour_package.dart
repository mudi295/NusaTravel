class TourPackage {
  const TourPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;

  String get formattedPrice {
    final digits = price.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      buffer.write(digits[i]);
      final remaining = digits.length - i - 1;
      if (remaining > 0 && remaining % 3 == 0) buffer.write('.');
    }
    return 'Rp${buffer.toString()}';
  }

  static const List<TourPackage> samples = [
    TourPackage(
      id: 'pangandaran',
      title: 'Pantai Pangandaran',
      description:
          'Nikmati hamparan pasir, matahari terbenam, dan suasana pantai yang menenangkan di pesisir selatan Jawa Barat.',
      price: 250000,
      imageUrl:
          'https://images.unsplash.com/photo-1500375592092-40eb2168fd21?w=1200',
    ),
    TourPackage(
      id: 'kawah-putih',
      title: 'Kawah Putih Ciwidey',
      description:
          'Jelajahi danau kawah berwarna eksotis yang dikelilingi kabut tipis dan hutan pegunungan yang sejuk.',
      price: 180000,
      imageUrl:
          'https://images.unsplash.com/photo-1472396961693-142e6e269027?w=1200',
    ),
    TourPackage(
      id: 'borobudur',
      title: 'Candi Borobudur',
      description:
          'Kenali warisan budaya Indonesia melalui kemegahan candi Buddha dan panorama perbukitan sekitarnya.',
      price: 320000,
      imageUrl:
          'https://images.unsplash.com/photo-1596402184320-417e7178b2cd?w=1200',
    ),
    TourPackage(
      id: 'bromo',
      title: 'Gunung Bromo',
      description:
          'Saksikan matahari terbit, lautan pasir, dan lanskap vulkanik ikonik dari salah satu destinasi favorit Indonesia.',
      price: 450000,
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1200',
    ),
  ];
}
