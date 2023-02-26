// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceSettings _$DeviceSettingsFromJson(Map<String, dynamic> json) =>
    DeviceSettings(
      deviceId: json['deviceId'] as String?,
      branchId: json['branchId'] as String?,
      userId: json['userId'] as String?,
      username: json['username'] as String?,
      isAdmin: json['isAdmin'] as bool?,
      canShowSales: json['canShowSales'] as bool?,
      canMakeTransfers: json['canMakeTransfers'] as bool?,
      canReceiveTransfers: json['canReceiveTransfers'] as bool?,
      branchesInSearch: (json['branchesInSearch'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      branchesToTransferTo: (json['branchesToTransferTo'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fullname: json['fullname'] as String?,
    );

Map<String, dynamic> _$DeviceSettingsToJson(DeviceSettings instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'branchId': instance.branchId,
      'userId': instance.userId,
      'username': instance.username,
      'isAdmin': instance.isAdmin,
      'canShowSales': instance.canShowSales,
      'canMakeTransfers': instance.canMakeTransfers,
      'canReceiveTransfers': instance.canReceiveTransfers,
      'branchesToTransferTo': instance.branchesToTransferTo,
      'branchesInSearch': instance.branchesInSearch,
      'fullname': instance.fullname,
    };
