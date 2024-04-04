import 'package:equatable/equatable.dart';
import 'package:weather/domain_layer/domain_layer.dart'; 

const enumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.rainy: 'rainy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.snowy: 'snowy',
  WeatherCondition.unknown: 'unknown',
};

const mapEnum = {
  'clear': WeatherCondition.clear,
  'rainy': WeatherCondition.rainy,
  'cloudy': WeatherCondition.cloudy,
  'snowy': WeatherCondition.snowy,
  'unknown': WeatherCondition.unknown,
};

extension WeatherToJson on WeatherCondition {
  
  String toJson() => enumMap[this]!;
}

extension StringToWeatherCondition on String {
  WeatherCondition toWeatherCondition() => mapEnum[this]!;
}

class Weather extends Equatable {
  const Weather({
    required this.condition,
    required this.lastUpdated,
    required this.location,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final condition = json['condition'] as String;
    return Weather(
      condition: condition.toWeatherCondition(),
      lastUpdated: DateTime.parse(json['last_updated']),
      location: json['location'] as String,
      temperature: json['temperature'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'condition': condition.toJson(),
      'last_updated': lastUpdated.toIso8601String(),
      'location': location,
      'temperature': temperature,
    };
  }

  factory Weather.fromRepository(WeatherDomainLayer weather) {
    return Weather(
      condition: weather.condition,
      lastUpdated: DateTime.now(),
      location: weather.location,
      temperature: weather.temperature,
    );
  }

  static final empty = Weather(
    condition: WeatherCondition.unknown,
    lastUpdated: DateTime(0),
    temperature: 0,
    location: '--',
  );

  final WeatherCondition condition;
  final DateTime lastUpdated;
  final String location;
  final double temperature;

  @override
  List<Object> get props => [condition, lastUpdated, location, temperature];

  Weather copyWith({
    WeatherCondition? condition,
    DateTime? lastUpdated,
    String? location,
    double? temperature,
  }) {
    return Weather(
      condition: condition ?? this.condition,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      temperature: temperature ?? this.temperature,
    );
  }
}
