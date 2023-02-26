import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer extends Equatable{
  final String? id;
  final String? name;
  final String? mobileNumber;
  final String? branchId;

  Customer({this.id, this.name, this.mobileNumber, this.branchId});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  List<Object?> get props =>
      [this.id, this.name, this.mobileNumber, this.branchId];
}