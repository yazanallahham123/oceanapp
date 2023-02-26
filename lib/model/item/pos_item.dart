import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item.dart';

part 'pos_item.g.dart';

@JsonSerializable()
class POSItem extends Equatable{
  final Item? item;
  final bool? isReturn;

  POSItem({this.item, this.isReturn});

  factory POSItem.fromJson(Map<String, dynamic> json) =>
      _$POSItemFromJson(json);

  Map<String, dynamic> toJson() => _$POSItemToJson(this);

  @override
  List<Object?> get props =>
      [this.item, this.isReturn];
}