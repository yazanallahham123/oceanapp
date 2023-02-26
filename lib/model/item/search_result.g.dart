// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      colors: (json['colors'] as List<dynamic>)
          .map((e) => ItemColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => ItemSize.fromJson(e as Map<String, dynamic>))
          .toList(),
      branches: (json['branches'] as List<dynamic>)
          .map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'items': instance.items,
      'colors': instance.colors,
      'sizes': instance.sizes,
      'branches': instance.branches,
    };
