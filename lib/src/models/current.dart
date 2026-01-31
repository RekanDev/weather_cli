import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_cli/src/models/condition.dart';

class Current extends Equatable {
  const Current({
    this.tempC,
    this.condition,
    this.windKph,
    this.windDir,
    this.humidity,
    this.feelslikeC,
  });

  final num? tempC;
  final Condition? condition;
  final num? windKph;
  final String? windDir;
  final num? humidity;
  final num? feelslikeC;

  Current copyWith({
    num? tempC,
    Condition? condition,
    num? windKph,
    String? windDir,
    num? humidity,
    num? feelslikeC,
  }) {
    return Current(
      tempC: tempC ?? this.tempC,
      condition: condition ?? this.condition,
      windKph: windKph ?? this.windKph,
      windDir: windDir ?? this.windDir,
      humidity: humidity ?? this.humidity,
      feelslikeC: feelslikeC ?? this.feelslikeC,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'temp_c': tempC,
      'condition': condition?.toMap(),
      'wind_kph': windKph,
      'wind_dir': windDir,
      'humidity': humidity,
      'feelslike_c': feelslikeC,
    };
  }

  factory Current.fromMap(Map<String, dynamic> map) {
    return Current(
      tempC: map['temp_c'] as num?,
      condition: Condition.fromMap(map['condition']),
      windKph: map['wind_kph'] as num?,
      windDir: map['wind_dir'] as String?,
      humidity: map['humidity'] as num?,
      feelslikeC: map['feelslike_c'] as num?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Current.fromJson(String source) =>
      Current.fromMap(Map<String, dynamic>.from(json.decode(source)));

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props {
    return [tempC, condition, windKph, windDir, humidity, feelslikeC];
  }
}
