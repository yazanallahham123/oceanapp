import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:oceanapp/bloc/item/state.dart';
import 'package:oceanapp/common_widgets/buttons/custom_button.dart';
import 'package:oceanapp/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:oceanapp/model/dto/search_body.dart';
import 'package:oceanapp/model/item/search_result.dart';
import 'package:oceanapp/ui/barcode_scanner/barcode_scanner_page.dart';
import 'package:oceanapp/ui/home/home_page.dart';
import '../../bloc/item/bloc.dart';
import '../../bloc/item/event.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../main.dart';
import '../../model/customer/customer.dart';
import '../../model/item/pos_item.dart';
import '../../widgets/pos_item_widget.dart';
import '../../widgets/search_result_widget.dart';

class POSPage extends StatefulWidget {
  static const route = "/pos_page";

  const POSPage();

  @override
  State<POSPage> createState() => _POSPageState();
}

bool loading = false;
TextEditingController searchController = new TextEditingController();
List<POSItem> items = [];
bool hideCheckout = false;

bool enterCustomerNumber = false;
bool enterItemToCancel = false;
bool enterItemToReturn = false;
Customer? currentCustomer = null;

class _POSPageState extends State<POSPage> {
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

          } else if (state is ErrorItemState)
            pushToast(state.error);
          else if (state is FoundItemState) {

            if (mounted) {
              setState(() {
                if ((!enterCustomerNumber) &&
                    (!enterItemToCancel) &&
                    (!enterItemToReturn)) {
                  if (state.result.items.length > 0) {
                    POSItem posItem = POSItem(item: state.result.items[0], isReturn: false);
                    items.add(posItem);
                  }
                }
                else {
                    if (enterItemToReturn) {
                      if (state.result.items.length > 0) {
                        POSItem posItem = POSItem(item: state.result.items[0], isReturn: true);
                        items.add(posItem);
                      }
                    }
                  }
              });
            };

          }
          else if (state is FoundCustomerState) {
            if (state.customer != null)
              {
                if (mounted) {
                  setState(() {
                    currentCustomer = state.customer;
                    enterCustomerNumber = false;
                  });
                }
              }
            else
              {

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

class _BuildUIState extends State<_BuildUI> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        appBar: AppBar(
            backgroundColor: backgroundColor1,
            toolbarHeight: SizeConfig().h(175),
            automaticallyImplyLeading: false,
            flexibleSpace: Center(child: Padding(child:

            Column(children: [
            CustomButton(title: "Branch"),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: CustomTextFieldWidget(
                        controller: searchController,
                        hintText: translate("labels.enterText"),
                        onFieldSubmitted: (x) {
                          if (mounted) {
                            setState(() {
                              if ((!enterCustomerNumber) &&
                                  (!enterItemToCancel) &&
                                  (!enterItemToReturn)) {
                                SearchBody sb = SearchBody(byComputerNo: false,
                                    searchText: searchController.text,
                                    colorId: "0",
                                    sizeId: "0",
                                    branchId:
                                        deviceSettings.branchId!);
                                widget.bloc.add(FindItemEvent(sb));
                              }
                              else {
                                if (enterCustomerNumber) {
                                  widget.bloc.add(
                                      FindCustomerEvent(searchController.text));
                                }
                                else {
                                  if (enterItemToReturn) {
                                    SearchBody sb = SearchBody(
                                        byComputerNo: false,
                                        searchText: searchController.text,
                                        colorId: "0",
                                        sizeId: "0",
                                        branchId:
                                            deviceSettings.branchId!);
                                    widget.bloc.add(FindItemEvent(sb));
                                  }
                                  else {
                                    if (enterItemToCancel) {
                                      items.removeWhere((x) =>
                                      x.item!.barcode == searchController.text);

                                      enterItemToCancel = false;
                                    }
                                  }
                                }
                              }
                            });
                          };
                        },
                      )),
                  IconButton(
                      onPressed: () async {
                        String? barcodeScanRes = await Navigator.pushNamed(context, BarcodeScannerPage.route) as String?;
                        if (barcodeScanRes != null)
                        {
                          if (barcodeScanRes.isNotEmpty)
                          {
                            searchController.text = barcodeScanRes;
                          }
                        }
                      },
                      icon: Icon(Icons.document_scanner_outlined, color: Colors.white,))
                ]),
              Row(children: [
                CustomButton(title: (!enterCustomerNumber) ? (currentCustomer != null) ? currentCustomer!.name! : "Set Customer" : "Find Customer",
                onTap: () {
                  if (mounted) {
                    setState(() async {
                      if (enterCustomerNumber) {
                        widget.bloc.add(
                            FindCustomerEvent(searchController.text));
                      }
                      else {
                        enterCustomerNumber = true;
                      }
                    });
                  };
                }
                ),
                CustomButton(title: (!enterItemToReturn) ? "Return" : "End Return",
                onTap: (){
                  if (!enterItemToReturn)
                    {
                      setState(() {
                        enterItemToReturn = true;
                      });
                    }
                  else
                    {
                      SearchBody sb = SearchBody(
                          byComputerNo: false,
                          searchText: searchController.text,
                          colorId: "0",
                          sizeId: "0",
                          branchId:
                              deviceSettings.branchId!);
                      widget.bloc.add(FindItemEvent(sb));
                    }
                },
                ),
                CustomButton(title: (!enterItemToCancel) ? "Cancel Item" : "End Cancel",
                  onTap: (){
                    if (!enterItemToCancel)
                    {
                      setState(() {
                        enterItemToCancel = true;
                      });
                    }
                    else
                    {
                      setState(() {
                        items.removeWhere((x) =>
                        x.item!.barcode == searchController.text);

                        enterItemToCancel = false;
                      });
                    }
                  },
                ),
              ],)
            ],)

              , padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),))),
        bottomNavigationBar: Container(child:
        (hideCheckout) ? Container() : CustomButton(title: "Checkout",
          )
          ,) ,
        body:
        (widget.state is LoadingItemState) ? Center(child: CustomLoading(),) :
        SingleChildScrollView(child:
        Stack(children: [
          Column(children: items.map((i) {
            return POSItemWidget(posItem: i,);
          }).toList()),
        ]))

    );
  }
}
