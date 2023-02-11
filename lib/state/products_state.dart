import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grodudes/helper/WooCommerceAPI.dart';
import 'package:grodudes/models/Category.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/models/dataFull.dart';
import 'package:grodudes/models/filter_parameter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../secret.dart';
import 'cart_state.dart';

const productsPerPage = 50;

class ProductsManager with ChangeNotifier {
  Map<int, Product> products = {};
  Map<int, Category> categories = {};
  Map<int, Category> tags = {};
  DataFull dataFull = new DataFull(
      localWishItems: [],
      localCartItems: [],
      wcUserInfo: {},
      wpUserInfo: {},
      success: {});

  int ApiCall = 0;
  bool fromSplash = false;
  bool isFetchingCategories = false;
  Set<int> popularProductIds = {};
  Set<int> topRatedProductIds = {};
  Set<int> latestProductIds = {};
  int nextProductPage = 1;
  bool allProductPagesFetched = false;
  WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
      url: Secret.baseUrl,
      consumerKey: Secret.consumerKey,
      consumerSecret: Secret.consumerSecret);

  ProductsManager() {
    products = {};
    categories = {};
    nextProductPage = 1;
    allProductPagesFetched = false;
    popularProductIds = {};
    topRatedProductIds = {};
    latestProductIds = {};
    dataFull = DataFull(
        localWishItems: [],
        localCartItems: [],
        wcUserInfo: {},
        wpUserInfo: {},
        success: {});

    wooCommerceAPI = WooCommerceAPI(
        url: Secret.baseUrl,
        consumerKey: Secret.consumerKey,
        consumerSecret: Secret.consumerSecret);
  }

  setProductsFromLocalCart(List<Product> localCartProducts) {
    localCartProducts.forEach((item) => this._addProduct(item));
    // notifyListeners();
  }

  _addProduct(Product item) {
    if (this.products.containsKey(item.data['id'])) {
      return this.products[item.data['id']];
    }
    this.products[item.data['id']] = item;
    return item;
  }

  Future fetchAllParentCategories(
      {bool shouldupdate: true, bool fromSplash = false}) async {
    this.ApiCall++;

    if (this.categories.values.length > 0) return true;
    List<dynamic> fetchedCategories = [];
    if (this.ApiCall < 3) {
      fetchedCategories = await wooCommerceAPI
          .getAsync('products/categories?parent=0&per_page=50&page=1');
    }
    // .getAsync('products');
    if (fetchedCategories != null && fetchedCategories.length > 0) {
      fetchedCategories
          .where((element) =>
              element['name'].toString().toLowerCase() != 'uncategorized')
          .forEach(
              (category) => categories[category['id']] = Category(category));
      if (shouldupdate) notifyListeners();
      if (fromSplash && this.ApiCall > 3) {
        notifyListeners();
      }
      return true;
    }
  }

  Future fetchAllProductTags(
      {bool shouldupdate: true, bool fromSplash = false}) async {
    this.ApiCall++;

    if (this.tags.values.length > 0) return true;
    List<dynamic> fetchedTags = [];
    // if (this.ApiCall < 3) {
    fetchedTags =
        await wooCommerceAPI.getAsync('products/tags', apiVersion: 'v3');
    // }
    print("fetched Tags" + fetchedTags.toString());

    // .getAsync('products');
    if (fetchedTags != null && fetchedTags.length > 0) {
      fetchedTags
          .where((element) =>
              element['name'].toString().toLowerCase() != 'uncategorized')
          .forEach((tag) => tags[tag['id']] = Category(tag));
      if (shouldupdate) notifyListeners();
      if (fromSplash) {
        notifyListeners();
      }
      return true;
    }
    return true;
  }

  Future<DataFull> fetchAll({bool fromSplash = false}) async {
    List<Product> localCartItems = [];
    List<Product> localWishItems = [];
    try {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      String? cartData = prefs.getString(localCartStorageKey);
      String? wishData = prefs.getString(localWishStorageKey);
      if (cartData != null) {
        List<dynamic> items = json.decode(cartData);
        Map<int, int> itemIds = {};
        items.forEach((item) {
          if (item['id'] != null && item['id'] is int) {
            itemIds[item['id']] = item['quantity']['value'] ?? 1;
          }
        });
        if (itemIds.length > 0) {
          List<dynamic> fetchedCartItems =
              await fetchCartItems(itemIds.keys.toList());
          fetchedCartItems.forEach((item) {
            Product product = Product(item);
            product.quantity = itemIds[item['id']] ?? 1;
            localCartItems.add(product);
          });
        }
      }
      if (wishData != null) {
        List<dynamic> localWishItemstmp = json.decode(wishData);
        for (int i = 0; i < localWishItemstmp.length; i++) {
          localWishItems.add(new Product(localWishItemstmp[i]));
        }
        this.dataFull.localWishItems =
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
        this.dataFull.success = {
          'success': true,
        };
        this.dataFull.wcUserInfo = {
          'wcUser': wcUserInfo,
        };
        this.dataFull.wpUserInfo = {
          'success': wpUserInfo,
        };

        return this.dataFull;
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
    return this.dataFull;
  }

  Future fetchCartItems(
    List<int> ids,
  ) async {
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

  Future fetchUserData(String token) async {
    int id = await this.wooCommerceAPI.getLoggedInUserId(token);
    if (id == null) return;
    var response = await this.wooCommerceAPI.getAsync('customers/$id');
    if (response['id'] == null) return;
    return response;
  }

  Future fetchNextProductsPage() async {
    if (allProductPagesFetched) return;
    List<dynamic> fetchedProducts = [];
    fetchedProducts = await wooCommerceAPI
        .getAsync('products?per_page=$productsPerPage&page=$nextProductPage')
        .timeout(Duration(seconds: 60));
    if (fetchedProducts == null) return;
    if (fetchedProducts.length > 0) nextProductPage++;
    if (fetchedProducts.length < productsPerPage) allProductPagesFetched = true;
    fetchedProducts.forEach((item) => _addProduct(Product(item)));
    notifyListeners();
  }

  Future fetchCategoryDetails(Category category) async {
    //fetch sub categories
    List<dynamic> data = await wooCommerceAPI
        .getAsync('products/categories?parent=${category.data['id']}')
        .catchError((err) => print(err));
    List<Category> categories = [];
    data.forEach((item) => categories.add(Category(item)));
    if (categories.length > 0) return {'categories': categories};

    // fetch products if there are no sub categories
    List<dynamic> productData = await wooCommerceAPI
        .getAsync('products?category=${category.data['id']}')
        .catchError((err) => print(err));
    List<Product> fetchedProducts = [];
    productData.forEach((product) {
      _addProduct(Product(product));
      fetchedProducts.add(this.products[product['id']]!);
    });
    return {
      'categories': categories,
      'products': fetchedProducts,
    };
  }

  Future fetchLatestProducts(
      {bool shouldNotify = false, bool fromSplash = false}) async {
    this.ApiCall++;

    if (this.latestProductIds.length > 0) {
      if (shouldNotify) notifyListeners();
      return true;
    }
    List<dynamic> productsData = [];
    if (this.ApiCall <= 3) {
      productsData = await this
          .wooCommerceAPI
          .getAsync('products?per_page=20&orderby=date&order=desc',
              apiVersion: 'v3')
          .timeout(Duration(seconds: 60))
          .catchError((err) {
        print('fetching latest products: $err');
        throw err;
      });
    }
    if (productsData == null) throw Exception('Failed to fetch products');
    productsData.forEach((item) {
      item['in_stock'] = item['stock_status'] == 'instock';
      this._addProduct(Product(item));
      this.latestProductIds.add(item['id']);
    });

    if (shouldNotify) {
      notifyListeners();
    }
    if (fromSplash && this.ApiCall > 3) {
      notifyListeners();
    }
    return true;
  }

  Future fetchRatedProducts(
      {bool shouldNotify = false, bool fromSplash = false}) async {
    if (this.topRatedProductIds.length > 0) {
      if (shouldNotify) notifyListeners();
      return true;
    }

    List<dynamic> productsData = [];
    if (this.ApiCall <= 3) {
      productsData = await this
          .wooCommerceAPI
          .getAsync('products?per_page=20&orderby=rating&order=desc',
              apiVersion: 'v3')
          .timeout(Duration(seconds: 60))
          .catchError((err) {
        print('fetching top rated products: $err');
        throw err;
      });
    }
    if (productsData == null) throw FlutterError('Failed to fetch products');
    productsData.forEach((item) {
      item['in_stock'] = item['stock_status'] == 'instock';
      this._addProduct(Product(item));
      this.topRatedProductIds.add(item['id']);
    });
    if (shouldNotify) notifyListeners();
    // if(fromSplash&&this.ApiCall>3){
    //   notifyListeners();
    //
    // }
    return true;
  }

  Future fetchPopularProducts(
      {bool shouldNotify = false, bool fromSplash = false}) async {
    if (this.popularProductIds.length > 0) {
      if (shouldNotify) notifyListeners();
      return true;
    }
    this.ApiCall++;
    List<dynamic> productsData = [];
    // if (this.ApiCall <= 3) {
    productsData = await this
        .wooCommerceAPI
        .getAsync('products?per_page=50&orderby=popularity&order=desc',
            apiVersion: 'v3')
        .timeout(Duration(seconds: 60))
        .catchError((err) {
      print('fetching popular products: $err');
      throw err;
    });
    // }
    print(productsData.toString());
    if (productsData == null) throw FlutterError('Failed to fetch products');
    productsData.forEach((item) {
      item['in_stock'] = item['stock_status'] == 'instock';
      this._addProduct(Product(item));
      this.popularProductIds.add(item['id']);
    });
    if (shouldNotify) {
      notifyListeners();
    }
    if (fromSplash && this.ApiCall > 3) {
      notifyListeners();
    }
    return true;
  }

  Future fetchFilteredProducts(FilterParams searchQuery) async {
    popularProductIds = {};
    products = {};
    // await this.fetchAll();
    if (searchQuery.body == null) {
      return await this.fetchPopularProducts();
    } else {
      List<dynamic> searchedProductsData = await wooCommerceAPI
          .getAsync('products?per_page=50&' + searchQuery.urlParams,
              apiVersion: 'v3')
          .timeout(Duration(seconds: 60))
          .catchError((err) {
        print('fetching popular products: $err');
        throw err;
      });
      searchedProductsData.forEach((item) {
        item['in_stock'] = item['stock_status'] == 'instock';
        this._addProduct(Product(item));
        this.popularProductIds.add(item['id']);
      });
      return true;
    }
  }

  Future<List<Product>> searchProducts(String searchQuery) async {
    List<dynamic> searchedProductsData =
        await wooCommerceAPI.getAsync('products?search=$searchQuery');

    List<Product> searchedProducts = [];
    searchedProductsData.forEach((productData) {
      Product item = _addProduct(Product(productData));
      searchedProducts.add(item);
    });
    return searchedProducts;
  }

  Future<List<Product>> filterProducts(FilterParams searchQuery) async {
    List<dynamic> searchedProductsData = searchQuery.urlParams != ""
        ? await wooCommerceAPI.getAsync('products?' + searchQuery.urlParams)
        : await wooCommerceAPI.getAsync('products?search=$searchQuery');

    List<Product> searchedProducts = [];
    searchedProductsData.forEach((productData) {
      Product item = _addProduct(Product(productData));
      searchedProducts.add(item);
    });
    return searchedProducts;
  }

  Future<List<Product>> getProductsInOrder(Map<String, dynamic> order) async {
    List<int> productsIds = [];
    order['line_items'].forEach((item) {
      productsIds.add(item['product_id']);
    });
    String includeString = productsIds.join(',');
    List<dynamic> response =
        await wooCommerceAPI.getAsync('products?include=$includeString');
    List<Product> orderProducts = [];
    response.forEach((item) => orderProducts.add(_addProduct(Product(item))));
    return orderProducts;
  }
}
