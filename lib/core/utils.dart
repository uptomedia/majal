import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:collection/collection.dart';

import 'configurations/app_configuration.dart';

class Utils {
  static String token = '';


  static void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void showToastWithColor(String message ) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message);
  }

  static void pushNavigateTo(context, bool withNavBar, String route,
      {arguments}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushNamed(route, arguments: arguments);
    });
  }

  static Future<T?> pushNewScreenWithRouteSettings<T>(
      BuildContext context, {
        required Widget screen,
        required RouteSettings settings,
        bool? withNavBar,
        PageTransitionAnimation pageTransitionAnimation =
            PageTransitionAnimation.cupertino,
        PageRoute? customPageRoute,
      }) {
    if (withNavBar == null) {
      withNavBar = true;
    }

    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(
        customPageRoute ??
            getPageRoute(pageTransitionAnimation,
                enterPage: screen, settings: settings));

    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(
        customPageRoute as Route<T>? ??
            // getPageRoute(
            //     enterPage: screen, settings: settings));
            PageRouteBuilder(
                settings: settings,
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                screen));
  }

  static void pushReplacementNavigateTo(context, String route, {arguments}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
    });
  }

  static Future<T?> pushDynamicScreen<T>(
      BuildContext context, {
        required dynamic screen,
        bool? withNavBar,
      }) {
    if (withNavBar == null) {
      withNavBar = true;
    }
    return Navigator.of(context, rootNavigator: !withNavBar).push<T>(screen);
  }

  static void popNavigate(context, {int popsCount = 1, bool value=false}) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      for (int i = 0; i < popsCount; i++) {
        Navigator.of(context).pop(value);
      }
    });
  }

  static void popNavigateToFirst(context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    });
  }

  static void clearAndPush(context, newRouteName) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(newRouteName, (route) => false);
    });
  }


 }
