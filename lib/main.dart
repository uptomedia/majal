import 'dart:convert';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grodudes/pages/account/LogInPage.dart';
import 'package:grodudes/pages/navigation1.dart';
import 'package:grodudes/pages/on_board_screen.dart';
import 'package:grodudes/pages/splash_screen.dart';
import 'package:grodudes/routing/route_paths.dart';
import 'package:grodudes/routing/router.dart';
import 'package:grodudes/secret.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/helper/WooCommerceAPI.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:grodudes/Root.dart';
import 'core/configurations/styles.dart';
import 'core/configurations/theme/style.dart';
import 'core/constants.dart';
import 'core/loader_screen.dart';
import 'core/shared_preferences_items.dart';

import 'core/widget/waiting_screen.dart';
import 'generated/l10n.dart';
import 'l10n/L10n.dart';
import 'l10n/locale_provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Styles.colorPrimary,
    ),
  );
  await ScreenUtil.ensureScreenSize();

  ErrorWidget.builder = (FlutterErrorDetails details) => SizedBox(
        height: 0,
        width: 0,
      );
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // init(prefs);
  runApp(
      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) =>  // Wrap your app

      Phoenix(child: MyApp(prefs)
          // )
          ));
}

String baseUrl = "https://majalpharma.com/";
String consumerKey = "ck_bd95f0ad53c237138ff9ed32167818f92b48459b";
String consumerSecret = "cs_2f096006c59a429fcd225db47c0eb5ca4f17853c";

class MyApp extends StatelessWidget {
  final WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: Secret.baseUrl,
      consumerKey: Secret.consumerKey,
      consumerSecret: Secret.consumerSecret);

  final SharedPreferences preferences;
  MyApp(this.preferences);
  Locale getLocal(String index) {
    switch (index) {
      case 'en':
        return Locale('en');

      case 'ar':
        return Locale('ar');

      case "de":
        return Locale('de');

      default:
        return Locale('en');
    }
  }

  @override
  Widget build(BuildContext context) {
    var x;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsManager()),
        ChangeNotifierProvider(create: (_) => CartManager()),
        ChangeNotifierProvider(create: (_) => UserManager()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
        },
        child: ChangeNotifierProvider(
            create: (context) => LocaleProvider(),
            builder: (context, child) {
              final provider = Provider.of<LocaleProvider>(context);
              x = preferences.containsKey(SharedPreferencesKeys.LanguageCode)
                  ? preferences.getString(SharedPreferencesKeys.LanguageCode)
                  : 'en';

              provider.setLocale(getLocal(x), shouldUpdate: false);
              Constants.currentLocale = provider.locale.languageCode ?? 'en';
              Constants.scale = provider.scale ?? 1.0;
              return ScreenUtilInit(
                  designSize: Size(428 * Constants.scale,
                      928 * Constants.scale), //1080, 1920
                  minTextAdapt: true,
                  splitScreenMode: true,
                  builder: (BuildContext c) {
                    return MaterialApp(
                        title: 'pharma',
                        debugShowCheckedModeBanner: false,
                        localizationsDelegates: [
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          S.delegate
                        ],
                        onGenerateRoute: AppRouter.generateRoute,
                        supportedLocales:
                            // const Locale('en', ''), // English, no country code
                            // const Locale('ar', ''),
                            L10n.all,
                        locale: preferences
                                .containsKey(SharedPreferencesKeys.LanguageCode)
                            ? Locale(x.toString(), '')
                            : provider.locale,

                        // showPerformanceOverlay: true,
                        theme: appTheme.copyWith(
                          primaryColor: Styles.colorPrimary,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                        ),
                        // theme: appTheme,
// initialRoute: RoutePaths.SplashScreen ,
                        home: preferences
                                .containsKey(SharedPreferencesKeys.OnBoarding)
                            ? preferences
                                    .getBool(SharedPreferencesKeys.OnBoarding)!
                                ? SplashScreen()
                                : OnBoardScreen(preferences: preferences)
                            : OnBoardScreen(preferences: preferences));
                  });
            }),
      ),
    );
  }
}
