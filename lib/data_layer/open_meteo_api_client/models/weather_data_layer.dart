import 'package:equatable/equatable.dart';

class WeatherDataLayer extends Equatable {
  const WeatherDataLayer({
    required this.temperature,
    required this.weatherCode,
  });

  factory WeatherDataLayer.fromJson(Map<String, dynamic> json) {
    return WeatherDataLayer(
      temperature: json['temperature'] as double,
      weatherCode: json['weathercode'] as int,
    );
  }

  final double temperature;
  final int weatherCode;

  @override
  List<Object> get props => [temperature, weatherCode];
}
