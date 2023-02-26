// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receive_transfer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceiveTransferDto _$ReceiveTransferDtoFromJson(Map<String, dynamic> json) =>
    ReceiveTransferDto(
      blno: json['blno'] as String?,
      userName: json['userName'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$ReceiveTransferDtoToJson(ReceiveTransferDto instance) =>
    <String, dynamic>{
      'blno': instance.blno,
      'userName': instance.userName,
      'userId': instance.userId,
    };
