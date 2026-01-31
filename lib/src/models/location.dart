import 'dart:convert';

import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({this.name, this.region, this.country, this.localtime});

  final String? name;
  final String? region;
  final String? country;
  final String? localtime;

  Location copyWith({
    String? name,
    String? region,
    String? country,
    String? localtime,
  }) {
    return Location(
      name: name ?? this.name,
      region: region ?? this.region,
      country: country ?? this.country,
      localtime: localtime ?? this.localtime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'region': region,
      'country': country,
      'localtime': localtime,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] as String?,
      region: map['region'] as String?,
      country: map['country'] as String?,
      localtime: map['localtime'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(Map<String, dynamic>.from(json.decode(source)));

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [name, region, country, localtime];
}
