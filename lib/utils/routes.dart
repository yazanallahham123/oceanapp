import 'package:flutter/material.dart';
import 'package:oceanapp/ui/administration/administration_page.dart';
import 'package:oceanapp/ui/barcode_scanner/barcode_scanner_page.dart';
import 'package:oceanapp/ui/item/find_item_page.dart';
import 'package:oceanapp/ui/language/language_page.dart';
import 'package:oceanapp/ui/pos/pos_page.dart';
import 'package:oceanapp/ui/transfer/make_transfer_page.dart';

import '../ui/home/home_page.dart';
import '../ui/receive_transfer/receive_transfer_page.dart';
import '../ui/receive_transfer/transfer_details_page.dart';
import '../ui/registration/registration_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case POSPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => POSPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case AdministrationPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => AdministrationPage(onSaved: (){},),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case FindItemPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => FindItemPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case RegistrationPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => RegistrationPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case TransferDetailsPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => TransferDetailsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case ReceiveTransferPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => ReceiveTransferPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case FindItemPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => FindItemPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case HomePage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case BarcodeScannerPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => BarcodeScannerPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case LanguagePage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => LanguagePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case MakeTransferPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => MakeTransferPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },);
      default:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
    }
  }
}
