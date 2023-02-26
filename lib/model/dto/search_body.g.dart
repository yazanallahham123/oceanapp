// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBody _$SearchBodyFromJson(Map<String, dynamic> json) => SearchBody(
      byComputerNo: json['byComputerNo'] as bool?,
      searchText: json['searchText'] as String?,
      colorId: json['colorId'] as String?,
      sizeId: json['sizeId'] as String?,
      branchId: json['branchId'] as String?,
    );

Map<String, dynamic> _$SearchBodyToJson(SearchBody instance) =>
    <String, dynamic>{
      'byComputerNo': instance.byComputerNo,
      'searchText': instance.searchText,
      'colorId': instance.colorId,
      'sizeId': instance.sizeId,
      'branchId': instance.branchId,
    };
