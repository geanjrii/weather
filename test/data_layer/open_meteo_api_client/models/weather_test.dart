import 'package:test/test.dart';
import 'package:weather/data_layer/data_layer.dart';

void main() {
  group('Weather', () {
    group('fromJson', () {
      test('returns correct Weather object', () {
        // arrage
        const weatherJson = <String, dynamic>{
          'temperature': 15.3,
          'weathercode': 63,
        };
        // act
        final weatherFromJson = WeatherDataLayer.fromJson(weatherJson);
        // assert
        expect(
          weatherFromJson,
          isA<WeatherDataLayer>()
              .having((w) => w.temperature, 'temperature', 15.3)
              .having((w) => w.weatherCode, 'weatherCode', 63),
        );
      });
    });
  });
}
