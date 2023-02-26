import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:oceanapp/common_widgets/app_widgets/custom_loading.dart';
import 'package:oceanapp/common_widgets/buttons/custom_button.dart';
import 'package:oceanapp/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:oceanapp/model/currency/currency.dart';
import 'package:oceanapp/model/dto/search_body.dart';
import 'package:oceanapp/model/settings/device_settings.dart';
import 'package:oceanapp/model/transfer/transfer_body.dart';
import 'package:oceanapp/widgets/transfer_item_widget.dart';
import '../../bloc/item/bloc.dart';
import '../../bloc/item/event.dart';
import '../../bloc/item/state.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../main.dart';
import '../../model/branch/branch.dart';
import '../../model/item/item.dart';
import '../barcode_scanner/barcode_scanner_page.dart';
import '../home/home_page.dart';

class MakeTransferPage extends StatefulWidget {
  static const route = "/make_transfer_page";

  const MakeTransferPage();

  @override
  State<MakeTransferPage> createState() => _MakeTransferPageState();
}

class _MakeTransferPageState extends State<MakeTransferPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemBloc>(
        create: (BuildContext context) =>
        ItemBloc()..add(ItemInitItemEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ItemBloc>(context);

    return BlocListener<ItemBloc, ItemState>(
        listener: (context, state) async {
          if (state is ItemInitItemState) {
            if (mounted) {
              setState(() {
                branches = [];
                fromBranch = null;
                toBranch = null;
              });
            }
            if (!bloc.isClosed)
              bloc.add(GetBranchesEvent());
          } else if (state is ErrorItemState)
            pushToast(state.error);
          else if (state is GotBranchesState) {
            if (mounted) {
              setState(() {
                if (state.branches.isNotEmpty) {
                  branches = state.branches;
                  if (deviceSettings.branchId != null) {
                    if (deviceSettings.branchId!.isNotEmpty) {
                      if (state.branches.firstWhereOrNull((x) =>
                      x.id == deviceSettings.branchId) != null) {
                        blockBranchSelection = true;
                        fromBranch = state.branches.firstWhere((x) =>
                        x.id ==
                            deviceSettings.branchId);
                      }
                    }
                    else
                      {
                        blockBranchSelection = false;
                        fromBranch = null;

                        }
                  }
                  else
                    {
                      blockBranchSelection = false;
                      fromBranch = null;

                    }

                  if (deviceSettings.branchesToTransferTo != null) {
                    if (deviceSettings.branchesToTransferTo!.length > 0) {
                      toBranches = [];
                      deviceSettings.branchesToTransferTo!.forEach((br) {
                        if  (state.branches.firstWhereOrNull((x) => x.id == br) != null)
                          {
                            toBranches.add(state.branches.firstWhere((x) => x.id == br));
                          }
                      });
                    }
                    else
                      toBranches = branches;
                  }
                  else
                    toBranches = branches;
                }
                else
                  pushToast(translate("errors.noBranchesFound"));
              });
            }
          }
          else if (state is FoundItemState)
            {
              if (mounted) {
                setState(() {
                  if (state.result.items.isNotEmpty)
                    searchResult.addAll(state.result.items);
                  else
                    pushToast(translate("errors.noItemsFound"));
                });
              }
            }

          else if (state is MadeTransferState)
          {
            if (state.result) {
              if (mounted) {
                setState(() {
                  searchResult = [];
                  fromBranch = null;
                  if (deviceSettings.branchId != null) {
                    if (deviceSettings.branchId!.isNotEmpty) {
                      if (branches.firstWhereOrNull((x) =>
                      x.id == deviceSettings.branchId) != null) {
                        blockBranchSelection = true;
                        fromBranch = branches.firstWhere((x) =>
                        x.id ==
                            deviceSettings.branchId);
                      }
                    }
                    else
                      {
                        blockBranchSelection = false;
                        fromBranch = null;

                      }
                  }
                  else
                    {
                      blockBranchSelection = false;
                      fromBranch = null;

                    }

                  toBranch = null;
                  searchController.text = "";
                  pushToast(translate("messages.transferIsSuccess"));
                });
              }
            }
            else
              pushToast(translate("errors.couldNotMakeTransfer"));
          }
        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, ItemState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}



class _BuildUI extends StatefulWidget {
  final ItemBloc bloc;
  final ItemState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

bool loading = false;
TextEditingController searchController = new TextEditingController();
List<Item> searchResult = [];
List<Branch> branches = [];
List<Branch> toBranches = [];
Branch? fromBranch;
Branch? toBranch;
bool blockBranchSelection = false;

class _BuildUIState extends State<_BuildUI> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        bottomNavigationBar: ((widget.state is LoadingItemState) || (widget.state is ItemInitItemState)) ? null : CustomButton(title: translate("buttons.save"),
        onTap: () {
            bool makeTransfer = true;

            if (fromBranch == null) {
              pushToast(translate("errors.selectFromBranch"));
              makeTransfer = false;
            }
            else {
              if (toBranch == null) {
                pushToast(translate("errors.selectToBranch"));
                makeTransfer = false;
              }
              else {
                if (searchResult.isEmpty) {
                  pushToast(translate("errors.addItems"));
                  makeTransfer = false;
                }
              }
            }


            if (makeTransfer) {
              Currency currency = Currency(
                  id: 1, arabicName: "ليرة سورية", englishName: "SP");
              TransferBody transferBody = TransferBody(currency: currency,
                  fromBranch: fromBranch,
                  toBranch: toBranch,
                  items: searchResult,
                  userId: deviceSettings.userId,
                  userName: deviceSettings.username
                  );
              if (!widget.bloc.isClosed)
                widget.bloc.add(MakeTransferEvent(transferBody));
            }
          },
        ),
        backgroundColor: backgroundColor1,
        appBar: AppBar(
        backgroundColor: backgroundColor1,
        toolbarHeight: ((widget.state is LoadingItemState) || (widget.state is ItemInitItemState)) ? 0 : (!blockBranchSelection) ? SizeConfig().h(190) : SizeConfig().h(130),
        automaticallyImplyLeading: false,
        flexibleSpace:
        ((widget.state is LoadingItemState) || (widget.state is ItemInitItemState)) ? null : Column(children: [
          (!blockBranchSelection) ? Padding(child: CustomButton(
            backColor: (fromBranch == null) ? primaryColor1 : Colors.green,
            borderColor: (fromBranch == null) ? primaryColor1 : Colors.green,
            title: (fromBranch == null) ? translate("buttons.fromBranch") : fromBranch!.arabicName??"",
            onTap: () async {
              Branch? branch = await pickBranch();
              if (mounted) {
                setState(()  {
                  fromBranch = branch;
                  searchResult = [];
                });
              }

            },
          ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),) : Container(),
          Padding(child: CustomButton(
            backColor: (toBranch == null) ? primaryColor1 : Colors.green,
            borderColor: (toBranch == null) ? primaryColor1 : Colors.green,
            title: (toBranch == null) ? translate("buttons.toBranch"): toBranch!.arabicName??"",
            onTap: () async {
              Branch? branch = await pickBranch();
              if (mounted) {
                setState(()  {
                  toBranch = branch;
                });
              }

            },
          ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),),

          Center(child: Padding(child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: CustomTextFieldWidget(
                      controller: searchController,
                      hintText: translate("labels.enterText"),
                      onFieldSubmitted: (x) {
                        SearchBody searchBody = new SearchBody(byComputerNo: false, searchText: searchController.text, colorId: "0", sizeId: "0", branchId: (fromBranch != null) ? fromBranch!.id??"0" : "0");
                        if (!widget.bloc.isClosed)
                          widget.bloc.add(FindItemEvent(searchBody));
                      },
                    )),
                IconButton(
                    onPressed: () async {
                      String? barcodeScanRes = await Navigator.pushNamed(context, BarcodeScannerPage.route) as String?;
                      if (barcodeScanRes != null)
                      {
                        if (barcodeScanRes.isNotEmpty)
                        {
                          searchController.text = barcodeScanRes;
                          SearchBody searchBody = new SearchBody(byComputerNo: false, searchText: searchController.text, colorId: "0", sizeId: "0", branchId: (fromBranch != null) ? fromBranch!.id??"0" : "0");
                          if (!widget.bloc.isClosed)
                            widget.bloc.add(FindItemEvent(searchBody));
                        }
                      }
                    },
                    icon: Icon(Icons.document_scanner_outlined, color: Colors.white,))
              ]), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),)),


        ],)
        ),
        body: SafeArea(child:

            SingleChildScrollView(child: Stack(children : [
              ((widget.state is LoadingItemState) || (widget.state is ItemInitItemState)) ? Container(
            height: MediaQuery.of(context).size.height,
            child: Center(child: CustomLoading(),)) :
        Column(children: [

          Column(children: searchResult.map((x) =>


              TransferItemWidget(
                  item: x, onDelete: () {
                    if (mounted) {
                      setState(() {
                        searchResult.remove(x);
                      });
                    }
              },)

          ).toList())

        ],)]))));
  }



  Future<Branch?>? pickBranch() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(translate("labels.branches")),
            content: setupBranchesPickerDialog(widget.state),
          );
        });
  }
}

Widget setupBranchesPickerDialog(ItemState state) {
  return Container(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: (state is LoadingItemState) ?
        Center(child: CustomLoading(),)
        :
    ListView.builder(
      shrinkWrap: true,
      itemCount: toBranches.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Navigator.pop(context, toBranches[index]);
          },
          title: Text(toBranches[index].arabicName??""),
        );
      },
    ),
  );
}
