import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bool_value.g.dart';

@JsonSerializable()
class BoolValue extends Equatable{
  final String? id;
  final bool? value;

  BoolValue({this.id, this.value});

  factory BoolValue.fromJson(Map<String, dynamic> json) =>
      _$BoolValueFromJson(json);

  Map<String, dynamic> toJson() => _$BoolValueToJson(this);

  @override
  List<Object?> get props =>
      [this.id, this.value];
}