import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oceanapp/common_widgets/app_widgets/custom_loading.dart';
import 'package:oceanapp/main.dart';
import 'package:oceanapp/ui/administration/administration_page.dart';
import 'package:oceanapp/ui/item/find_item_page.dart';
import 'package:oceanapp/ui/pos/pos_page.dart';
import 'package:oceanapp/ui/receive_transfer/receive_transfer_page.dart';
import 'package:oceanapp/ui/transfer/make_transfer_page.dart';
import '../../api/methods.dart';
import '../../api/retrofit.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../model/settings/device_settings.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';
import '../sales/sales_page.dart';

class HomePage extends StatefulWidget {
  static const route = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int pageIndex = 0;

  List pages = [];

  @override
  void initState() {
    pageIndex = 0;

   pages = [
     FindItemPage(),
     MakeTransferPage(),
     SalesPage(),
     ReceiveTransferPage(),
     AdministrationPage(onSaved: (){
        setState(() {
          pageIndex = 0;
        });
      },),
     POSPage()
    ];

    super.initState();
  }


  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        bottomNavigationBar: Container(
          height: 62,
          decoration: BoxDecoration(
            color: backgroundColor2,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: InkWell(
                onTap: () {
                  setState(() {
                    hideKeyboard(context);
                    pageIndex = 0;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                    ),
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    //alignment: Alignment.topLeft,
                    height: 42,//SizeConfig().h(53),
                    width: 25,//SizeConfig().w(25),
                    child: Image(image: AssetImage(
                      'assets/png/finditem.png'),
                      color: (pageIndex == 0) ? primaryColor1 : Colors.white,
                      width: SizeConfig().w(25),
                    )),
              ), flex: 1,),
              (deviceSettings.canMakeTransfers??false) ?
              Expanded(child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      hideKeyboard(context);

                      pageIndex = 1;
                    });
                  }
                },
                child: Container(
                  //alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                    ),

                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    height: 42,//SizeConfig().h(53),
                    width: 25,//SizeConfig().w(25),
                    child: Image(image: AssetImage(
                      'assets/png/maketransfer.png'),
                      color: (pageIndex == 1) ? primaryColor1 : Colors.white,
                      width: SizeConfig().w(25),
                    )),
              ),flex: 1,) : Container(),
              (deviceSettings.canShowSales??false) ?
              Expanded(child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      hideKeyboard(context);

                      pageIndex = 2;
                    });
                  }
                },
                child: Container(
                  //alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                    ),

                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    height: 42,//SizeConfig().h(53),
                    width: 25,//SizeConfig().w(25),
                    child: Image(image: AssetImage(
                        'assets/png/sales.png'),
                      color: (pageIndex == 2) ? primaryColor1 : Colors.white,
                      width: SizeConfig().w(25),
                    )),
              ),flex: 1,) : Container(),
              (deviceSettings.canReceiveTransfers??false) ?
              Expanded(child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      hideKeyboard(context);

                      pageIndex = 3;
                    });
                  }
                },
                child: Container(
                  //alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                    ),

                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    height: 42,//SizeConfig().h(53),
                    width: 25,//SizeConfig().w(25),
                    child: Image(image: AssetImage(
                        'assets/png/checklist.png'),
                      color: (pageIndex == 3) ? primaryColor1 : Colors.white,
                      width: SizeConfig().w(25),
                    )),
              ),flex: 1,) : Container(),

              (deviceSettings.isAdmin??false) ?
              Expanded(child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      hideKeyboard(context);

                      pageIndex = 5;
                    });
                  }
                },
                child: Container(
                  //alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                    ),

                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    height: 42,//SizeConfig().h(53),
                    width: 25,//SizeConfig().w(25),
                    child: Image(image: AssetImage(
                        'assets/png/pos.png'),
                      color: (pageIndex == 5) ? primaryColor1 : Colors.white,
                      width: SizeConfig().w(25),
                    )),
              ),flex: 1,) : Container(),

              (deviceSettings.isAdmin??false) ?
              Expanded(child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      hideKeyboard(context);

                      pageIndex = 4;
                    });
                  }
                },
                child: Container(
                  //alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        border: BorderDirectional(end: BorderSide(color: Colors.white, width: 0.05, style: BorderStyle.solid))

                    ),

                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    height: 42,//SizeConfig().h(53),
                    width: 25,//SizeConfig().w(25),
                    child: Image(image: AssetImage(
                        'assets/png/settings.png'),
                      color: (pageIndex == 4) ? primaryColor1 : Colors.white,
                      width: SizeConfig().w(25),
                    )),
              ),flex: 1,) : Container(),
            ],
          ),
        ),
        body: pages[pageIndex]
    ));
  }
}