
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:oceanapp/model/settings/device_settings.dart';
import 'package:oceanapp/ui/administration/administration_page.dart';
import '../../helper/const_styles.dart';
import '../bloc/item/state.dart';
import '../common_widgets/app_widgets/custom_loading.dart';
import '../common_widgets/buttons/custom_button.dart';
import '../model/branch/branch.dart';
import '../model/user/user.dart';

class DeviceWidget extends StatefulWidget
{
  final DeviceSettings device;
  final ValueChanged<DeviceSettings?> onChange;
  final VoidCallback onDeleteDevice;
  final List<Branch> branches;
  final List<User> users;
  final ItemState state;

  const DeviceWidget({Key? key, required this.state, required this.device, required this.onChange, required this.branches, required this.users, required this.onDeleteDevice
  })
      : super(key: key);

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {

  List<Branch> branchesForSearch = [];
  List<Branch> branchesForTransfer = [];

  void initState() {
    super.initState();

    if (widget.device.branchesInSearch != null) {
      widget.branches.forEach((b) {
        if (widget.device.branchesInSearch!.contains(b.id))
          branchesForSearch.add(b);
      });
    }

    if (widget.device.branchesToTransferTo != null) {
      widget.branches.forEach((b) {
        if (widget.device.branchesToTransferTo!.contains(b.id))
          branchesForTransfer.add(b);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return

      Slidable(
        endActionPane: ActionPane(motion: const ScrollMotion(),
    children: [
    SlidableAction(
    onPressed: (x){
      widget.onDeleteDevice();
    },
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    icon: Icons.list,
    label: translate("buttons.delete"),
    ),
    ],

    ),
    child:

      Container(
        margin: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: radiusAll16),

        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
        child:
        Column(children: [

          Align(child: Padding(child: Text(widget.device.fullname??""),padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),), alignment: AlignmentDirectional.topCenter,),
          Row(
            children: [
              Checkbox(
                  value: widget.device.canShowSales, onChanged: (x){
                if (mounted) {
                  setState(() {
                    widget.device.canShowSales = x;
                  });
                }
                    widget.onChange(widget.device);
              }),
              Text("Can View Sales")
            ],),

          Row(
            children: [
              Checkbox(
                  value: widget.device.canMakeTransfers, onChanged: (x){
                if (mounted) {
                  setState(() {
                    widget.device.canMakeTransfers = x;
                  });
                }
                widget.onChange(widget.device);
              }),
              Text("Can Create Transfers")
            ],),

          Row(
            children: [
              Checkbox(
                  value: widget.device.canReceiveTransfers, onChanged: (x){
                    if (mounted) {
                      setState(() {
                        widget.device.canReceiveTransfers = x;
                      });
                    }

                widget.onChange(widget.device);
              }),
              Text("Can Receive Transfers")
            ],),

          Row(
            children: [
              Checkbox(
                  value: widget.device.isAdmin, onChanged: (x){
                if (mounted) {
                  setState(() {
                    widget.device.isAdmin = x;
                  });
                }
                widget.onChange(widget.device);
              }),
              Text("Is Administartor")
            ],),

    Padding(child:
    CustomButton(title: (widget.device.userId == null) ? "Select User" : (widget.device.userId == "") ? "Select User" : widget.users.firstWhere((x) => x.usId == widget.device.userId).usName!,
          onTap: () async {
            User? user = await pickUser();
            if (user != null)
              {
                if (mounted) {
                  setState(() {
                    widget.device.userId = user.usId;
                    widget.device.username = user.usName;
                  });
                }
                widget.onChange(widget.device);
              }
          },
          ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5)),

          Padding(child:
          CustomButton(title: (widget.device.branchId == null) ? "Select Branch" :  (widget.device.branchId == "") ? "Select Branch" : widget.branches.firstWhere((x) => x.id == widget.device.branchId).arabicName! ,
            onTap: () async {
              Branch? branch = await pickBranch(true);
              if (branch != null)
              {
                if (mounted) {
                  setState(() {
                    widget.device.branchId = branch.id;
                  });
                }
                widget.onChange(widget.device);
              }
            },
          ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),),


          Padding(child:
          CustomButton(title: "Branches for Search",
            onTap: () async {
              pickBranches(branchesForSearch).then((x){
                  setState(() {
                    branchesForSearch = x;
                    widget.device.branchesInSearch!.clear();
                    if (branchesForSearch != null) {
                      branchesForSearch.forEach((b) {
                        widget.device.branchesInSearch!.add(b.id!);
                      });
                    }
                    widget.onChange(widget.device);
                  });

              });
            },
          ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),),

          (branchesForSearch != null) ?
          Wrap(children: branchesForSearch.map((x) => Container(
              margin: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
              padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
              color: Colors.yellow,
              child: Text(x.arabicName!))).toList(),) : Container(),


          Padding(child:
          CustomButton(title: "Branches for Transfers",
            onTap: () async {
              pickBranches(branchesForTransfer).then((x){

                setState(() {
                  branchesForTransfer = x;
                  widget.device.branchesToTransferTo!.clear();
                  if (branchesForTransfer != null) {
                    branchesForTransfer.forEach((b) {
                      widget.device.branchesToTransferTo!.add(b.id!);
                    });
                  }
                  widget.onChange(widget.device);
                });

              });
            },
          ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),),

          (branchesForTransfer != null) ?
          Wrap(children: branchesForTransfer.map((x) => Container(
              margin: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
              padding: EdgeInsetsDirectional.fromSTEB(3, 3, 3, 3),
              color: Colors.yellow,
              child: Text(x.arabicName!))).toList(),) : Container()


        ],)));
  }

  Future<User?>? pickUser() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(translate("labels.users")),
            content: setupUsersPickerDialog(widget.state, widget.users),
          );
        });
  }

  Future<Branch?>? pickBranch(bool addUnselect) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(translate("labels.branches")),
            content: setupBranchesPickerDialog(widget.state, widget.branches, addUnselect),
          );
        });
  }

  Future<List<Branch>> pickBranches(List<Branch> selectedBranches) async {
    var res = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(translate("labels.branches")),
            content: setupMultiBranchesPickerDialog(widget.state, widget.branches, selectedBranches),
            actions: [
              CustomButton(title: "Ok", onTap: (){
                Navigator.pop(context, selectedBranches);
              },),
              CustomButton(title: "Cancel", onTap: (){
                Navigator.pop(context);
              })
            ],
          );
        });

    return res;
  }

}

