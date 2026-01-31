import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_cli/src/models/current.dart';
import 'package:weather_cli/src/models/location.dart';

class Weather extends Equatable {
  const Weather({this.location, this.current});

  final Location? location;
  final Current? current;

  Weather copyWith({Location? location, Current? current}) {
    return Weather(
      location: location ?? this.location,
      current: current ?? this.current,
    );
  }

  Map<String, dynamic> toMap() {
    return {'location': location?.toMap(), 'current': current?.toMap()};
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      location: Location.fromMap(map['location']),
      current: Current.fromMap(map['current']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(Map<String, dynamic>.from(json.decode(source)));

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [location, current];
}
