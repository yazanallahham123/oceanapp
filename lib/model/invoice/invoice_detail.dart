import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_detail.g.dart';

@JsonSerializable()
class InvoiceDetail extends Equatable{
  final bool? isOutput;
  final String? computerNo;
  final String? color;
  final String? size;
  final String? barcode;
  final int? qty;
  final double? price;


  InvoiceDetail({this.isOutput, this.computerNo, this.color, this.size, this.barcode, this.qty, this.price});

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDetailToJson(this);

  @override
  List<Object?> get props =>
      [this.isOutput, this.computerNo, this.color, this.size, this.barcode, this.qty, this.price];

}