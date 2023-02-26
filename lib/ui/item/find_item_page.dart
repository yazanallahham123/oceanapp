import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:oceanapp/bloc/item/state.dart';
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
import '../../widgets/search_result_widget.dart';

class FindItemPage extends StatefulWidget {
  static const route = "/find_item_page";

  const FindItemPage();

  @override
  State<FindItemPage> createState() => _FindItemPageState();
}

bool loading = false;
TextEditingController searchController = new TextEditingController();
SearchResult searchResult = new SearchResult(colors: [], items: [], sizes: [], branches: []);
String activeColorId = "";
String activeSizeId = "";
String size = "0";
String color = "0";

class _FindItemPageState extends State<FindItemPage> {
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
                searchResult =
                new SearchResult(colors: [], items: [], sizes: [], branches: []);
                searchController.text = "";
                size = "0";
                color = "0";
              });
            }
          } else if (state is ErrorItemState)
            pushToast(state.error);
          else if (state is FoundItemState) {
            if (mounted) {
              setState(() {
                searchResult = SearchResult(items: [], colors: [], sizes: [], branches: []);
                searchResult.items.addAll(state.result.items);
                searchResult.colors.addAll(state.result.colors);
                searchResult.sizes.addAll(state.result.sizes);

                if (deviceSettings.branchId  != null)
                  {
                    if (deviceSettings.branchId!.isNotEmpty)
                      {
                        if (state.result.branches.firstWhereOrNull((x) => x.id == deviceSettings.branchId!) != null) {
                          searchResult.branches.add(
                              state.result.branches.firstWhere((x) => x.id ==
                                  deviceSettings.branchId!));


                          if (deviceSettings.branchesInSearch != null) {

                            if (deviceSettings.branchesInSearch!.length > 0) {
                              state.result.branches.where((n) =>
                              n.id !=
                                  deviceSettings.branchId!).forEach((ibr) {
                                if (deviceSettings.branchesInSearch!
                                    .firstWhereOrNull((b) => b == ibr.id) !=
                                    null)
                                  searchResult.branches.add(ibr);
                              });
                            }
                            else
                              searchResult.branches.addAll(state.result.branches.where((n) =>
                              n.id !=
                                  deviceSettings.branchId!));

                          }
                          else
                            searchResult.branches.addAll(state.result.branches.where((n) =>
                            n.id !=
                                deviceSettings.branchId!));
                        }
                        else {
                          if (deviceSettings.branchesInSearch != null) {
                            if (deviceSettings.branchesInSearch!.length > 0) {
                              state.result.branches.forEach((ibr) {
                                if (deviceSettings.branchesInSearch!
                                    .firstWhereOrNull((b) => b == ibr.id) !=
                                    null)
                                  searchResult.branches.add(ibr);
                              });
                            }
                            else
                              searchResult.branches.addAll(
                                  state.result.branches);
                          }
                else
              {
                searchResult.branches.addAll(state.result.branches);
              }

                        }
                      }
                    else {
                      if (deviceSettings.branchesInSearch != null) {
                        if (deviceSettings.branchesInSearch!.length > 0) {
                          state.result.branches.forEach((ibr) {
                            if (deviceSettings.branchesInSearch!
                                .firstWhereOrNull((b) => b == ibr.id) !=
                                null)
                              searchResult.branches.add(ibr);
                          });
                        }
                        else
                          searchResult.branches.addAll(
                              state.result.branches);
                      }
                      else
                      {
                        searchResult.branches.addAll(state.result.branches);
                      }
                    }
                  }
                else {
                  if (deviceSettings.branchesInSearch != null) {
                    if (deviceSettings.branchesInSearch!.length > 0) {
                      state.result.branches.forEach((ibr) {
                        if (deviceSettings.branchesInSearch!
                            .firstWhereOrNull((b) => b == ibr.id) !=
                            null)
                          searchResult.branches.add(ibr);
                      });
                    }
                    else
                      searchResult.branches.addAll(
                          state.result.branches);
                  }
                  else
                  {
                    searchResult.branches.addAll(state.result.branches);
                  }
                }




                if (state.result.items.isNotEmpty) {
                     if (deviceSettings.branchesInSearch != null) {
                    if (deviceSettings.branchesInSearch!.length > 0) {
                      searchResult.items.clear();

                      state.result.items.forEach((ibr) {
                        if (deviceSettings.branchesInSearch!.firstWhereOrNull((b) => b == ibr.branchId) != null)
                          searchResult.items.add(ibr);
                      });

                      if (searchResult.items.isEmpty)
                        {
                          pushToast(translate("errors.noItemsFound"));
                          searchResult = SearchResult(items: [], colors: [], sizes: [], branches: []);
                          size = "0";
                          color = "0";
                        }
                    }
                    else
                      searchResult = state.result;
                  }
                  else
                    searchResult = state.result;

                }
                else {
                  pushToast(translate("errors.noItemsFound"));
                  searchResult = SearchResult(items: [], colors: [], sizes: [], branches: []);
                  size = "0";
                  color = "0";
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

class _BuildUIState extends State<_BuildUI> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        appBar: AppBar(
          backgroundColor: backgroundColor1,
          toolbarHeight: SizeConfig().h(75),
            automaticallyImplyLeading: false,
            flexibleSpace: Center(child: Padding(child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          Expanded(
              child: CustomTextFieldWidget(
                controller: searchController,
                hintText: translate("labels.enterText"),
                onFieldSubmitted: (x) {
                  color = "0";
                  size = "0";
                  activeColorId = "";
                  activeSizeId = "";
                  findItem();
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
                        findItem();
                      }
                  }
              },
              icon: Icon(Icons.document_scanner_outlined, color: Colors.white,))
        ]), padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),))),
        body:
        (widget.state is LoadingItemState) ? Center(child: CustomLoading(),) :
            SingleChildScrollView(child:
            Stack(children: [
              Column(children: [


              (searchResult.items.length > 0) ?
              Container(
                  margin: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: radiusAll16),
                  padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Image.network("http://192.99.16.179:9022/Photos/${searchResult.items[0].computerNo}.jpg",
                          //Expanded(child: Image.network("http://82.137.238.57:8877/Photos/${searchResult.items[0].computerNo}.jpg",
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
                          )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/1.5 - SizeConfig().w(25),
                                child: Padding(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                              child: Align(
                                                child: Text(
                                                  translate("labels.regularPrice"),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      decoration: (searchResult.items[0].sale != "" &&
                                                          searchResult.items[0].sale != "0" &&
                                                          searchResult.items[0].sale != searchResult.items[0].price)
                                                          ? TextDecoration.lineThrough
                                                          : TextDecoration.none),
                                                ),
                                                alignment:
                                                AlignmentDirectional.center,
                                              ),
                                              color: Colors.white,
                                            )),
                                        (searchResult.items[0].sale != "" &&
                                            searchResult.items[0].sale != "0" &&
                                            searchResult.items[0].sale != searchResult.items[0].price)
                                            ? Expanded(
                                            child: Container(
                                                child: Align(
                                                    child: Text(
                                                     translate("labels.salePrice"),
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.red),
                                                    ),
                                                    alignment:
                                                    AlignmentDirectional
                                                        .center),
                                                color: Colors.white))
                                            : Container(),
                                      ],
                                    ),
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/1.5 - SizeConfig().w(25),
                                child: Padding(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                              child: Align(
                                                child: Text(
                                                  searchResult.items[0].price ?? "",
                                                  style: TextStyle(
                                                      decoration: (searchResult.items[0].sale != "" &&
                                                          searchResult.items[0].sale != "0" &&
                                                          searchResult.items[0].sale != searchResult.items[0].price)
                                                          ? TextDecoration.lineThrough
                                                          : TextDecoration.none),
                                                ),
                                                alignment:
                                                AlignmentDirectional.center,
                                              ),
                                              color: Colors.white,
                                            )),
                                        (searchResult.items[0].sale != "" &&
                                            searchResult.items[0].sale != "0" &&
                                            searchResult.items[0].sale != searchResult.items[0].price)
                                            ? Expanded(
                                            child: Container(
                                                child: Align(
                                                    child: Text(
                                                      searchResult.items[0].sale ?? "",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    alignment:
                                                    AlignmentDirectional
                                                        .center),
                                                color: Colors.white))
                                            : Container(),
                                      ],
                                    ),
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0)),
                              ),

                              Container(
                                  width: MediaQuery.of(context).size.width/1.5 - SizeConfig().w(25),
                                  child:
                              (searchResult.colors.length > 0) ?
                              Tags(
                                itemCount: searchResult.colors.length,
                                itemBuilder: (int index) {
                                  return new ItemTags(
                                    title: searchResult.colors[index].name ?? "",
                                    index: index,
                                    active: (searchResult.colors[index].id ==
                                        activeColorId),
                                    onPressed: (item) {
                                      if (mounted) {
                                        setState(() {

                                          if ((item.active??false) == true)
                                          {
                                            activeColorId =
                                                searchResult.colors[index].id ?? "";
                                            if (activeColorId != "")
                                              color = activeColorId;
                                            else
                                              color = "0";
                                          }
                                          else
                                          {
                                            color = "0";
                                            activeColorId = "";
                                          }

                                          /*if (activeColorId == "") {
                                            activeColorId =
                                                searchResult.colors[index].id ?? "";
                                            if (activeColorId != "")
                                              color = int.parse(activeColorId);
                                            else
                                              color = 0;
                                          } else {
                                            color = 0;
                                            activeColorId = "";
                                          }*/

                                          SearchBody withSizesSearch = new SearchBody(
                                              byComputerNo: false,
                                              searchText: searchController.text,
                                              colorId: color,
                                              sizeId: size,
                                            branchId: "0");
                                          widget.bloc
                                              .add(FindItemEvent(withSizesSearch));
                                        });
                                      }
                                    },
                                  );
                                },
                              )
                                  : Container(),),
                              Container(
                                width: MediaQuery.of(context).size.width/1.5 - SizeConfig().w(25),
                                child:

                                (searchResult.sizes.length > 0) ?
                              Tags(
                                itemCount: searchResult.sizes.length,
                                itemBuilder: (int index) {
                                  return new ItemTags(
                                    title: searchResult.sizes[index].name ?? "",
                                    index: index,
                                    active:
                                    (searchResult.sizes[index].id == activeSizeId),
                                    onPressed: (item) {
                                      if (mounted) {
                                        setState(() {
                                          if ((item.active??false) == true)
                                            {
                                              activeSizeId =
                                                  searchResult.sizes[index].id ?? "";
                                              if (activeSizeId != "")
                                                size = activeSizeId;
                                              else
                                                size = "0";
                                            }
                                          else
                                            {
                                              size = "0";
                                              activeSizeId = "";
                                            }
                                          /*print(item);
                                          if (activeSizeId == "") {
                                            activeSizeId =
                                                searchResult.sizes[index].id ?? "";
                                            if (activeSizeId != "")
                                              size = int.parse(activeSizeId);
                                            else
                                              size = 0;
                                          } else {
                                            size = 0;
                                            activeSizeId = "";
                                          }*/

                                          SearchBody withSizesSearch = new SearchBody(
                                              byComputerNo: false,
                                              searchText: searchController.text,
                                              colorId: color,
                                              sizeId: size,
                                          branchId: "0");
                                          widget.bloc
                                              .add(FindItemEvent(withSizesSearch));
                                        });
                                      }
                                    },
                                  );
                                },
                              )
                                  : Container()),


                            ],
                          ),


                        ],
                      )
                    ],
                  )) : Container(),

                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchResult.branches.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                          textColor: Colors.white,
                          collapsedBackgroundColor: Colors.white,
                          title: Text(searchResult.branches[index].arabicName!,),
                      children: searchResult.items.where((xx) => xx.branchId == searchResult.branches[index].id!).map((x){
                        return SearchResultWidget(
                              item: x);
                      }
                      ).toList()
                      );
                })
              ]),
            ]))

              );
  }

  findItem() {
    SearchBody searchBody = new SearchBody(
        byComputerNo: false,
        searchText: searchController.text,
        colorId: "0",
        sizeId: "0",
    branchId: "0");
    if (!widget.bloc.isClosed)
      widget.bloc.add(FindItemEvent(searchBody));
  }
}
