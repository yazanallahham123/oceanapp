import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_filter.g.dart';

@JsonSerializable()
class DateFilter extends Equatable{
  final String? fromDate;
  final String? toDate;

  DateFilter({this.fromDate, this.toDate});

  factory DateFilter.fromJson(Map<String, dynamic> json) =>
      _$DateFilterFromJson(json);

  Map<String, dynamic> toJson() => _$DateFilterToJson(this);

  @override
  List<Object?> get props =>
      [this.fromDate, this.toDate];
}