// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferBody _$TransferBodyFromJson(Map<String, dynamic> json) => TransferBody(
      currency: json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      fromBranch: json['fromBranch'] == null
          ? null
          : Branch.fromJson(json['fromBranch'] as Map<String, dynamic>),
      toBranch: json['toBranch'] == null
          ? null
          : Branch.fromJson(json['toBranch'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      userName: json['userName'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$TransferBodyToJson(TransferBody instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'fromBranch': instance.fromBranch,
      'toBranch': instance.toBranch,
      'userName': instance.userName,
      'userId': instance.userId,
      'items': instance.items,
    };
