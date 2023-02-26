import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable{
  final String? code;
  final String? computerNo;
  final String? price;
  final String? localcost;
  final String? qty;
  final String? barcode;
  final String? sale;
  final String? color;
  final String? size;
  final String? branch;
  final String? branchId;

  Item({this.code, this.computerNo, this.price, this.localcost, this.qty, this.barcode, this.sale, this.color, this.size, this.branch, this.branchId});

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  List<Object?> get props =>
      [this.code, this.computerNo, this.price, this.localcost, this.qty, this.barcode, this.sale, this.color, this.size,
      this.branch, this.branchId];
}