import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_cli/src/models/current.dart';
import 'package:weather_cli/src/models/forecast.dart';
import 'package:weather_cli/src/models/location.dart';

class ForecastWeather extends Equatable {
  const ForecastWeather({this.location, this.current, this.forecast});

  final Location? location;
  final Current? current;
  final Forecast? forecast;

  ForecastWeather copyWith({
    Location? location,
    Current? current,
    Forecast? forecast,
  }) {
    return ForecastWeather(
      location: location ?? this.location,
      current: current ?? this.current,
      forecast: forecast ?? this.forecast,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location?.toMap(),
      'current': current?.toMap(),
      'forecast': forecast?.toMap(),
    };
  }

  factory ForecastWeather.fromMap(Map<String, dynamic> map) {
    return ForecastWeather(
      location: Location.fromMap(map['location']),
      current: Current.fromMap(map['current']),
      forecast: Forecast.fromMap(map['forecast']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastWeather.fromJson(String source) =>
      ForecastWeather.fromMap(Map<String, dynamic>.from(json.decode(source)));

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [location, current, forecast];
}
