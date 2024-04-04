import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/models.dart';

typedef Json = Map<String, dynamic>;

class OpenMeteoApiClient {
  OpenMeteoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<Location> locationSearch(String query) async {
    const baseUrlGeocoding = 'geocoding-api.open-meteo.com';

    final locationRequest = Uri.https(
      baseUrlGeocoding,
      '/v1/search',
      {'name': query, 'count': '1'},
    );

    final response = await _httpClient.get(locationRequest);

    if (response.statusCode != 200) throw LocationRequestFailure();

    final json = jsonDecode(response.body) as Json;

    if (!json.containsKey('results')) throw LocationNotFoundFailure();

    final results = json['results'] as List;

    if (results.isEmpty) throw LocationNotFoundFailure();

    return Location.fromJson(results.first);
  }

  Future<WeatherDataLayer> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    const baseUrlWeather = 'api.open-meteo.com';

    final weatherRequest = Uri.https(baseUrlWeather, 'v1/forecast', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true',
    });

    final response = await _httpClient.get(weatherRequest);

    if (response.statusCode != 200) throw WeatherRequestFailure();

    final json = jsonDecode(response.body) as Json;

    if (!json.containsKey('current_weather')) throw WeatherNotFoundFailure();

    final weatherJson = json['current_weather'];

    return WeatherDataLayer.fromJson(weatherJson);
  }
}

class LocationRequestFailure implements Exception {}

class LocationNotFoundFailure implements Exception {}

class WeatherRequestFailure implements Exception {}

class WeatherNotFoundFailure implements Exception {}
