import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_travel/models/tour_package.dart';

void main() {
  test('TourPackage formats Indonesian rupiah price', () {
    const package = TourPackage(
      id: 'test',
      title: 'Test Destination',
      description: 'A test destination',
      price: 150000,
      imageUrl: '',
    );
    expect(package.formattedPrice, 'Rp150.000');
  });

  test('sample data contains at least four tour packages', () {
    expect(TourPackage.samples.length, greaterThanOrEqualTo(4));
  });
}
