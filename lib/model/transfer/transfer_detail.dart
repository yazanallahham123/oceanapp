import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'transfer_detail.g.dart';

@JsonSerializable()
class TransferDetail extends Equatable{
  final String? computerNo;
  final String? color;
  final String? size;
  final String? barcode;
  final int? qty;

  TransferDetail({this.computerNo, this.color, this.size, this.barcode, this.qty});

  factory TransferDetail.fromJson(Map<String, dynamic> json) =>
      _$TransferDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TransferDetailToJson(this);

  @override
  List<Object?> get props =>
      [this.computerNo, this.color, this.size, this.barcode, this.qty];

}