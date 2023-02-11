import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/core/loader_screen.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/helper/WooCommerceAPI.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../Root.dart';
import '../core/configurations/assets.dart';
import '../core/utils.dart';
import '../models/dataFull.dart';
import '../routing/route_paths.dart';
import '../secret.dart';
import 'navigation.dart';
import 'navigation1.dart';

class SplashScreen extends StatefulWidget {
  final int moduleId;
  SplashScreen({this.moduleId = 0});
  @override
  State<StatefulWidget> createState() => _SplashcreenState();
}

class _SplashcreenState extends State<SplashScreen> {
  int APICall = 0;
  // AppStateModel? appState;
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) =>
        Provider.of<ProductsManager>(context, listen: false)
            .fetchAllParentCategories(shouldupdate: false, fromSplash: true));
    WidgetsBinding.instance?.addPostFrameCallback((_) =>
        Provider.of<ProductsManager>(context, listen: false)
            .fetchLatestProducts(shouldNotify: false, fromSplash: true));
    WidgetsBinding.instance?.addPostFrameCallback((_) =>
        Provider.of<ProductsManager>(context, listen: false)
            .fetchPopularProducts(shouldNotify: false, fromSplash: true));
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Container(
            child: Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: true, //new line

                body: FutureBuilder(
                    future: loadData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Root();
                      }
                      if (snapshot.hasData) {
                        SchedulerBinding.instance!.addPostFrameCallback(
                            (_) => showPincodeDialog(context));
                        if (snapshot.data['maintenance'] == true) {
                          return _AppLoadException(
                              'We are currently in maintenance mode. Sorry for the inconvenience');
                        }
                        if (snapshot.data['startup_fail'] == true) {
                          return _AppLoadException(
                              'Failed to load data. Please Check your Internet Connection');
                        }
                        if (snapshot.data['wpUser'] != null &&
                            snapshot.data['wcUser'] != null) {
                          Provider.of<UserManager>(context, listen: false)
                              .initializeUser(snapshot.data['wpUser'],
                                  snapshot.data['wcUser']);
                        }
                        if (snapshot.data['cartItems'] != null &&
                            snapshot.data['cartItems'] is List<Product>) {
                          List<Product> localCartProducts =
                              snapshot.data['cartItems'];
                          List<Product> cartt = snapshot.data['cart'];
                          print(snapshot.data);
                          String cart_key = snapshot.data["cart_key"];
                          double total = snapshot.data['total'];

                          Provider.of<ProductsManager>(context, listen: false)
                              .setProductsFromLocalCart(localCartProducts);
                          Provider.of<CartManager>(context, listen: false)
                              .setCartItemsFromLocalData(
                                  cartt, cart_key, total);
                          // Provider.of<CartManager>(context, listen: false)
                          //     .setWishCartItemsFromLocalData(cartt);
                        }

                        if (Provider.of<ProductsManager>(context, listen: false)
                                .ApiCall >=
                            3) {
                          Utils.popNavigateToFirst(context);
                          Utils.pushReplacementNavigateTo(
                              context,
                              //false,
                              RoutePaths.NavigationScreen,
                              arguments: 0);
                          // return NavigationScreen();
                        }
                      }
                      return Consumer<ProductsManager>(
                          builder: (context, productsManager, child) {
                        return Provider.of<ProductsManager>(context,
                                        listen: false)
                                    .ApiCall >
                                2
                            ? NavigationScreen()
                            : _AppLoadingScreen();
                      });
                    }))));
  }

  final WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: Secret.baseUrl,
      consumerKey: Secret.consumerKey,
      consumerSecret: Secret.consumerSecret);

  Future loadData() async {
    List<Product> cart = [];
    List<Product> localCartItems = [];
    List<Product> localWishItems = [];
    String cartKey = "";
    double total = 0.0;
    try {
      FlutterSecureStorage _storage = FlutterSecureStorage();
      String? criddentials = await _storage.read(key: "auth_data");
      Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Basic ' + criddentials!
      };
      var response = await http.get(
        Uri.parse("${Secret.baseUrl}/wp-json/cocart/v2/cart/"),
        headers: headers,
      );
      print(response.body);
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      await prefs.setString(localCartStorageKey, response.body);
      String? cartData = prefs.getString(localCartStorageKey);
      String? wishData = prefs.getString(localWishStorageKey);
      if (cartData != null) {
        var items = json.decode(cartData);
        total = double.parse(items["totals"]["total"]) / 100 ?? 0.0;
        cartKey = items["cart_key"];
        print(items);
        Map<String, Map<String, dynamic>> itemKeys = {};
        (items["items"] as List<dynamic>).forEach((item) {
          print(item);
          if (item['id'] != null && item['id'] is int) {
            itemKeys[item['item_key']] = {
              'id': item['id'],
              "quantity": item['quantity']["value"] ?? 1,
              "item_key": item['item_key']
            };
          }
        });
        List<int> itemsIds =
            itemKeys.values.map((e) => e['id'] as int).toList();
        print(".....................");
        if (itemKeys.length > 0) {
          APICall = APICall + 1;

          List<dynamic> fetchedCartItems = await fetchCartItems(itemsIds);
          fetchedCartItems.forEach((item) {
            var itemData = itemKeys.values
                .firstWhere((element) => element["id"] == item["id"]);
            Product product = Product(item);
            product.quantity = itemData["quantity"] ?? 1;
            product.item_key = itemData["item_key"] ?? "";
            localCartItems.add(product);
          });
          (items["items"] as List<dynamic>).forEach((item) {
            Product product = Product(item);
            product.quantity = item["quantity"]["value"] ?? 1;
            product.item_key = item["item_key"] ?? "";
            cart.add(product);
          });
        }
      }
      if (wishData != null) {
        List<dynamic> localWishItemstmp = json.decode(wishData);
        for (int i = 0; i < localWishItemstmp.length; i++) {
          localWishItems.add(new Product(localWishItemstmp[i]));
        }
        Provider.of<CartManager>(context, listen: false).cartWishItems =
            localWishItems; // Map<int, int> wishIds = {};

      }
    } catch (err) {
      print(err);
      localCartItems = [];
    }

    try {
      // check for previous logins
      FlutterSecureStorage _storage = FlutterSecureStorage();
      var isLoggedIn = await _storage.read(key: 'grodudes_login_status');

      // fetch user details if the user was logged in
      if (isLoggedIn != null && isLoggedIn == 'true') {
        String? wpUserInfoString = await _storage.read(key: 'grodudes_wp_info');
        String? wcUserInfoString = await _storage.read(key: 'grodudes_wc_info');
        print(wcUserInfoString);
        Map<String, dynamic> wpUserInfo = {};
        Map<String, dynamic> wcUserInfo = {};
        if (wpUserInfoString != null) {
          wpUserInfo = json.decode(wpUserInfoString);
          String token = wpUserInfo['jwt_token'];
          if (token != null) {
            wcUserInfo = json.decode(
                wcUserInfoString ?? token); //await fetchUserData(token);
          }
        }

        return {
          'success': true,
          'cartItems': localCartItems,
          'wcUser': wcUserInfo,
          'wpUser': wpUserInfo,
          'cart_key': cartKey,
          'cart': cart,
          'total': total
        };
      }
    } catch (err) {
      print(err);
    }
    return {
      'success': true,
      'cartItems': localCartItems,
      'cart_key': cartKey,
      'total': total,
      'cart': cart,
    };
  }

  Future fetchCartItems(List<int> ids) async {
    List<dynamic> fetchedProducts = [];
    try {
      APICall = APICall + 1;
      String includeString = ids.join(',');
      fetchedProducts =
          await this.wooCommerceAPI.getAsync('products?include=$includeString');
      return fetchedProducts;
    } catch (err) {
      fetchedProducts = [];
      return fetchedProducts;
    }
  }

  Future fetchUserData(String token) async {
    int id = await this.wooCommerceAPI.getLoggedInUserId(token);
    if (id == null) return;
    var response = await this.wooCommerceAPI.getAsync('customers/$id');
    if (response['id'] == null) return;
    return response;
  }

  showPincodeDialog(BuildContext context) async {
    bool firstTime = false;

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var storedValue = prefs.get('grodudes_first_run');

    if (storedValue == null) firstTime = true;
    if (!firstTime) return;

    TextEditingController controller = TextEditingController();
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return SimpleDialog(
    //       contentPadding: EdgeInsets.all(8),
    //       title: Text('Check if we can reach you'),
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 16),
    //           child: TextField(
    //             controller: controller,
    //             decoration: InputDecoration(
    //               hintText: 'eg. 712201',
    //               labelText: 'Pincode',
    //               labelStyle:
    //                   TextStyle(color: GrodudesPrimaryColor.primaryColor[700]),
    //               focusedBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                       color: GrodudesPrimaryColor.primaryColor[600]!,
    //                       width: 2)),
    //               border: OutlineInputBorder(
    //                   borderSide: BorderSide(color: Colors.blue)),
    //               contentPadding:
    //                   EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    //             ),
    //             onSubmitted: (value) {
    //               bool isPresent = pincodes.contains(value);
    //               registerFirstUsage(context, isPresent);
    //               prefs
    //                   .setString('grodudes_first_run', 'true')
    //                   .catchError((err) => print(err));
    //             },
    //           ),
    //         ),
    //         // Align(
    //         //   alignment: Alignment.centerRight,
    //         //   child: MaterialButton(
    //         //     child: Text('Check'),
    //         //     onPressed: () {
    //         //       String value = controller.text;
    //         //       bool isPresent = pincodes.contains(value);
    //         //       registerFirstUsage(context, isPresent);
    //         //       prefs
    //         //           .setString('grodudes_first_run', 'true')
    //         //           .catchError((err) => print(err));
    //         //     },
    //         //   ),
    //         // )
    //       ],
    //     );
    //   },
    // );
  }
}

class _AppLoadException extends StatelessWidget {
  final String title;
  _AppLoadException(this.title);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        color: GrodudesPrimaryColor.primaryColor[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text(S.of(context).splashMessage,
            //   style: Styles.splashTextStyle,),
            // SvgPicture.asset(
            //   'assets/images/grodudes_logo_svg.svg',
            //   height: 150,
            //   width: 150,
            //   placeholderBuilder: (context) => Container(),
            //   alignment: Alignment.center,
            //   fit: BoxFit.contain,
            // ),
            SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppLoadingScreen extends StatelessWidget {
  late VideoPlayerController _controller;

  final listOfAnimations = <AppBody>[
    AppBody(
      'waveDots',
      LoadingAnimationWidget.waveDots(
        color: Styles.colorPrimary,
        size: 100.h,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // color: GrodudesPrimaryColor.primaryColor[800],
        body: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          SizedBox(
              height: 250.h,
              child: Center(
                child: Image.asset(
                  Assets.PNG_SplashImage,
                  color: Styles.colorPrimary,
                ),
              )),
          SizedBox(
            height: 100.h,
          ),
          Expanded(
            child: Center(
              child: listOfAnimations.first.widget,
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    ));
  }
}
