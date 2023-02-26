import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_color.g.dart';

@JsonSerializable()
class ItemColor extends Equatable{
  final String? id;
  final String? name;

  ItemColor({this.id, this.name});

  factory ItemColor.fromJson(Map<String, dynamic> json) =>
      _$ItemColorFromJson(json);

  Map<String, dynamic> toJson() => _$ItemColorToJson(this);

  @override
  List<Object?> get props =>
      [this.id, this.name];
}