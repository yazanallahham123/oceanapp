// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      code: json['code'] as String?,
      computerNo: json['computerNo'] as String?,
      price: json['price'] as String?,
      localcost: json['localcost'] as String?,
      qty: json['qty'] as String?,
      barcode: json['barcode'] as String?,
      sale: json['sale'] as String?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      branch: json['branch'] as String?,
      branchId: json['branchId'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'code': instance.code,
      'computerNo': instance.computerNo,
      'price': instance.price,
      'localcost': instance.localcost,
      'qty': instance.qty,
      'barcode': instance.barcode,
      'sale': instance.sale,
      'color': instance.color,
      'size': instance.size,
      'branch': instance.branch,
      'branchId': instance.branchId,
    };
