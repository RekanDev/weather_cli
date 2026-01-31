import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_cli/src/models/day_forecast.dart';

class ForecastDay extends Equatable {
  const ForecastDay({this.date, this.day});

  final String? date;
  final DayForecast? day;

  ForecastDay copyWith({String? date, DayForecast? day}) {
    return ForecastDay(date: date ?? this.date, day: day ?? this.day);
  }

  Map<String, dynamic> toMap() {
    return {'date': date, 'day': day?.toMap()};
  }

  factory ForecastDay.fromMap(Map<String, dynamic> map) {
    return ForecastDay(
      date: map['date'] as String?,
      day: DayForecast.fromMap(map['day']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastDay.fromJson(String source) =>
      ForecastDay.fromMap(Map<String, dynamic>.from(json.decode(source)));

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [date, day];
}