Widget setupUsersPickerDialog(ItemState state, List<User> list) {
  return Container(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: ((state is LoadingItemState) || (state is ItemInitItemState)) ?
    Center(child: CustomLoading(),)
        :
    ListView.builder(
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Navigator.pop(context, list[index]);
          },
          title: Text(list[index].usName??""),
        );
      },
    ),
  );
}

Widget setupBranchesPickerDialog(ItemState state, List<Branch> list, bool addUnselect) {

  List<Branch> xlist = [];
  if (addUnselect)
    {
      xlist.add(Branch(id: "", arabicName: "غير محدد", englishName: "غير محدد"));

    }

  xlist.addAll(list);

  return Container(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: ((state is LoadingItemState) || (state is ItemInitItemState)) ?
    Center(child: CustomLoading(),)
        :
    ListView.builder(
      shrinkWrap: true,
      itemCount: xlist.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Navigator.pop(context, xlist[index]);
          },
          title: Text(xlist[index].arabicName??""),
        );
      },
    ),
  );
}

Widget setupMultiBranchesPickerDialog(ItemState state, List<Branch> list, List<Branch> selectedList) {
  return MultiSelectBranchesWidget(branches: branches, state: state, selectedBranches: selectedList,);
}

class MultiSelectBranchesWidget extends StatefulWidget{
  final List<Branch> branches;
  final List<Branch> selectedBranches;
  final ItemState state;

  const MultiSelectBranchesWidget({Key? key, required this.branches, required this.state, required this.selectedBranches})
      : super(key: key);

  @override
  State<MultiSelectBranchesWidget> createState() => _MultiSelectBranchesWidgetState();
}

class _MultiSelectBranchesWidgetState extends State<MultiSelectBranchesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ((widget.state is LoadingItemState) || (widget.state is ItemInitItemState)) ?
      Center(child: CustomLoading(),)
          :
      ListView.builder(
        shrinkWrap: true,
        itemCount: widget.branches.length,
        itemBuilder: (BuildContext context, int index) {
          return
            Row(children: [
              Checkbox(value: (widget.selectedBranches.contains(widget.branches[index])), onChanged: (x) {
                setState(() {
                  if (widget.selectedBranches.contains(widget.branches[index]))
                    {
                      widget.selectedBranches.remove(widget.branches[index]);
                    }
                  else
                    {
                      widget.selectedBranches.add(widget.branches[index]);
                    }
                });
              }),
              Text(widget.branches[index].arabicName??""),
            ],);
        },
      ),
    );
  }
}
