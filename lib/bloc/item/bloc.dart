import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../api/methods.dart';
import '../../api/retrofit.dart';
import 'event.dart';
import 'state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  late ApiClient mClient;

  ItemBloc() : super(ItemInitItemState()) {
    mClient = ApiClient(certificateClient());
    on<ItemInitItemEvent>((event, emit){
      emit(ItemInitItemState());
    });

    on<GetUsersEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.getOceanUser().then((v) async {
          emit(GotUsersState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotGetUsers")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<DeleteDeviceEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.deleteDevice(event.deviceId).then((v) async {
          emit(DeletedDeviceState(v, event.deviceId));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotDeleteDevice")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<SaveDevicesEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.saveDevices(event.devicesSettings).then((v) async {
          emit(SavedDevicesState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotSaveDevices")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetDevicesEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.getDevices().then((v) async {
          emit(GotDevicesState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotGetDevices")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });



    on<FindCustomerEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.findCustomer(event.mobileNumber).then((v) async {
          emit(FoundCustomerState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotFindCustomer")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });



    on<AddCustomerEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.addCustomer(event.customer).then((v) async {
          emit(AddedCustomerState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotAddCustomer")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<ReceiveTransferEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.receiveTransfer(event.receiveTransferDto).then((v) async {
          emit(TransferReceivedState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotGetTransferDetails")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<GetTransferDetailsEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.getTransferDetails(event.blno).then((v) async {
          emit(GotTransfersDetailsState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotGetTransferDetails")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });


    on<GetReceivedTransfersEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.getReceivedTransfers(event.branchId).then((v) async {
          emit(GotReceivedTransfersState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotGetReceivedTransfers")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<FindItemEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.findItem(event.searchBody).then((v) async {
          emit(FoundItemState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotFindItem")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetSalesEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.getSales(event.dateFilter).then((v) async {
            emit(GotSalesState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotGetSales")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetBranchesEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.getBranches().then((v) async {
          emit(GotBranchesState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotGetBranches")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<MakeTransferEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.makeTransfer(event.transferBody).then((v) async {
            emit(MadeTransferState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotMakeTransfer")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetSalesInvoicesEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.getSalesInvoices(event.branchId, event.fromDate, event.toDate).then((v) async {
          emit(GotSalesInvoicesState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotGetSalesInvoices")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });

    on<GetSalesInvoiceDetailsEvent>((event, emit) async {
      try {

        emit(LoadingItemState());

        await mClient.getSalesInvoiceDetails(event.blno).then((v) async {
          emit(GotSalesInvoiceDetailsState(v));
        });
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 || e.response!.statusCode == 404)
            emit(ErrorItemState(
                translate("errors.couldNotGetTransferDetails")));
          else {
            print("Error" + e.toString());
            emit(ErrorItemState(dioErrorMessageAdapter(e)));
          }
        }
        else
        {
          emit(ErrorItemState(dioErrorMessageAdapter(e)));
        }
      }
    });
  }
}


