import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../../helper/const_styles.dart';
import '../model/item/item.dart';

class TransferItemWidget extends StatelessWidget
{
  final Item item;
  final VoidCallback onDelete;
  const TransferItemWidget({Key? key, required this.item, required this.onDelete
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Slidable(
          startActionPane: ActionPane(motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (x){
                  onDelete();
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
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
                      Expanded(child: Container(child: Align(child: Text(item.barcode??"",), alignment: AlignmentDirectional.center,), color: Colors.white,)),
                      Expanded(child: Container(child: Align(child: Text(item.color??""),alignment: AlignmentDirectional.center), color: Colors.white)),
                      Expanded(child: Container(child: Align(child: Text(item.size??""),alignment: AlignmentDirectional.center), color: Colors.white)),
                    ],), padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0)),),


              ],)
          ],)],)));
  }

}