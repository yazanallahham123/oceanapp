import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:oceanapp/ui/home/home_page.dart';
import '../../common_widgets/app_widgets/custom_loading.dart';
import '../../common_widgets/buttons/custom_button.dart';
import '../../helper/app_colors.dart';
import '../../helper/const_styles.dart';
import '../../helper/size_config.dart';
import '../../main.dart';
import '../../utils/local_data.dart';
import '../../utils/misc.dart';

class LanguagePage extends StatefulWidget {
  static const route = "/language_page";


  const LanguagePage();

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

bool loading = false;

class _LanguagePageState extends State<LanguagePage> {

  String? currentLanguage = (languageCode == "en") ? "English" : "عربي";

  void initState() {
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
          child: Stack(children: [

            Column(children: [

              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsetsDirectional.only(
                    top: SizeConfig().h(100),
                    start: SizeConfig().w(20),
                    end: SizeConfig().w(20)),
                padding: EdgeInsets.symmetric(horizontal: SizeConfig().w(24)),
                decoration:
                BoxDecoration(color: Colors.white, borderRadius: radiusAll20),
                child:
                (loading == false) ?

                Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children: [
                    Padding(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Language", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("اللغة",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ],), padding: EdgeInsetsDirectional.fromSTEB(0,20, 0, 0),),

                    Padding(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 5, end: 5, top: SizeConfig().h(10), bottom:  SizeConfig().h(40)),
                            child: CustomButton(
                                title: "English",
                                onTap: () async {
                                  if (mounted) {
                                    setState(() {
                                      loading = true;
                                    });
                                  }
                                  hideKeyboard(context);

                                  currentLanguage = "English";
                                  await setLanguageValue("en");
                                  languageCode = "en";
                                  OceanApp.setLocale(context, Locale.fromSubtags(languageCode: "en"));
                                  changeLocale(context, "en");
                                  Get.updateLocale(Locale.fromSubtags(languageCode: "en"));
                                  Navigator.pushNamed(context, HomePage.route);
                                })), flex: 1,),
                        Expanded(child: Padding(
                            padding: EdgeInsetsDirectional.only( start: 5, end: 5, top: SizeConfig().h(10), bottom:  SizeConfig().h(40)),
                            child: CustomButton(
                                title: "عربي",
                                onTap: () async {
                                  if (mounted) {
                                    setState(() {
                                      loading = true;
                                    });
                                  }
                                  hideKeyboard(context);
                                  currentLanguage = "عربي";
                                  await setLanguageValue("ar");
                                  languageCode = "ar";
                                  OceanApp.setLocale(context, Locale.fromSubtags(languageCode: "ar"));
                                  changeLocale(context, "ar");
                                  Get.updateLocale(Locale.fromSubtags(languageCode: "ar"));

                                  Navigator.pushNamed(context, HomePage.route);
                                })),flex: 1,),
                      ],), padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),),

                  ],
                ) :
                Container(
                    height: SizeConfig().h(250),
                    child:
                    Center(child: CustomLoading()))
                ,
              )

            ],),
            ],),
        ));
  }
}
