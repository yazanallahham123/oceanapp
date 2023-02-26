// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

POSItem _$POSItemFromJson(Map<String, dynamic> json) => POSItem(
      item: json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>),
      isReturn: json['isReturn'] as bool?,
    );

Map<String, dynamic> _$POSItemToJson(POSItem instance) => <String, dynamic>{
      'item': instance.item,
      'isReturn': instance.isReturn,
    };
