
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';
import 'package:oceanapp/model/settings/device_settings.dart';
import 'package:oceanapp/ui/home/home_page.dart';
import 'package:oceanapp/ui/language/language_page.dart';
import 'package:oceanapp/ui/registration/registration_page.dart';
import 'package:oceanapp/utils/local_data.dart';
import 'package:oceanapp/utils/misc.dart';
import 'package:oceanapp/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'api/methods.dart';
import 'api/retrofit.dart';
import 'helper/app_colors.dart';
import 'helper/methods.dart';

final logger = Logger();
bool isSigned= false;
String languageCode = "";
String fullname = "";
String deviceId = "";

Map<String, dynamic> _deviceData = <String, dynamic>{};
DeviceSettings deviceSettings = DeviceSettings();
bool isRegistered = false;


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'ar']);

  languageCode = await getLanguage();

  fullname = await getFullname();

  ApiClient mClient = ApiClient(certificateClient());

  var uuid = Uuid();

  deviceId = await getUuid();

  if (deviceId == "") {
    deviceId = uuid.v1();
    await setUuid(deviceId);
  }

  DeviceSettings devSettings = await mClient.getSettings(deviceId);

  if (devSettings.deviceId != null) {
    deviceSettings = devSettings;
    await setIsRegistered(true);
    isRegistered = true;
  }
  else {
    await setIsRegistered(false);
    isRegistered = false;
  }

  runApp(LocalizedApp(delegate, OceanApp()));
}

class OceanApp extends StatefulWidget {
  @override
  _OceanApp createState() => _OceanApp();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _OceanApp? state = context.findAncestorStateOfType<_OceanApp>();
    state?.changeLanguage(newLocale);
  }

  static Locale? getLocale(BuildContext context) {
    _OceanApp? state = context.findAncestorStateOfType<_OceanApp>();
    return state?.getLanguageFromLocale();
  }
}

class _OceanApp extends State<OceanApp> with WidgetsBindingObserver{
  Locale _locale = Locale.fromSubtags(languageCode: languageCode.isEmpty ? "en" : languageCode);


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
    {
      print("app state is resumed");
    }
  }

  changeLanguage(Locale value) {
    if (mounted) {
      setState(() {
        _locale = value;
      });
    }
  }

  Locale getLanguageFromLocale()
  {
    return _locale;
  }


  @override
  Widget build(BuildContext context) {


    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: DismissKeyboard(child: GetMaterialApp(
          onGenerateInitialRoutes:
              (String initialRouteName) {

            if (!isRegistered)
              {
                return [
                  AppRouter.generateRoute(RouteSettings(name:
                  RegistrationPage.route,
                      arguments: null
                  ))
                ];
              }
            else {
              if (languageCode.isEmpty) {
                return [
                  AppRouter.generateRoute(RouteSettings(name:
                  LanguagePage.route,
                      arguments: null
                  ))
                ];
              }
              else {
                return [
                  AppRouter.generateRoute(RouteSettings(name:
                  HomePage.route,
                      arguments: null
                  ))
                ];
              }
            }

          },
          title: 'Ocean',
          onGenerateRoute: AppRouter.generateRoute,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            localizationDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: _locale,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: backgroundColor1,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light,
                  )
              ),
              primaryColor: primaryColor1,
              accentColor: primaryColor2,
              fontFamily: isArabic() ? 'Poppins' : 'Poppins'),
        )));
  }
}
