// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDetail _$InvoiceDetailFromJson(Map<String, dynamic> json) =>
    InvoiceDetail(
      isOutput: json['isOutput'] as bool?,
      computerNo: json['computerNo'] as String?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      barcode: json['barcode'] as String?,
      qty: json['qty'] as int?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$InvoiceDetailToJson(InvoiceDetail instance) =>
    <String, dynamic>{
      'isOutput': instance.isOutput,
      'computerNo': instance.computerNo,
      'color': instance.color,
      'size': instance.size,
      'barcode': instance.barcode,
      'qty': instance.qty,
      'price': instance.price,
    };
