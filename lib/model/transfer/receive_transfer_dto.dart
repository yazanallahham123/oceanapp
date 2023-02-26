import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../branch/branch.dart';
import '../currency/currency.dart';
import '../item/item.dart';

part 'receive_transfer_dto.g.dart';

@JsonSerializable()
class ReceiveTransferDto extends Equatable{
  final String? blno;
  final String? userName;
  final String? userId;


  ReceiveTransferDto({this.blno, this.userName, this.userId});

  factory ReceiveTransferDto.fromJson(Map<String, dynamic> json) =>
      _$ReceiveTransferDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiveTransferDtoToJson(this);

  @override
  List<Object?> get props =>
      [this.blno, this.userName, this.userId];

}