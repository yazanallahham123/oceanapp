import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:oceanapp/model/item/item.dart';
import 'package:oceanapp/model/item/item_color.dart';

import '../branch/branch.dart';
import 'item_size.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult extends Equatable{
  final List<Item> items;
  final List<ItemColor> colors;
  final List<ItemSize> sizes;
  final List<Branch> branches;

  SearchResult({required this.items, required this.colors, required this.sizes, required this.branches});

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);

  @override
  List<Object?> get props =>
      [this.items, this.colors, this.sizes, this.branches];
}