import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../branch/branch.dart';
import '../currency/currency.dart';
import '../item/item.dart';

part 'transfer_master.g.dart';

@JsonSerializable()
class TransferMaster extends Equatable{
  final String? blno;
  final String? fromBranchName;
  final int? totalQty;
  final DateTime? date;

  TransferMaster({this.blno, this.fromBranchName, this.totalQty, this.date});

  factory TransferMaster.fromJson(Map<String, dynamic> json) =>
      _$TransferMasterFromJson(json);

  Map<String, dynamic> toJson() => _$TransferMasterToJson(this);

  @override
  List<Object?> get props =>
      [this.blno, this.fromBranchName, this.totalQty, this.date];

}