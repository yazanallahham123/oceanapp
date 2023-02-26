import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_settings.g.dart';

@JsonSerializable()
class DeviceSettings extends Equatable{
  String? deviceId;
  String? branchId;
  String? userId;
  String? username;
  bool? isAdmin;
  bool? canShowSales;
  bool? canMakeTransfers;
  bool? canReceiveTransfers;
  List<String>? branchesToTransferTo;
  List<String>? branchesInSearch;
  String? fullname;

  DeviceSettings({this.deviceId, this.branchId, this.userId, this.username, this.isAdmin, this.canShowSales, this.canMakeTransfers, this.canReceiveTransfers, this.branchesInSearch, this.branchesToTransferTo, this.fullname});

  factory DeviceSettings.fromJson(Map<String, dynamic> json) =>
      _$DeviceSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceSettingsToJson(this);

  @override
  List<Object?> get props =>
      [this.deviceId, this.branchId, this.userId, this.username, this.isAdmin, this.canShowSales, this.canMakeTransfers, this.canReceiveTransfers, this.branchesToTransferTo, this.branchesInSearch, this.fullname];
}