import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:oceanapp/model/transfer/transfer_detail.dart';
import 'package:oceanapp/model/transfer/transfer_master.dart';
import '../../helper/const_styles.dart';

class TransferDetailWidget extends StatelessWidget
{
  final TransferDetail transferDetail;
  const TransferDetailWidget({Key? key, required this.transferDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
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

                            Expanded(child: Container(child: Align(child: Text(translate("labels.barcode"),style: TextStyle(fontWeight: FontWeight.bold),), alignment: AlignmentDirectional.center,), color: Colors.white,), flex: 2),
                            Expanded(child: Container(child: Align(child: Text(translate("labels.color"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(translate("labels.size"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(translate("labels.qty"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white),flex: 1),
                          ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),

                      Container(
                        width: MediaQuery.of(context).size.width - 25,
                        child:
                        Padding(child: Row(
                          children: [
                            Expanded(child: Container(child: Align(child: Text(transferDetail.barcode??"",style: TextStyle(fontSize: 10),), alignment: AlignmentDirectional.center,), color: Colors.white,), flex: 2),
                            Expanded(child: Container(child: Align(child: Text(transferDetail.color??""),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(transferDetail.size??""),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(transferDetail.qty.toString()??""),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                          ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),


                    ],)
                ],)],));
  }

}