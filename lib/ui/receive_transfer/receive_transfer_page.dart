import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:oceanapp/common_widgets/app_widgets/custom_loading.dart';
import 'package:oceanapp/common_widgets/buttons/custom_button.dart';
import 'package:oceanapp/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:oceanapp/model/currency/currency.dart';
import 'package:oceanapp/model/dto/search_body.dart';
import 'package:oceanapp/model/transfer/receive_transfer_dto.dart';
import 'package:oceanapp/model/transfer/transfer_body.dart';
import 'package:oceanapp/ui/home/home_page.dart';
import 'package:oceanapp/ui/receive_transfer/transfer_details_page.dart';
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
import '../../model/transfer/transfer_master.dart';
import '../../widgets/transfer_widget.dart';

class ReceiveTransferPage extends StatefulWidget {
  static const route = "/receive_transfer_page";

  const ReceiveTransferPage();

  @override
  State<ReceiveTransferPage> createState() => _ReceiveTransferPageState();
}

class _ReceiveTransferPageState extends State<ReceiveTransferPage> {
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
                transfers = [];
                selectedBranch = null;
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
                      selectedBranch = state.branches.firstWhere((x) =>
                      x.id ==
                          deviceSettings.branchId);
                    }
                  }
                  else {
                    selectedBranch = null;
                    blockBranchSelection = false;
                  }
                }
                else {
                  selectedBranch = null;
                  blockBranchSelection = false;
                }
                }
                else
                  pushToast(translate("errors.noBranchesFound"));
              });
            }
          }
          else if (state is GotReceivedTransfersState)
            {
              if (mounted) {
                setState(() {
                  if (state.transfers.isNotEmpty) {
                    transfers = state.transfers;
                  }
                  else {
                    pushToast(translate("errors.noTransfersToReceive"));
                    transfers = [];
                  }
                });
              }
            }
          else if (state is TransferReceivedState)
          {
            if (state.result) {
              if (!bloc.isClosed)
                bloc.add(GetReceivedTransfersEvent(selectedBranch!.id!));

              pushToast(translate("Done!"));
            }
            else
              pushToast(translate("errors.couldNotReceiveTransfer"));
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
List<Branch> branches = [];
Branch? selectedBranch;
List<TransferMaster> transfers = [];
bool blockBranchSelection = false;


class _BuildUIState extends State<_BuildUI> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: backgroundColor1,
        appBar: AppBar(
            backgroundColor: backgroundColor1,
            toolbarHeight: ((widget.state is LoadingItemState) || (widget.state is ItemInitItemState)) ? 0 : (!blockBranchSelection) ?  SizeConfig().h(120) : SizeConfig().h(60),
            automaticallyImplyLeading: false,
            flexibleSpace:
            ((widget.state is LoadingItemState) || (widget.state is ItemInitItemState)) ? null : Column(children: [
              (!blockBranchSelection) ? Padding(child: CustomButton(
                backColor: (selectedBranch == null) ? primaryColor1 : Colors.green,
                borderColor: (selectedBranch == null) ? primaryColor1 : Colors.green,
                title: (selectedBranch == null) ? translate("buttons.branch") : selectedBranch!.arabicName??"",
                onTap: () async {
                  Branch? branch = await pickBranch();
                  if (mounted) {
                    setState(()  {
                      selectedBranch = branch;
                      transfers = [];
                    });
                  }

                },
              ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),) : Container(),

              Padding(child: CustomButton(title: translate("buttons.getTransfers"),
                onTap: () {
                  bool getTransfers = true;

                  if (selectedBranch == null) {
                    pushToast(translate("errors.selectBranch"));
                    getTransfers = false;
                  }

                  if (getTransfers) {
                    if (!widget.bloc.isClosed)
                      widget.bloc.add(GetReceivedTransfersEvent(selectedBranch!.id!));
                  }
                },
              ), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 5),),
            ],)
        ),
        body: SafeArea(child:

        SingleChildScrollView(child: Stack(children : [
          ((widget.state is LoadingItemState) || (widget.state is ItemInitItemState)) ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: CustomLoading(),)) :
          Column(children: [

            Column(children: transfers.map((x) =>
                TransferWidget(
                  transfer: x, onReceive: () {
                  if (mounted) {
                    setState(() {
                      ReceiveTransferDto receiveTransferDto = ReceiveTransferDto(blno: x.blno, userName: deviceSettings.username, userId: deviceSettings.userId);
                      if (!widget.bloc.isClosed)
                        widget.bloc.add(ReceiveTransferEvent(receiveTransferDto));
                    });
                  }
                },

                 onShowDetails : () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransferDetailsPage(BLNO:x.blno!)));
                  },

                )

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
    child: ((state is LoadingItemState) || (state is ItemInitItemState)) ?
    Center(child: CustomLoading(),)
        :
    ListView.builder(
      shrinkWrap: true,
      itemCount: branches.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Navigator.pop(context, branches[index]);
          },
          title: Text(branches[index].arabicName??""),
        );
      },
    ),
  );
}
