import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:oceanapp/common_widgets/app_widgets/custom_loading.dart';
import 'package:oceanapp/common_widgets/buttons/custom_button.dart';
import 'package:oceanapp/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:oceanapp/model/currency/currency.dart';
import 'package:oceanapp/model/dto/date_filter.dart';
import 'package:oceanapp/model/dto/search_body.dart';
import 'package:oceanapp/model/transfer/transfer_body.dart';
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
import '../../model/settings/device_settings.dart';
import '../../model/user/user.dart';
import '../../utils/misc.dart';
import '../../widgets/device_widget.dart';
import '../../widgets/sales_widget.dart';

class BarcodeScannerPage extends StatefulWidget {
  static const route = "/barcode_scanner_page";

  const BarcodeScannerPage();

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: MobileScanner(onDetect: (Barcode barcode, MobileScannerArguments? args) {
      Navigator.pop(context, barcode.rawValue??"");
    },)));
  }
}

