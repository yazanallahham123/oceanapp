import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:oceanapp/common_widgets/app_widgets/custom_loading.dart';
import 'package:oceanapp/common_widgets/buttons/custom_button.dart';
import 'package:oceanapp/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:oceanapp/main.dart';
import 'package:oceanapp/model/currency/currency.dart';
import 'package:oceanapp/model/dto/date_filter.dart';
import 'package:oceanapp/model/dto/search_body.dart';
import 'package:oceanapp/model/transfer/transfer_body.dart';
import 'package:oceanapp/ui/home/home_page.dart';
import 'package:oceanapp/ui/sales/sales_invoices_page.dart';
import 'package:oceanapp/widgets/transfer_item_widget.dart';
import '../../bloc/item/bloc.dart';
import '../../bloc/item/event.dart';
import '../../bloc/item/state.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/branch/branch.dart';
import '../../model/item/item.dart';
import '../../model/sales/sales.dart';
import '../../utils/misc.dart';
import '../../widgets/sales_widget.dart';

class SalesPage extends StatefulWidget {
  static const route = "/sales_page";

  const SalesPage();

  @override
  State<SalesPage> createState() => _SalesPageState();
}

List<Sales> sales = [];
double totalSales = 0.0;
int totalQty = 0;

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemBloc>(
        create: (BuildContext context) =>
        ItemBloc()..add(ItemInitItemEvent()), //.add(InitEvent()),
        child: Builder(builder: (context) => _buildPage(context)));
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ItemBloc>(context);

    return BlocListener<ItemBloc, ItemState>(
        listener: (context, state) async {
          if (state is ItemInitItemState) {
            if (mounted) {
              setState(() {
                sales = [];
                totalQty = 0;
                totalSales = 0;
                fromDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
                toDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

                DateFilter dateFilter = DateFilter(
                    fromDate: fromDate, toDate: toDate);
                if (!bloc.isClosed)
                  bloc.add(GetSalesEvent(dateFilter));

              });
            }
          } else if (state is ErrorItemState)
            pushToast(state.error);
          else if (state is GotSalesState) {
            if (mounted) {
              setState(() {
                if (state.sales.isNotEmpty) {
                  sales = state.sales;

                  if (deviceSettings.branchId != null)
                    {
                      if (deviceSettings.branchId!.isNotEmpty)
                        {
                          sales = [];
                          if (state.sales.firstWhereOrNull((x) => x.branchId! == deviceSettings.branchId!) != null)
                            sales.add(state.sales.firstWhere((x) => x.branchId! == deviceSettings.branchId!));
                        }
                      else
                        sales = state.sales;
                    }
                  else
                    sales = state.sales;


                  totalSales = 0;
                  totalQty = 0;

                  WidgetKit.setItem('widgetData', jsonEncode(sales), 'group.com.fasky');
                  WidgetKit.reloadAllTimelines();

                  sales.forEach((s) { totalSales = totalSales + double.parse(s.totalValue??"0");});
                  sales.forEach((s) { totalQty = totalQty + int.parse(s.totalQty??"0");});
                }
                else {
                  sales = [];
                  pushToast(translate("errors.NoSalesFound"));
                }
              });
            }
          }
        },
        bloc: bloc,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, ItemState state) {
              return _BuildUI(bloc: bloc, state: state);
            }));
  }
}



class _BuildUI extends StatefulWidget {
  final ItemBloc bloc;
  final ItemState state;

  _BuildUI({required this.bloc, required this.state});

  @override
  State<_BuildUI> createState() => _BuildUIState();
}

bool loading = false;
String? fromDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
String? toDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

class _BuildUIState extends State<_BuildUI> {

  void initState() {
    super.initState();
    fromDate = null;
    toDate = null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        bottomNavigationBar: Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(child: Text( formatter.format(double.parse(totalSales.toString()??"0")), style: TextStyle(fontSize: 15, color: Colors.white),), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            Padding(child: Text(" - ", style: TextStyle(fontSize: 15, color: Colors.white)), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
            Padding(child: Text(totalQty.toString(), style: TextStyle(fontSize: 15, color: Colors.white)), padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),),
        ],)
        ),
        backgroundColor: backgroundColor1,
        appBar: AppBar(
            backgroundColor: backgroundColor1,
            toolbarHeight: SizeConfig().h(180),
            automaticallyImplyLeading: false,
            flexibleSpace:
            Column(children: [
              Padding(child: CustomButton(title: (fromDate == null) ? translate("buttons.fromDate") : fromDate??"",
                onTap: () async {

                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2022, 1, 1),
                      maxTime: DateTime(2099, 12, 31),
                      theme: DatePickerTheme(
                          headerColor: buttonColor1,
                          backgroundColor: backgroundColor1,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16)),
                      onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours
                                .toString());


                      }, onConfirm: (date) {

                        if (mounted) {
                          setState(() {
                            fromDate = DateFormat("yyyy-MM-dd","en_US").format(date);
                            sales = [];
                            totalQty = 0;
                            totalSales = 0.0;
                          });
                        }

                      },);

                },
              ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),),

              Padding(child: CustomButton(title: (toDate == null) ? translate("buttons.toDate") : toDate??"",
                onTap: () async {
                  DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(2022, 1, 1),
                    maxTime: DateTime(2099, 12, 31),
                    theme: DatePickerTheme(
                        headerColor: buttonColor1,
                        backgroundColor: backgroundColor1,
                        itemStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        doneStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16)),
                    onChanged: (date) {
                      print('change $date in time zone ' +
                          date.timeZoneOffset.inHours
                              .toString());


                    }, onConfirm: (date) {

                      if (mounted) {
                        setState(() {
                          toDate = DateFormat("yyyy-MM-dd","en_US").format(date);
                          sales = [];
                          totalQty = 0;
                          totalSales = 0.0;
                        });
                      }

                    },);

                },
              ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),),

              Padding(child: CustomButton(title:  translate("buttons.generate"),
                onTap: () async {
                  if ((fromDate != null) && (toDate != null)) {
                    DateFilter dateFilter = DateFilter(
                        fromDate: fromDate, toDate: toDate);
                    if (!widget.bloc.isClosed)
                      widget.bloc.add(GetSalesEvent(dateFilter));
                  }
                  else {
                    pushToast(translate("errors.setDateFilter"));
                    if (mounted) {
                      setState(() {
                        sales = [];
                        totalSales = 0;
                        totalQty = 0;
                      });
                    }
                  }
                },
              ), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),),
            ],)
        ),
        body: SafeArea(child:

        SingleChildScrollView(child: Stack(children : [
          (widget.state is LoadingItemState) ? Center(child: CustomLoading(),) :
          Column(children: [

            Column(children: sales.map((x) =>

                SalesWidget(
                  sales: x, onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => SalesInvociesPage(branchId:x.branchId!, fromDate: fromDate, toDate: toDate,)));
                })

            ).toList())

          ],)]))));
  }
}

