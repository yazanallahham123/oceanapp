import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_body.g.dart';

@JsonSerializable()
class SearchBody extends Equatable{
  final bool? byComputerNo;
  final String? searchText;
  final String? colorId;
  final String? sizeId;
  final String? branchId;

  SearchBody({this.byComputerNo, this.searchText, this.colorId, this.sizeId, this.branchId});

  factory SearchBody.fromJson(Map<String, dynamic> json) =>
      _$SearchBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SearchBodyToJson(this);

  @override
  List<Object?> get props =>
      [this.byComputerNo, this.searchText, this.colorId, this.sizeId, this.branchId];
}