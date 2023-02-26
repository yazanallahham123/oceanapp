import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oceanapp/model/item/pos_item.dart';
import '../../helper/const_styles.dart';
import '../model/item/item.dart';
import '../model/sales/sales.dart';
import '../utils/misc.dart';

class POSItemWidget extends StatelessWidget
{
  final POSItem posItem;
  const POSItemWidget({Key? key, required this.posItem
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
        decoration: BoxDecoration(
            color: (posItem.isReturn!) ? Colors.red : Colors.white, borderRadius: radiusAll16),

        padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
        child:
        Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(child: Text(posItem.item!.barcode!, style: TextStyle(fontWeight: FontWeight.bold),),
                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),

              Padding(child: Text(formatter.format(double.parse(((posItem.item!.sale != null) ? (posItem.item!.sale != "") ? posItem.item!.sale! : posItem.item!.price??"0" : posItem.item!.price??"")))),
                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),
            ],),
        ],));
  }

}