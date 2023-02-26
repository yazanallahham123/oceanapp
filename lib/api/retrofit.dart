import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:oceanapp/model/invoice/invoice_detail.dart';
import 'package:oceanapp/model/settings/device_settings.dart';
import 'package:oceanapp/model/transfer/transfer_detail.dart';
import 'package:oceanapp/model/transfer/transfer_master.dart';
import 'package:oceanapp/widgets/search_result_widget.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import '../model/branch/branch.dart';
import '../model/customer/customer.dart';
import '../model/dto/date_filter.dart';
import '../model/dto/search_body.dart';
import '../model/invoice/invoice.dart';
import '../model/item/item.dart';
import '../model/item/search_result.dart';
import '../model/sales/sales.dart';
import '../model/transfer/receive_transfer_dto.dart';
import '../model/transfer/transfer_body.dart';
import '../model/user/user.dart';
import 'apis.dart';
import 'package:http_parser/http_parser.dart';
part 'retrofit.g.dart';


@RestApi(baseUrl: Apis.baseURL)
@Headers(<String, dynamic>{"Content-Type": "application/json"})
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(Apis.makeTransfer)
  Future<bool> makeTransfer(@Body() TransferBody transferBody);

  @POST(Apis.finaItem)
  Future<SearchResult> findItem(@Body() SearchBody searchBody);

  @GET(Apis.getBranches)
  Future<List<Branch>> getBranches();

  @POST(Apis.getSales)
  Future<List<Sales>> getSales(@Body() DateFilter dateFilter);

  @GET(Apis.getReceivedTransfers)
  Future<List<TransferMaster>> getReceivedTransfers(@Query("branchId") String branchId);

  @GET(Apis.getTransferDetails)
  Future<List<TransferDetail>> getTransferDetails(@Query("BLNO") String blno);

  @POST(Apis.receiveTransfer)
  Future<bool> receiveTransfer(@Body() ReceiveTransferDto receiveTransferDto);

  @GET(Apis.getSettings)
  Future<DeviceSettings> getSettings(@Query("DeviceId") String deviceId);

  @GET(Apis.getDevices)
  Future<List<DeviceSettings>> getDevices();

  @POST(Apis.saveSettings)
  Future<bool> saveSettings(@Body() DeviceSettings deviceSettings);

  @GET(Apis.getOceanUsers)
  Future<List<User>> getOceanUser();

  @POST(Apis.saveDevices)
  Future<bool> saveDevices(@Body() List<DeviceSettings> devicesSettings);

  @GET(Apis.deleteDevice)
  Future<bool> deleteDevice(@Query("DeviceId") String deviceId);

  @GET(Apis.findCustomer)
  Future<Customer> findCustomer(@Query("MobileNumber") String mobileNumber);

  @POST(Apis.addCustomer)
  Future<bool> addCustomer(@Body() Customer customer);

  @GET(Apis.getSalesInvoices)
  Future<List<Invoice>> getSalesInvoices(@Path("branchId") String branchId, @Path("fromDate") String fromDate, @Path("toDate") String toDate);

  @GET(Apis.getSalesInvoiceDetails)
  Future<List<InvoiceDetail>> getSalesInvoiceDetails(@Query("BLNO") String blno);
}

