part of 'weather_cubit.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;

  String toJson() => temperatureUnitsEnumMap[this]!;
}

const temperatureUnitsEnumMap = {
  TemperatureUnits.fahrenheit: 'fahrenheit',
  TemperatureUnits.celsius: 'celsius',
};

const temperatureUnitsMapEnum = {
  'fahrenheit': TemperatureUnits.fahrenheit,
  'celsius': TemperatureUnits.celsius,
};

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;

  String toJson() => weatherStatusEnumMap[this]!;
}

const weatherStatusEnumMap = {
  WeatherStatus.initial: 'initial',
  WeatherStatus.loading: 'loading',
  WeatherStatus.success: 'success',
  WeatherStatus.failure: 'failure',
};

const weatherStatusMapEnum = {
  'initial': WeatherStatus.initial,
  'loading': WeatherStatus.loading,
  'success': WeatherStatus.success,
  'failure': WeatherStatus.failure,
};

extension StringX on String {
  WeatherStatus toWeatherStatus() => weatherStatusMapEnum[this]!;
  TemperatureUnits toTemperatureUnits() => temperatureUnitsMapEnum[this]!;
}

final class WeatherState extends Equatable {
  WeatherState({
    this.status = WeatherStatus.initial,
    this.temperatureUnits = TemperatureUnits.celsius,
    Weather? weather,
  }) : weather = weather ?? Weather.empty;

  factory WeatherState.fromJson(Map<String, dynamic> json) {
    final String status = json['status'] as String;
    final String temperatureUnits = json['temperature_units'] as String;
    return WeatherState(
      status: status.toWeatherStatus(),
      temperatureUnits: temperatureUnits.toTemperatureUnits(),
      weather: Weather.fromJson(json['weather']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status.toJson(),
      'temperature_units': temperatureUnits.toJson(),
      'weather': weather.toJson(),
    };
  }

  final WeatherStatus status;
  final Weather weather;
  final TemperatureUnits temperatureUnits;

  WeatherState copyWith({
    WeatherStatus? status,
    TemperatureUnits? temperatureUnits,
    Weather? weather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
      weather: weather ?? this.weather,
    );
  }

  @override
  List<Object?> get props => [status, temperatureUnits, weather];
}
