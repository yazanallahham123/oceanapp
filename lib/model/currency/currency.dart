import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable()
class Currency extends Equatable{
  final int? id;
  final String? arabicName;
  final String? englishName;

  Currency({this.id, this.arabicName, this.englishName});

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  @override
  List<Object?> get props =>
      [this.id, this.arabicName, this.englishName];
}