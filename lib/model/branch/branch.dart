import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch extends Equatable{
  final String? id;
  final String? arabicName;
  final String? englishName;

  Branch({this.id, this.arabicName, this.englishName});

  factory Branch.fromJson(Map<String, dynamic> json) =>
      _$BranchFromJson(json);

  Map<String, dynamic> toJson() => _$BranchToJson(this);

  @override
  List<Object?> get props =>
      [this.id, this.arabicName, this.englishName];
}