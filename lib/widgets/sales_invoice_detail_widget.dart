import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:oceanapp/model/invoice/invoice_detail.dart';
import 'package:oceanapp/model/transfer/transfer_detail.dart';
import 'package:oceanapp/model/transfer/transfer_master.dart';
import '../../helper/const_styles.dart';
import '../helper/app_colors.dart';
import '../helper/size_config.dart';

class SalesInvoiceDetailWidget extends StatelessWidget
{
  final InvoiceDetail invoiceDetail;
  const SalesInvoiceDetailWidget({Key? key, required this.invoiceDetail})
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
            Image.network("http://192.99.16.179:9022/Photos/${invoiceDetail.computerNo}.jpg",
              //Image.network("http://82.137.238.57:8877/Photos/${invoiceDetail.computerNo}.jpg",
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Text(translate("errors.NoImage"));
              },
              loadingBuilder: (BuildContext context, Widget widget, ImageChunkEvent? imageChunkEvent)
              {
                if (imageChunkEvent == null) return widget;
                return

                  Stack(children: [
                    Center(
                        child: CircularProgressIndicator(
                          color: primaryColor1,
                          value: imageChunkEvent.expectedTotalBytes != null ?
                          imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes!
                              : null,
                        )),
                    Center(child: Text(
                        ((imageChunkEvent.expectedTotalBytes != null) && (imageChunkEvent.expectedTotalBytes != null)) ?
                        ((imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes!)*100).round().toString()??""
                            : ""))],);
              },
              width: SizeConfig().w(100),
              height: SizeConfig().h(150),
            ),

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
                        Expanded(child: Container(child: Align(child: Text(translate("labels.price"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white),flex: 1),
                      ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),

                  Container(
                    width: MediaQuery.of(context).size.width - 25,
                    child:
                    Padding(child: Row(
                      children: [
                        Expanded(child: Container(child: Align(child: Text(invoiceDetail.barcode??"",style: TextStyle(fontSize: 10),), alignment: AlignmentDirectional.center,), color: Colors.white,), flex: 2),
                        Expanded(child: Container(child: Align(child: Text(invoiceDetail.color??""),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                        Expanded(child: Container(child: Align(child: Text(invoiceDetail.size??""),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                        Expanded(child: Container(child: Align(child: Text(((invoiceDetail.isOutput??true) ? "" : "-")  + invoiceDetail.qty.toString()??"" ),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                        Expanded(child: Container(child: Align(child: Text(invoiceDetail.price.toString()??""),alignment: AlignmentDirectional.center), color: Colors.white), flex: 1),
                      ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),


                ],)
            ],)],));
  }

}