import 'dart:async';

import '../../data_layer/data_layer.dart' hide WeatherDataLayer;
import '../domain_layer.dart';

class WeatherRepository {
  WeatherRepository({OpenMeteoApiClient? weatherApiClient})
      : _weatherApiClient = weatherApiClient ?? OpenMeteoApiClient();

  final OpenMeteoApiClient _weatherApiClient;

  Future<WeatherDomainLayer> getWeather(String city) async {
    final location = await _weatherApiClient.locationSearch(city);
    final weather = await _weatherApiClient.getWeather(
      latitude: location.latitude,
      longitude: location.longitude,
    );
    return WeatherDomainLayer(
      temperature: weather.temperature,
      location: location.name,
      condition: weather.weatherCode.toCondition,
    );
  }
}

const cloudy = [1, 2, 3, 45, 48];
const rainy = [51, 53, 55, 56, 57, 61, 63, 65, 66, 67, 80, 81, 82, 95, 96, 99];
const snowy = [71, 73, 75, 77, 85, 86];

extension WeatherInterpretatiConodes on int {
  WeatherCondition get toCondition {
    if (this == 0) {
      return WeatherCondition.clear;
    } else if (cloudy.contains(this)) {
      return WeatherCondition.cloudy;
    } else if (rainy.contains(this)) {
      return WeatherCondition.rainy;
    } else if (snowy.contains(this)) {
      return WeatherCondition.snowy;
    } else {
      return WeatherCondition.unknown;
    }
  }
}
