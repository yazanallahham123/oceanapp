import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:oceanapp/model/transfer/transfer_master.dart';
import '../../helper/const_styles.dart';
import '../model/invoice/invoice.dart';
import '../utils/misc.dart';

class SalesInvoiceWidget extends StatelessWidget
{
  final Invoice invoice;
  final VoidCallback onShowDetails;
  const SalesInvoiceWidget({Key? key, required this.invoice, required this.onShowDetails
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      InkWell(child:
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
                            Expanded(child: Container(child: Align(child: Text(translate("labels.date"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(translate("labels.totalQty"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(translate("labels.finalValue"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 2),
                          ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),

                      Container(
                        width: MediaQuery.of(context).size.width - 25,
                        child:
                        Padding(child: Row(
                          children: [
                            Expanded(child: Container(child: Align(child: Text(invoice.blno??"",style: TextStyle(fontSize: 10),), alignment: AlignmentDirectional.center,), color: Colors.white,), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(DateFormat("yyyy-MM-dd").format(invoice.date??DateTime.now()), style: TextStyle(fontSize: 12),),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(invoice.totalQty.toString()??""),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                            Expanded(child: Container(child: Align(child: Text(formatter.format(invoice.finalValue!).toString()+" SYP"),alignment: AlignmentDirectional.center), color: Colors.white), flex: 2),
                          ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),


                    ],)
                ],)],)), onTap: onShowDetails,);
  }

}