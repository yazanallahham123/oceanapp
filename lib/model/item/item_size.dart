import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_size.g.dart';

@JsonSerializable()
class ItemSize extends Equatable{
  final String? id;
  final String? name;

  ItemSize({this.id, this.name});

  factory ItemSize.fromJson(Map<String, dynamic> json) =>
      _$ItemSizeFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSizeToJson(this);

  @override
  List<Object?> get props =>
      [this.id, this.name];
}