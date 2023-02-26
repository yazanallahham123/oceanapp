import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice.g.dart';

@JsonSerializable()
class Invoice extends Equatable{
  final String? blno;
  final int? totalQty;
  final DateTime? date;
  final double? finalValue;

  Invoice({this.blno, this.totalQty, this.date, this.finalValue});

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  @override
  List<Object?> get props =>
      [this.blno, this.totalQty, this.date, this.finalValue];

}