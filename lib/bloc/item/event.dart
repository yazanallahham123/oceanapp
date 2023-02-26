import 'package:equatable/equatable.dart';
import 'package:oceanapp/model/dto/date_filter.dart';
import 'package:oceanapp/model/dto/search_body.dart';
import 'package:oceanapp/model/transfer/receive_transfer_dto.dart';

import '../../model/customer/customer.dart';
import '../../model/settings/device_settings.dart';
import '../../model/transfer/transfer_body.dart';

abstract class ItemEvent extends Equatable{

  const ItemEvent();

  @override
  List<Object?> get props => [];
}

class ItemInitItemEvent extends ItemEvent {
  const ItemInitItemEvent();
}

class GetSalesEvent extends ItemEvent{
  final DateFilter dateFilter;

  const GetSalesEvent(this.dateFilter);

  @override
  List<Object?> get props => [this.dateFilter];
}

class FindItemEvent extends ItemEvent{
  final SearchBody searchBody;

  const FindItemEvent(this.searchBody);

  @override
  List<Object?> get props => [this.searchBody];
}

class MakeTransferEvent extends ItemEvent{
  final TransferBody transferBody;

  const MakeTransferEvent(this.transferBody);

  @override
  List<Object?> get props => [this.transferBody];
}

class GetBranchesEvent extends ItemEvent{
  const GetBranchesEvent();

}

class GetReceivedTransfersEvent extends ItemEvent{
  final String branchId;

  const GetReceivedTransfersEvent(this.branchId);

  @override
  List<Object?> get props => [this.branchId];
}

class GetTransferDetailsEvent extends ItemEvent{
  final String blno;

  const GetTransferDetailsEvent(this.blno);

  @override
  List<Object?> get props => [this.blno];
}

class ReceiveTransferEvent extends ItemEvent{
  final ReceiveTransferDto receiveTransferDto;

  const ReceiveTransferEvent(this.receiveTransferDto);

  @override
  List<Object?> get props => [this.receiveTransferDto];
}

class GetDevicesEvent extends ItemEvent{
  const GetDevicesEvent();
}

class GetUsersEvent extends ItemEvent{
  const GetUsersEvent();
}

class SaveDevicesEvent extends ItemEvent{
  final List<DeviceSettings> devicesSettings;

  const SaveDevicesEvent(this.devicesSettings);

  @override
  List<Object?> get props => [this.devicesSettings];
}


class DeleteDeviceEvent extends ItemEvent{
  final String deviceId;

  const DeleteDeviceEvent(this.deviceId);

  @override
  List<Object?> get props => [this.deviceId];
}

class FindCustomerEvent extends ItemEvent{
  final String mobileNumber;

  const FindCustomerEvent(this.mobileNumber);


  @override
  List<Object?> get props => [this.mobileNumber];
}

class AddCustomerEvent extends ItemEvent{
  final Customer customer;

  const AddCustomerEvent(this.customer);

  @override
  List<Object?> get props => [this.customer];
}

class GetSalesInvoicesEvent extends ItemEvent{
  final String branchId;
  final String fromDate;
  final String toDate;

  const GetSalesInvoicesEvent(this.branchId, this.fromDate, this.toDate);

  @override
  List<Object?> get props => [this.branchId, this.fromDate, this.toDate];
}

class GetSalesInvoiceDetailsEvent extends ItemEvent{
  final String blno;

  const GetSalesInvoiceDetailsEvent(this.blno);

  @override
  List<Object?> get props => [this.blno];
}