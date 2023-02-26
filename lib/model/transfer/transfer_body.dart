import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../branch/branch.dart';
import '../currency/currency.dart';
import '../item/item.dart';

part 'transfer_body.g.dart';

@JsonSerializable()
class TransferBody extends Equatable{
  final Currency? currency;
  final Branch? fromBranch;
  final Branch? toBranch;
  final String? userName;
  final String? userId;
  final List<Item>? items;

  TransferBody({this.currency, this.fromBranch, this.toBranch, this.items, this.userName, this.userId});

  factory TransferBody.fromJson(Map<String, dynamic> json) =>
      _$TransferBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TransferBodyToJson(this);

  @override
  List<Object?> get props =>
      [this.currency, this.fromBranch, this.toBranch, this.items, this.userName, this.userId];

}