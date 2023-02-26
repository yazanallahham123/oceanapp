import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../helper/const_styles.dart';
import '../model/item/item.dart';

class SearchResultWidget extends StatelessWidget
{
  final Item item;
  const SearchResultWidget({Key? key, required this.item
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: radiusAll16),

        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
        child:
        Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Padding(child: Text(item.branch??"", style: TextStyle(fontWeight: FontWeight.bold),),
            padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),

              Padding(child: Text(item.qty??""),
                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),
            ],),
          Divider(color: Colors.black45, thickness: 0.3,),

          Row(children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  width: MediaQuery.of(context).size.width - 25,
                  child:
                  Padding(child: Row(
                    children: [
                      Expanded(child: Container(child: Align(child: Text(translate("labels.barcode"),style: TextStyle(fontWeight: FontWeight.bold),), alignment: AlignmentDirectional.center,), color: Colors.white,)),
                      Expanded(child: Container(child: Align(child: Text(translate("labels.color"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white)),
                      Expanded(child: Container(child: Align(child: Text(translate("labels.size"),style: TextStyle(fontWeight: FontWeight.bold),),alignment: AlignmentDirectional.center), color: Colors.white)),
                    ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),

                Container(
                  width: MediaQuery.of(context).size.width - 25,
                  child:
                  Padding(child: Row(
                    children: [
                      Expanded(child: Container(child: Align(child: Text(item.barcode??"", style: TextStyle(fontSize: 10),), alignment: AlignmentDirectional.center,), color: Colors.white,)),
                      Expanded(child: Container(child: Align(child: Text(item.color??""),alignment: AlignmentDirectional.center), color: Colors.white)),
                      Expanded(child: Container(child: Align(child: Text(item.size??""),alignment: AlignmentDirectional.center), color: Colors.white)),
                    ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),


              ],)
          ],)],));
  }

}