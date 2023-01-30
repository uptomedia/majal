import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:grodudes/helper/WooCommerceAPI.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/models/coupon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/disturber.dart';
import '../secret.dart';

const String localCartStorageKey = 'grodudes_cart_data';
const String localWishStorageKey = 'grodudes_cart_wish_data';
enum cartStates { init,loaded, pending,  }
class CartManager with ChangeNotifier {
  List<Product> cartItems = [];
  List<Product> filterCartItems = [];
  List<Disturber> distrubersList = [];

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
    filterCartItems=[];
    filteredIds=[];
    this.cartState=cartStates.init;
    this._prefs = SharedPreferences.getInstance();
  }
  WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: Secret.baseUrl,
      consumerKey: Secret.consumerKey,
      consumerSecret: Secret.consumerSecret);
  Future applyCoupon(String s) async {
    // /wp-json/wc/v3/coupons/?code=your_coupon_code
    this.amount = 0;
    if(this.cartState!=cartStates.pending){
    this.cartState=cartStates.pending;
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
    this.cartState=cartStates.loaded;
    notifyListeners();

    return this.coupon.data;
  }

  setCartItemsFromLocalData(List<Product> products) {
    if (this.cartItems.length > 0) return;
    products.forEach((item) {
      if (!isPresentInCart(item)) {
        this.cartItems.add(item);
      }
    });
    this.cartItems.forEach((item) {

      bool exited=false;
    if(item.data['tags'].length>0)
      for(int j=0;j<item.data['tags'].length;j++){
        exited=false;
        for(int i=0;i<distrubersList.length;i++){

          if(distrubersList[i].id
              ==
              item.data['tags'][j]['id']){
            exited=true;
          }
        }

        if(!exited){
          distrubersList.add(new Disturber(
            id:item.data['tags'][j]['id'],
            name: item.data['tags'][j]['name'],
            imagePath: item.data['tags'][j]['path'],
          ));
        }
      }
    });
    filterCartItems=cartItems;
    calculateTotal();
  }
calculateTotal(){
    total=0;
    totalFiltered=0;
    cartItems.forEach((element) { 
      if(element.data['price']!=null )
      total=total+
          (double.tryParse(element.data['price']??'0.0')??0)
          *element.quantity;
    });  
    filterCartItems.forEach((element) { 
      if(element.data['price']!=null )
      totalFiltered=totalFiltered+
          (double.tryParse(element.data['price']??'0.0')??0)
          *element.quantity;
    });
}
  addCartItem(Product item, {int quantity = 1}) {
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
    bool exited=false;
    if(item.data['tags'].length>0)
      for(int j=0;j<item.data['tags'].length;j++){
        exited=false;
        for(int i=0;i<distrubersList.length;i++){

          if(distrubersList[i].id
              ==
              item.data['tags'][j]['id']){
            exited=true;
          }
        }

        if(!exited){
          distrubersList.add(new Disturber(
          id:item.data['tags'][j]['id'],
          name: item.data['tags'][j]['name'],
          imagePath: item.data['tags'][j]['path'],
          ));
        }
      }

    item.quantity = quantity;
    this.cartItems.add(item);
    calculateTotal();
    notifyListeners();
    _storeCartLocally();
  }
  setWishCartItemsFromLocalData(List<Product> products) {
    if (this.cartWishItems.length > 0) return;
    products.forEach((item) {
      if (!isPresentInCart(item)) {
        this.cartWishItems.add(item);
      }
    });
  }
  removeCartItem(Product item) {
    this.cartItems.remove(item);
    this.filterCartItems.remove(item);
    calculateTotal();
    notifyListeners();
    _storeCartLocally();
  }
  addWishItem(Product item, ) {

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
    this.cartState=cartStates.init;
    notifyListeners();
    _storeCartLocally();
  }
  filterCartItem(Disturber disturber,{bool show:true}){
    // if(show){
      if(filteredIds.contains(disturber.id)){
      filteredIds.remove(disturber.id);
    }else{
      filteredIds.add(disturber.id);
    }
    bool shouldHide=false;
filterCartItems=[];
    for(int i=0;i<cartItems.length;i++){
        shouldHide=false;

      if(cartItems[i].data['tags'].length>0){
        cartItems[i].data['tags'].forEach((item) =>

            {
       for(int j=0;j<filteredIds.length;j++){

        if(filteredIds[j]==item['id']){
          shouldHide=true
         }
      }
            });

    }
      if(!shouldHide){
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
  isPresentInWishList(Product item) {
    for (final cartItem in cartWishItems) {
      if (cartItem.isSameAs(item)) return true;
    }
    return false;
  }
  incrementQuantityOfProduct(Product item) {
    if (isPresentInCart(item) == true) {
      for (final cartItem in cartItems) {
        if (cartItem.isSameAs(item)) {
          cartItem.quantity++;
          notifyListeners();
          _storeCartLocally();
          return;
        }
      }
    }else {
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
      item.quantity = 1;
      this.cartItems.add(item);
      calculateTotal();
      notifyListeners();
      _storeCartLocally();
    }}

  decrementQuantityOfProduct(Product item) {
    for (final cartItem in cartItems) {
      if (cartItem.isSameAs(item)) {
        if (cartItem.quantity == 1) {
          removeCartItem(item);
          return;
        }
        cartItem.quantity--;
        calculateTotal();
        notifyListeners();
        _storeCartLocally();
        return;
      }
    }
  }



  Future _storeCartLocally() async {
    try {
      final SharedPreferences prefs = await _prefs;
      await prefs.setString(localCartStorageKey, _getCartDataAsString());
    } catch (err) {
      print(err);
    }
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
}
