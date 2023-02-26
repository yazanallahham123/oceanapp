// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferDetail _$TransferDetailFromJson(Map<String, dynamic> json) =>
    TransferDetail(
      computerNo: json['computerNo'] as String?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      barcode: json['barcode'] as String?,
      qty: json['qty'] as int?,
    );

Map<String, dynamic> _$TransferDetailToJson(TransferDetail instance) =>
    <String, dynamic>{
      'computerNo': instance.computerNo,
      'color': instance.color,
      'size': instance.size,
      'barcode': instance.barcode,
      'qty': instance.qty,
    };
