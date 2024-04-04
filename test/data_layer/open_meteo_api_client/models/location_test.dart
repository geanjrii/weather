import 'package:test/test.dart';
import 'package:weather/data_layer/data_layer.dart';

void main() {
  group('Location', () {
    group('fromJson', () {
      test('returns correct Location object', () {
        //arrange
        const locationJson = <String, dynamic>{
          'id': 4887398,
          'name': 'Chicago',
          'latitude': 41.85003,
          'longitude': -87.65005,
        };
        //act
        final locationFromJson = Location.fromJson(locationJson);
        //assert
        expect(
          locationFromJson,
          isA<Location>()
              .having((w) => w.name, 'name', 'Chicago')
              .having((w) => w.latitude, 'latitude', 41.85003)
              .having((w) => w.longitude, 'longitude', -87.65005),
        );
      });
    });
  });
}
