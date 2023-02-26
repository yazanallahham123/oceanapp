// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      id: json['id'] as int?,
      arabicName: json['arabicName'] as String?,
      englishName: json['englishName'] as String?,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'arabicName': instance.arabicName,
      'englishName': instance.englishName,
    };
