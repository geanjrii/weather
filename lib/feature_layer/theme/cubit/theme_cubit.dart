import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../feature_layer.dart';

class ThemeCubit extends HydratedCubit<Color> {
  ThemeCubit() : super(defaultColor);

  static const defaultColor = Color(0xFF2196F3);

  void updateTheme(Weather? weather) {
    if (weather != null) emit(toColor[weather.condition]!);
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color(int.parse(json['color'] as String));
  }

  @override
  Map<String, dynamic> toJson(Color state) {
    return <String, String>{'color': '${state.value}'};
  }
}

const toColor = {
  WeatherCondition.clear: Colors.yellow,
  WeatherCondition.snowy: Colors.lightBlueAccent,
  WeatherCondition.cloudy: Colors.blueGrey,
  WeatherCondition.rainy: Colors.indigoAccent,
  WeatherCondition.unknown: ThemeCubit.defaultColor,
};
