// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      blno: json['blno'] as String?,
      totalQty: json['totalQty'] as int?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      finalValue: (json['finalValue'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'blno': instance.blno,
      'totalQty': instance.totalQty,
      'date': instance.date?.toIso8601String(),
      'finalValue': instance.finalValue,
    };
