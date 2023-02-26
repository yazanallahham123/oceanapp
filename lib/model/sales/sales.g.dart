// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sales _$SalesFromJson(Map<String, dynamic> json) => Sales(
      branchName: json['branchName'] as String?,
      branchId: json['branchId'] as String?,
      totalValue: json['totalValue'] as String?,
      totalQty: json['totalQty'] as String?,
    );

Map<String, dynamic> _$SalesToJson(Sales instance) => <String, dynamic>{
      'branchName': instance.branchName,
      'branchId': instance.branchId,
      'totalValue': instance.totalValue,
      'totalQty': instance.totalQty,
    };
