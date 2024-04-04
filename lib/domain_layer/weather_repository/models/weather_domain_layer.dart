import 'package:equatable/equatable.dart';

enum WeatherCondition { clear, rainy, cloudy, snowy, unknown }

class WeatherDomainLayer extends Equatable {
  const WeatherDomainLayer({
    required this.location,
    required this.temperature,
    required this.condition,
  });

  final String location;
  final double temperature;
  final WeatherCondition condition;

  @override
  List<Object> get props => [location, temperature, condition];
}
