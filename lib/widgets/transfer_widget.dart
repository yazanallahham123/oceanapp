import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:oceanapp/model/transfer/transfer_master.dart';
import '../../helper/const_styles.dart';

class TransferWidget extends StatelessWidget
{
  final TransferMaster transfer;
  final VoidCallback onReceive;
  final VoidCallback onShowDetails;
  const TransferWidget({Key? key, required this.transfer, required this.onReceive, required this.onShowDetails
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Slidable(
          endActionPane: ActionPane(motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (x){
                  onShowDetails();
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.list,
                label: translate("buttons.showDetails"),
              ),
            ],

          ),
          startActionPane: ActionPane(motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (x){
                  onReceive();
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.check_box,
                label: translate("buttons.receive"),
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
                Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        width: MediaQuery.of(context).size.width - 25,
                        child:
                        Padding(child: Row(
                          children: [
                            Expanded(child: Container(child: Align(child: Text(translate("labels.blno"),style: TextStyle(fontWeight: FontWeight.bold),), alignment: AlignmentDirectional.center,), color: Colors.white,), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(translate("labels.branch"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 3),
                            Expanded(child: Container(child: Align(child: Text(translate("labels.date"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 2),
                            Expanded(child: Container(child: Align(child: Text(translate("labels.totalQty"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                          ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),

                      Container(
                        width: MediaQuery.of(context).size.width - 25,
                        child:
                        Padding(child: Row(
                          children: [
                            Expanded(child: Container(child: Align(child: Text(transfer.blno??"",style: TextStyle(fontSize: 10),), alignment: AlignmentDirectional.center,), color: Colors.white,), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(transfer.fromBranchName??"", style: TextStyle(fontSize: 12),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 3),
                            Expanded(child: Container(child: Align(child: Text(DateFormat("yyyy-MM-dd").format(transfer.date??DateTime.now()), style: TextStyle(fontSize: 12),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 2),
                            Expanded(child: Container(child: Align(child: Text(transfer.totalQty.toString()??""),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                          ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),


                    ],)
                ],)],)));
  }

}