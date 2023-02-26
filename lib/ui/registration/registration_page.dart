import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:oceanapp/common_widgets/app_widgets/custom_loading.dart';
import 'package:oceanapp/common_widgets/buttons/custom_button.dart';
import 'package:oceanapp/common_widgets/custom_text_field_widgets/custom_textfield_widget.dart';
import 'package:oceanapp/helper/toast.dart';
import 'package:oceanapp/main.dart';
import 'package:oceanapp/ui/administration/administration_page.dart';
import 'package:oceanapp/ui/home/home_page.dart';
import 'package:oceanapp/ui/item/find_item_page.dart';
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

bool loading = false;

class RegistrationPage extends StatefulWidget {
  static const route = "/registration_page";

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

TextEditingController nameController = TextEditingController();
class _RegistrationPageState extends State<RegistrationPage> {

  int pageIndex = 0;

  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body: (loading) ? Center(child: CustomLoading(),) : Container(
              padding: EdgeInsetsDirectional.fromSTEB(10, 100, 10, 0),
              child:
              Column(children: [
                Padding(child: Text(translate("labels.enterYourName"),
                  style: TextStyle(fontSize: 15, color: Colors.white),),
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),),
              CustomTextFieldWidget(controller: nameController,
              hintText: translate("labels.enterYourName"),
              ),
              CustomButton(title: translate("buttons.save"),
              onTap: () async {
                await setFullname(nameController.text);
                ApiClient mClient = ApiClient(certificateClient());
                deviceSettings = DeviceSettings(deviceId: deviceId,
                canShowSales: false,
                  canReceiveTransfers: false,
                  canMakeTransfers: false,
                  branchId: "",
                  branchesToTransferTo: [],
                  branchesInSearch: [],
                  isAdmin: false,
                  username: "",
                  userId: "",
                  fullname: nameController.text
                );

                if (mounted) {
                  setState(() {
                    loading = true;
                    mClient.saveSettings(deviceSettings).then((value) async {
                      if (value) {
                        loading = false;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      }
                      else
                        {
                          loading = false;
                          pushToast(translate("errors.couldNotSaveSettings"));
                        }
                    });
                  });
                }
              },
              )
              ]))
    ));
  }
}