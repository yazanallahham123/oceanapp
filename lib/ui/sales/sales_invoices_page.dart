import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:oceanapp/common_widgets/app_widgets/custom_loading.dart';
import 'package:oceanapp/common_widgets/buttons/custom_button.dart';
import 'package:oceanapp/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:oceanapp/model/currency/currency.dart';
import 'package:oceanapp/model/dto/search_body.dart';
import 'package:oceanapp/model/transfer/transfer_body.dart';
import 'package:oceanapp/model/transfer/transfer_detail.dart';
import 'package:oceanapp/ui/sales/sales_invoice_details_page.dart';
import 'package:oceanapp/widgets/transfer_item_widget.dart';
import '../../bloc/item/bloc.dart';
import '../../bloc/item/event.dart';
import '../../bloc/item/state.dart';
import '../../common_widgets/app_widgets/back_button_widget.dart';
import '../../helper/app_colors.dart';
import '../../helper/size_config.dart';
import '../../helper/toast.dart';
import '../../model/branch/branch.dart';
import '../../model/invoice/invoice.dart';
import '../../model/item/item.dart';
import '../../model/transfer/transfer_master.dart';
import '../../widgets/transfer_detail_widget.dart';
import '../../widgets/sales_invoice_widget.dart';

class SalesInvociesPage extends StatefulWidget {
  static const route = "/transfer_details_page";

  final String? branchId;
  final String? fromDate;
  final String? toDate;

  const SalesInvociesPage({this.branchId, this.fromDate, this.toDate});

  @override
  State<SalesInvociesPage> createState() => _SalesInvociesPageState();
}

class _SalesInvociesPageState extends State<SalesInvociesPage> {
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
            if (widget.branchId != null)
              if (!bloc.isClosed)
                bloc.add(GetSalesInvoicesEvent(widget.branchId!, widget.fromDate!, widget.toDate!));
          } else if (state is ErrorItemState)
            pushToast(state.error);
          else if (state is GotSalesInvoicesState)
          {
            if (mounted) {
              setState(() {
                if (state.invoices.isNotEmpty) {
                  details = state.invoices;
                }
                else
                  pushToast(translate("errors.noInvoices"));
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
List<Invoice> details = [];


class _BuildUIState extends State<_BuildUI> {

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: backgroundColor1,
        body: SafeArea(child:

        SingleChildScrollView(child: Stack(children : [
          (widget.state is LoadingItemState) ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(child: CustomLoading(),)) :
          Column(children: [

            Align(child: BackButtonWidget(context), alignment: AlignmentDirectional.topStart,),

            Column(children: details.map((x) =>
                SalesInvoiceWidget(
                    invoice: x, onShowDetails: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SalesInvoiceDetailsPage(BLNO: x.blno)));
                },

                )

            ).toList())

          ],)]))));
  }
}

