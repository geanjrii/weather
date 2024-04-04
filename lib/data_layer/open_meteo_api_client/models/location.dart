import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );
  }

  final String name;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [name, latitude, longitude];
}
