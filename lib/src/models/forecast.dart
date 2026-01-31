import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_cli/src/models/forecast_day.dart';

class Forecast extends Equatable {
  const Forecast({required this.forecastday});

  final List<ForecastDay> forecastday;

  Forecast copyWith({List<ForecastDay>? forecastday}) {
    return Forecast(forecastday: forecastday ?? this.forecastday);
  }

  Map<String, dynamic> toMap() {
    return {'forecastday': forecastday.map((x) => x.toMap()).toList()};
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      forecastday: (map['forecastday'] as List)
          .map((e) => ForecastDay.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Forecast.fromJson(String source) =>
      Forecast.fromMap(Map<String, dynamic>.from(json.decode(source)));

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [forecastday];
}
