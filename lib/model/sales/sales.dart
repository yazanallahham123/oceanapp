import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sales.g.dart';

@JsonSerializable()
class Sales extends Equatable{
  final String? branchName;
  final String? branchId;
  final String? totalValue;
  final String? totalQty;

  Sales({this.branchName, this.branchId, this.totalValue, this.totalQty});

  factory Sales.fromJson(Map<String, dynamic> json) =>
      _$SalesFromJson(json);

  Map<String, dynamic> toJson() => _$SalesToJson(this);

  @override
  List<Object?> get props =>
      [this.branchName, this.branchId, this.totalValue, this.totalQty];
}