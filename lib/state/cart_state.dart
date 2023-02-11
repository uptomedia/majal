import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:grodudes/helper/WooCommerceAPI.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/models/coupon.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/disturber.dart';
import '../secret.dart';

const String localCartStorageKey = 'grodudes_cart_data';
const String localWishStorageKey = 'grodudes_cart_wish_data';

enum cartStates {
  init,
  loaded,
  pending,
}

class CartManager with ChangeNotifier {
  List<Product> cartItems = [];
  List<Product> filterCartItems = [];
  List<Disturber> distrubersList = [];
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  late Map<String, dynamic>? wpUserInfo;
  late Map<String, dynamic>? wcUserInfo;
  String cart_key = "";

  double total = 0;
  double totalFiltered = 0;
  double amount = 0;
  Coupon coupon = new Coupon({});
  List<Product> cartWishItems = [];
  List<int> filteredIds = [];
  var cartState;

  late Future<SharedPreferences> _prefs;
  CartManager() {
    cartItems = [];
    filterCartItems = [];
    filteredIds = [];
    this.cartState = cartStates.init;
    this._prefs = SharedPreferences.getInstance();
  }
  WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: Secret.baseUrl,
      consumerKey: Secret.consumerKey,
      consumerSecret: Secret.consumerSecret);
  Future applyCoupon(String s) async {
    // /wp-json/wc/v3/coupons/?code=your_coupon_code
    this.amount = 0;
    if (this.cartState != cartStates.pending) {
      this.cartState = cartStates.pending;
      notifyListeners();
    }
    List<dynamic> data1 =
        await wooCommerceAPI.applyCoupon(s).catchError((err) => print(err));
    // if(data.s)
    // coupon?.data=data!;
    if (data1.length != 0) {
      this.coupon.data = {
        'id': data1[0]['id'],
        'amount': data1[0]["amount"],
      };
      this.amount = double.parse(data1[0]["amount"]) / 100;
    }
    this.cartState = cartStates.loaded;
    notifyListeners();

    return this.coupon.data;
  }

  setCartItemsFromLocalData(List<Product> products, String key, double total2) {
    cartItems = [];
    print(total2);
    // print(products[0].data);
    cart_key = key;
    total = total2;
    if (this.cartItems.length > 0) return;
    products.forEach((item) {
      this.cartItems.add(item);
    });
    filterCartItems = cartItems;
    // notifyListeners();
    // calculateTotal();
  }

  calculateTotal() {
    loadData();
    // total = 0;
    // totalFiltered = 0;
    // cartItems.forEach((element) {
    //   if (element.data['price'] != null)
    //     total = total +
    //         (double.tryParse(element.data['price'] ?? '0.0') ?? 0) *
    //             element.quantity;
    // });
    // filterCartItems.forEach((element) {
    //   if (element.data['price'] != null)
    //     totalFiltered = totalFiltered +
    //         (double.tryParse(element.data['price'] ?? '0.0') ?? 0) *
    //             element.quantity;
    // });
  }

  addCartItem(Product item, {int quantity = 1}) async {
    this.wpUserInfo = json.decode(await this._secureStorage.read(
              key: 'grodudes_wp_info',
            ) ??
        "{}");
    if (isPresentInCart(item) == true) return;
    try {
      bool inStock = item.data['in_stock'];
      bool isPurchasable = item.data['purchasable'];
      if (inStock == null || isPurchasable == null) return;
      if (!inStock || !isPurchasable) return;
      double price = double.parse(item.data['price']);
      if (price <= 0) return;
    } catch (err) {
      print(err);
      return;
    }
    bool exited = false;
    if (item.data['tags'].length > 0)
      for (int j = 0; j < item.data['tags'].length; j++) {
        exited = false;
        for (int i = 0; i < distrubersList.length; i++) {
          if (distrubersList[i].id == item.data['tags'][j]['id']) {
            exited = true;
          }
        }

        if (!exited) {
          distrubersList.add(new Disturber(
            id: item.data['tags'][j]['id'],
            name: item.data['tags'][j]['name'],
            imagePath: item.data['tags'][j]['path'],
          ));
        }
      }

    item.quantity = quantity;
    String? criddentials = await this._secureStorage.read(key: "auth_data");
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Basic ' + criddentials!
    };
    print(cart_key);
    var response = await http.post(
      Uri.parse("${Secret.baseUrl}/wp-json/cocart/v2/cart/add-item"),
      headers: headers,
      body: json.encode(
          {"id": item.data["id"].toString(), "quantity": quantity.toString()}),
      encoding: Encoding.getByName('utf-8'),
    );
    // var data = await wooCommerceAPI.postAsync("wp-json/cocart/v2/cart/add-item",
    //     {"id": item.data["id"], "quantity": quantity});
    print(response.body);
    print(".................................");
    // this.cartItems.add(item);
    await _storeCartLocally(response.body);
    await calculateTotal();
    notifyListeners();
  }

  setWishCartItemsFromLocalData(List<Product> products) {
    if (this.cartWishItems.length > 0) return;
    products.forEach((item) {
      if (!isPresentInCart(item)) {
        this.cartWishItems.add(item);
      }
    });
  }

  removeCartItem(Product item) async {
    this.wpUserInfo = json.decode(await this._secureStorage.read(
              key: 'grodudes_wp_info',
            ) ??
        "{}");
    String? criddentials = await this._secureStorage.read(key: "auth_data");
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Basic ' + criddentials!
    };
    print(cart_key);
    var response = await http.delete(
      Uri.parse(
          "${Secret.baseUrl}/wp-json/cocart/v2/cart/item/${item.item_key}"),
      headers: headers,
      encoding: Encoding.getByName('utf-8'),
    );
    print(response.body);
    this.cartItems.remove(item);
    this.filterCartItems.remove(item);
    _storeCartLocally(response.body);
    calculateTotal();
    notifyListeners();
  }

  addWishItem(
    Product item,
  ) {
    this.cartWishItems.add(item);
    notifyListeners();
    _storeWishLocally();
  }

  removeWishItem(Product item) {
    this.cartWishItems.remove(item);
    notifyListeners();
    _storeWishLocally();
  }

  clearCart() {
    cartItems.clear();
    filterCartItems.clear();
    total = 0;
    totalFiltered = 0;
    this.cartState = cartStates.init;
    notifyListeners();
    // _storeCartLocally();
  }

  filterCartItem(Disturber disturber, {bool show: true}) {
    // if(show){
    if (filteredIds.contains(disturber.id)) {
      filteredIds.remove(disturber.id);
    } else {
      filteredIds.add(disturber.id);
    }
    bool shouldHide = false;
    filterCartItems = [];
    for (int i = 0; i < cartItems.length; i++) {
      shouldHide = false;

      if (cartItems[i].data['tags'].length > 0) {
        cartItems[i].data['tags'].forEach((item) => {
              for (int j = 0; j < filteredIds.length; j++)
                {
                  if (filteredIds[j] == item['id']) {shouldHide = true}
                }
            });
      }
      if (!shouldHide) {
        filterCartItems.add(cartItems[i]);
      }
    }
    calculateTotal();
    notifyListeners();
  }

  isPresentInCart(Product item) {
    for (final cartItem in cartItems) {
      if (cartItem.isSameAs(item)) return true;
    }
    return false;
  }

  Product? getIsPresentInCart(Product item) {
    for (final cartItem in cartItems) {
      if (cartItem.isSameAs(item)) return cartItem;
    }
    return null;
  }

  isPresentInWishList(Product item) {
    for (final cartItem in cartWishItems) {
      if (cartItem.isSameAs(item)) return true;
    }
    return false;
  }

  incrementQuantityOfProduct(Product item) async {
    if (isPresentInCart(item) == true) {
      for (final cartItem in cartItems) {
        if (cartItem.isSameAs(item)) {
          print(cartItem.item_key);
          this.wpUserInfo = json.decode(await this._secureStorage.read(
                    key: 'grodudes_wp_info',
                  ) ??
              "{}");
          String? criddentials =
              await this._secureStorage.read(key: "auth_data");
          Map<String, String> headers = {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Basic ' + criddentials!
          };
          item.quantity++;
          cartItem.quantity++;
          var response = await http.post(
            Uri.parse(
                "${Secret.baseUrl}/wp-json/cocart/v2/cart/item/${cartItem.item_key}"),
            headers: headers,
            body: json.encode({"quantity": cartItem.quantity.toString()}),
            encoding: Encoding.getByName('utf-8'),
          );
          print(response.body);
          _storeCartLocally(response.body);
          calculateTotal();
          notifyListeners();

          return;
        }
      }
    } else {
      try {
        bool inStock = item.data['in_stock'];
        bool isPurchasable = item.data['purchasable'];
        if (inStock == null || isPurchasable == null) return;
        if (!inStock || !isPurchasable) return;
        double price = double.parse(item.data['price']);
        if (price <= 0) return;
      } catch (err) {
        print(err);
        return;
      }
      // item.quantity = 1;
      addCartItem(item, quantity: 1);
      // this.cartItems.add(item);
      calculateTotal();
      notifyListeners();
      // _storeCartLocally();
      return;
    }
  }

  decrementQuantityOfProduct(Product item) async {
    // print(wpUserInfo);
    for (final cartItem in cartItems) {
      if (cartItem.isSameAs(item)) {
        if (cartItem.quantity == 1) {
          removeCartItem(cartItem);
          return;
        }
        item.quantity--;
        cartItem.quantity--;
        this.wpUserInfo = json.decode(await this._secureStorage.read(
                  key: 'grodudes_wp_info',
                ) ??
            "{}");
        String? criddentials = await this._secureStorage.read(key: "auth_data");
        Map<String, String> headers = {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Basic ' + criddentials!
        };
        var response = await http.post(
          Uri.parse(
              "${Secret.baseUrl}/wp-json/cocart/v2/cart/item/${cartItem.item_key}"),
          headers: headers,
          body: json.encode({"quantity": cartItem.quantity.toString()}),
          encoding: Encoding.getByName('utf-8'),
        );
        print(response.body);
        _storeCartLocally(response.body);
        calculateTotal();
        notifyListeners();

        return;
      }
    }
  }

  Future _storeCartLocally(String cart) async {
    try {
      var cartData = json.decode(cart);
      if (cartData["cart_key"] != null) {
        final SharedPreferences prefs = await _prefs;
        await prefs.setString(localCartStorageKey, cart);
      }
    } catch (err) {
      print(err);
    }
    loadData();
  }

  Future _storeWishLocally() async {
    try {
      final SharedPreferences prefs = await _prefs;
      await prefs.setString(localWishStorageKey, _getCartWishDataAsString());
    } catch (err) {
      print(err);
    }
  }

  String _getCartDataAsString() {
    List<dynamic> productsInCart = [];
    this.cartItems.forEach(
          (item) => productsInCart.add({
            'id': item.data['id'],
            'quantity': item.quantity,
          }),
        );
    return json.encode(productsInCart);
  }

  String _getCartWishDataAsString() {
    List<dynamic> productsInCart = [];
    this.cartWishItems.forEach(
          (item) => productsInCart.add(item.data
              // 'id': item.data['id'],

              ),
        );
    return json.encode(productsInCart);
  }

  Future fetchCartItems(List<int> ids) async {
    List<dynamic> fetchedProducts = [];
    try {
      String includeString = ids.join(',');
      fetchedProducts =
          await this.wooCommerceAPI.getAsync('products?include=$includeString');
      return fetchedProducts;
    } catch (err) {
      fetchedProducts = [];
      return fetchedProducts;
    }
  }

  Future loadData() async {
    List<Product> cart = [];
    List<Product> localCartItems = [];
    List<Product> localWishItems = [];
    String cartKey = "";
    try {
      String? criddentials = await this._secureStorage.read(key: "auth_data");
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
        total = (double.parse(items["totals"]["total"]) / 100) ?? 0.0;
        cartKey = items["cart_key"];
        print(items);
        Map<int, Map<String, dynamic>> itemIds = {};
        (items["items"] as List<dynamic>).forEach((item) {
          print(item);
          if (item['id'] != null && item['id'] is int) {
            itemIds[item['id']] = {
              "quantity": item['quantity']["value"] ?? 1,
              "item_key": item['item_key']
            };
          }
        });
        print(".....................");
        if (itemIds.length > 0) {
          List<dynamic> fetchedCartItems =
              await fetchCartItems(itemIds.keys.toList());
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
        cartWishItems = localWishItems; // Map<int, int> wishIds = {};

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
        wpUserInfo = {};
        wcUserInfo = {};
        if (wpUserInfoString != null) {
          wpUserInfo = json.decode(wpUserInfoString);
          String token = wpUserInfo!['jwt_token'];
          if (token != null) {
            wcUserInfo = json.decode(
                wcUserInfoString ?? token); //await fetchUserData(token);
          }
        }
        if (wcUserInfoString != null) {
          wcUserInfo = json.decode(wcUserInfoString);
          String token = wcUserInfo!['jwt_token'];
          if (token != null) {
            wcUserInfo = json.decode(
                wcUserInfoString ?? token); //await fetchUserData(token);
          }
        }
        cart_key = cartKey;
        total = total;
        this.cartItems = [];
        cart.forEach((item) {
          this.cartItems.add(item);
        });
        // this.cartItems.forEach((item) {
        //   bool exited = false;
        //   print(item.data);
        //   if (item.data["tags"] is List) {
        //     if (item.data['tags'].length > 0)
        //       for (int j = 0; j < item.data['tags'].length; j++) {
        //         exited = false;
        //         for (int i = 0; i < distrubersList.length; i++) {
        //           if (distrubersList[i].id == item.data['tags'][j]['id']) {
        //             exited = true;
        //           }
        //         }
        //       }
        //   }
        // });
        filterCartItems = cartItems;
        // ProductsManager().setProductsFromLocalCart(localCartItems);
      }
    } catch (err) {
      print(err);
    }
  }
}
