import 'dart:convert';

import 'package:equatable/equatable.dart';

class Condition extends Equatable {
  const Condition({
    this.text,
  });

  final String? text;

  Condition copyWith({
    String? text,
  }) {
    return Condition(
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  factory Condition.fromMap(Map<String, dynamic> map) {
    return Condition(
      text: map['text'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Condition.fromJson(String source) => Condition.fromMap(Map<String, dynamic>.from(json.decode(source)));

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [text];
}
