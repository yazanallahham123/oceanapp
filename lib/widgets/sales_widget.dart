import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helper/const_styles.dart';
import '../model/item/item.dart';
import '../model/sales/sales.dart';
import '../utils/misc.dart';

class SalesWidget extends StatelessWidget
{
  final Sales sales;
  final VoidCallback onTap;
  const SalesWidget({Key? key, required this.sales, required this.onTap
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
          InkWell(child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(child: Text(sales.branchName??"", style: TextStyle(fontWeight: FontWeight.bold),),
                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),

              Padding(child: Text(formatter.format(double.parse(sales.totalValue??"0"))),
                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),

              Padding(child: Text(sales.totalQty??""),
                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 2),),

            ],), onTap: onTap,),
        ],));
  }

}