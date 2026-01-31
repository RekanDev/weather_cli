import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_cli/src/models/condition.dart';

class DayForecast extends Equatable {
  const DayForecast({
    this.maxtempC,
    this.mintempC,
    this.avgtempC,
    this.maxwindKph,
    this.avghumidity,
    this.condition,
  });

  final num? maxtempC;
  final num? mintempC;
  final num? avgtempC;
  final num? maxwindKph;
  final num? avghumidity;
  final Condition? condition;

  DayForecast copyWith({
    num? maxtempC,
    num? mintempC,
    num? avgtempC,
    num? maxwindKph,
    num? avghumidity,
    Condition? condition,
  }) {
    return DayForecast(
      maxtempC: maxtempC ?? this.maxtempC,
      mintempC: mintempC ?? this.mintempC,
      avgtempC: avgtempC ?? this.avgtempC,
      maxwindKph: maxwindKph ?? this.maxwindKph,
      avghumidity: avghumidity ?? this.avghumidity,
      condition: condition ?? this.condition,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'maxtemp_c': maxtempC,
      'mintemp_c': mintempC,
      'avgtemp_c': avgtempC,
      'maxwind_kph': maxwindKph,
      'avghumidity': avghumidity,
      'condition': condition?.toMap(),
    };
  }

  factory DayForecast.fromMap(Map<String, dynamic> map) {
    return DayForecast(
      maxtempC: map['maxtemp_c'] as num?,
      mintempC: map['mintemp_c'] as num?,
      avgtempC: map['avgtemp_c'] as num?,
      maxwindKph: map['maxwind_kph'] as num?,
      avghumidity: map['avghumidity'] as num?,
      condition: Condition.fromMap(map['condition']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DayForecast.fromJson(String source) =>
      DayForecast.fromMap(Map<String, dynamic>.from(json.decode(source)));

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props {
    return [maxtempC, mintempC, avgtempC, maxwindKph, avghumidity, condition];
  }
}
