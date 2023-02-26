// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_master.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferMaster _$TransferMasterFromJson(Map<String, dynamic> json) =>
    TransferMaster(
      blno: json['blno'] as String?,
      fromBranchName: json['fromBranchName'] as String?,
      totalQty: json['totalQty'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$TransferMasterToJson(TransferMaster instance) =>
    <String, dynamic>{
      'blno': instance.blno,
      'fromBranchName': instance.fromBranchName,
      'totalQty': instance.totalQty,
      'date': instance.date?.toIso8601String(),
    };
