import 'package:equatable/equatable.dart';
import 'package:oceanapp/model/invoice/invoice_detail.dart';
import 'package:oceanapp/model/settings/device_settings.dart';
import 'package:oceanapp/model/transfer/transfer_detail.dart';
import 'package:oceanapp/model/transfer/transfer_master.dart';
import 'package:oceanapp/widgets/search_result_widget.dart';

import '../../model/branch/branch.dart';
import '../../model/customer/customer.dart';
import '../../model/invoice/invoice.dart';
import '../../model/item/item.dart';
import '../../model/item/search_result.dart';
import '../../model/sales/sales.dart';
import '../../model/user/user.dart';

abstract class ItemState extends Equatable{

  const ItemState();

  @override
  List<Object?> get props => [];
}

class ItemInitItemState extends ItemState{
  const ItemInitItemState();
}

class LoadingItemState extends ItemState{
  const LoadingItemState();
}

class ErrorItemState extends ItemState{
  final String error;

  const ErrorItemState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class FoundItemState extends ItemState{
  final SearchResult result;

  const FoundItemState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class MadeTransferState extends ItemState{
  final bool result;

  const MadeTransferState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class GotBranchesState extends ItemState {
  final List<Branch> branches;

  const GotBranchesState(this.branches);

  @override
  List<Object?> get props => [this.branches];
}

class GotSalesState extends ItemState {
  final List<Sales> sales;

  const GotSalesState(this.sales);

  @override
  List<Object?> get props => [this.sales];
}

class GotReceivedTransfersState extends ItemState {
  final List<TransferMaster> transfers;

  const GotReceivedTransfersState(this.transfers);

  @override
  List<Object?> get props => [this.transfers];
}

class GotTransfersDetailsState extends ItemState {
  final List<TransferDetail> transferDetails;

  const GotTransfersDetailsState(this.transferDetails);

  @override
  List<Object?> get props => [this.transferDetails];
}

class TransferReceivedState extends ItemState {
  final bool result;

  const TransferReceivedState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class GotDevicesState extends ItemState {
  final List<DeviceSettings> devices;

  const GotDevicesState(this.devices);

  @override
  List<Object?> get props => [this.devices];
}

class GotUsersState extends ItemState {
  final List<User> users;

  const GotUsersState(this.users);

  @override
  List<Object?> get props => [this.users];
}


class SavedDevicesState extends ItemState{
  final bool result;

  const SavedDevicesState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class DeletedDeviceState extends ItemState{
  final bool result;
  final String deviceId;

  const DeletedDeviceState(this.result, this.deviceId);

  @override
  List<Object?> get props => [this.result, this.deviceId];
}

class FoundCustomerState extends ItemState{
  final Customer? customer;

  const FoundCustomerState(this.customer);

  @override
  List<Object?> get props => [this.customer];
}

class AddedCustomerState extends ItemState{
  final bool result;

  const AddedCustomerState(this.result);

  @override
  List<Object?> get props => [this.result];
}

class GotSalesInvoicesState extends ItemState {
  final List<Invoice> invoices;

  const GotSalesInvoicesState(this.invoices);

  @override
  List<Object?> get props => [this.invoices];
}

class GotSalesInvoiceDetailsState extends ItemState {
  final List<InvoiceDetail> invoiceDetails;

  const GotSalesInvoiceDetailsState(this.invoiceDetails);

  @override
  List<Object?> get props => [this.invoiceDetails];
}
