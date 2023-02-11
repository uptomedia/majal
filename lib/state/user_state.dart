import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grodudes/helper/WooCommerceAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../secret.dart';

enum logInStates { loggedIn, loggedOut, pending, logInFailed }

class UserManager with ChangeNotifier {
  late Map<String, dynamic>? wcUserInfo;
  late Map<String, dynamic>? wpUserInfo;
  FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  var _logInStatus;
  WooCommerceAPI _wooCommApi = WooCommerceAPI(
      url: Secret.baseUrl,
      consumerKey: Secret.consumerKey,
      consumerSecret: Secret.consumerSecret);

  UserManager() {
    this.wcUserInfo = {};
    this.wpUserInfo = {};
    this._secureStorage = FlutterSecureStorage();
    var _logInStatus;

    this._logInStatus = logInStates.loggedOut;
    this._wooCommApi = WooCommerceAPI(
        url: Secret.baseUrl,
        consumerKey: Secret.consumerKey,
        consumerSecret: Secret.consumerSecret);
  }

  // AppStateModel(this.prefs) {
  //   _userToken = prefs.getString(SharedPreferencesKeys.TOKEN);
  //   _refreshToken = prefs.getString(SharedPreferencesKeys.RefreshTOKEN);
  //   _expiresAt = DateTime.tryParse(prefs.getString(SharedPreferencesKeys.ExpiresAt) ?? "");
  //   // refresh();
  // }
  bool isLoggedIn() => this._logInStatus == logInStates.loggedIn;
  getLogInStatus() => this._logInStatus;

  initializeUser(
      Map<String, dynamic> wpUserInfo, Map<String, dynamic> wcUserInfo) {
    print(wcUserInfo);
    if (wcUserInfo == null || wcUserInfo['id'] == null) return;
    if (this.wcUserInfo != null && this.wcUserInfo!['id'] != null) return;
    this.wpUserInfo = wpUserInfo;
    this.wcUserInfo = wcUserInfo;
    this._logInStatus = logInStates.loggedIn;
  }

  Future logInToWordpress(String username, String password) async {
    try {
      if (isLoggedIn()) return true;
      if (this._logInStatus != logInStates.pending) {
        this._logInStatus = logInStates.pending;
        notifyListeners();
      }
      //authorize user through wordpress
      Map<String, dynamic> message;

      try {
        message = await this._wooCommApi.getAuthToken(username, password);
        if (message == null || message['jwt_token'] == null) {
          _createLoginErrorResponse(message
              // ?? {'code': 'token_error'}
              );
          this._logInStatus = logInStates.logInFailed;
          notifyListeners();
          return;
        }
      } catch (err) {
        _createLoginErrorResponse({'code': 'token_error'});
        this._logInStatus = logInStates.logInFailed;
        // notifyListeners();
        print('error logging in to wordpress: $err');
        return;
      }
      this.wpUserInfo = message;
      String token = this.wpUserInfo!['jwt_token'];
      bool success = await _fetchLoggedInUserData(token);

      if (success != null && success) {
        this._logInStatus =
            await _storeUserDataLocally().catchError((err) => print(err));
        this._secureStorage.write(
            key: "auth_data",
            value: base64.encode(utf8.encode("$username:$password")));
        const String localCartStorageKey = 'grodudes_cart_data';
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
      } else {
        this._logInStatus = logInStates.logInFailed;
        _createLoginErrorResponse({});
      }
      notifyListeners();
      return success;
    } catch (err) {
      print('error logging in to wordpress: $err');
    }
  }

  Future resetWordpress(String username, String password) async {
    try {
      if (isLoggedIn()) return true;
      if (this._logInStatus != logInStates.pending) {
        this._logInStatus = logInStates.pending;
        notifyListeners();
      }
      //authorize user through wordpress
      Map<String, dynamic> message;

      try {
        message = await this._wooCommApi.getAuthToken(username, password);
        if (message == null || message['jwt_token'] == null) {
          _createLoginErrorResponse(message ?? {'code': 'token_error'});
          this._logInStatus = logInStates.logInFailed;
          notifyListeners();
          return;
        }
      } catch (err) {
        _createLoginErrorResponse({'code': 'token_error'});
        this._logInStatus = logInStates.logInFailed;
        // notifyListeners();
        print('error logging in to wordpress: $err');
        return;
      }
      this.wpUserInfo = message;
      String token = this.wpUserInfo!['jwt_token'];
      bool success = await _fetchLoggedInUserData(token);

      if (success != null && success) {
        this._logInStatus =
            await _storeUserDataLocally().catchError((err) => print(err));
      } else {
        this._logInStatus = logInStates.logInFailed;
        _createLoginErrorResponse({});
      }
      // notifyListeners();
      return success;
    } catch (err) {
      print('error logging in to wordpress: $err');
    }
  }

  Future _storeUserDataLocally() async {
    try {
      await this._secureStorage.write(
            key: 'grodudes_login_status',
            value: 'true',
          );
      await this._secureStorage.write(
            key: 'grodudes_wp_info',
            value: json.encode(this.wpUserInfo),
          );
      await this._secureStorage.write(
            key: 'grodudes_wc_info',
            value: json.encode(this.wcUserInfo),
          );
      return logInStates.loggedIn;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> _fetchLoggedInUserData(String token) async {
    try {
      int id = await this._wooCommApi.getLoggedInUserId(token);
      if (id == null) return false;
      var response = await this._wooCommApi.getAsync('customers/$id');
      this.wcUserInfo = response;
      return true;
    } catch (err) {
      print('_fetchLoggedInUserData: $err');
      return false;
    }
  }

  Future registerNewUser(String username, String email, String password) async {
    this._logInStatus = logInStates.pending;
    notifyListeners();

    Map<String, String> payload = {
      'username': username,
      'password': password,
      'email': email,
      'roles': 'customer'
    };

    try {
      var response = await _wooCommApi.postAsync('customers', payload);
      if (response == null || response['id'] == null) {
        this._logInStatus = logInStates.logInFailed;
        _createRegistrationErrorResponse(response);
        notifyListeners();
        return;
      }
      this.wcUserInfo = response;
      this.wpUserInfo = {
        'user_email': email,
        'user_display_name': username,
      };

      this._logInStatus = logInStates.loggedIn;
      notifyListeners();
      completeAuthOnRegistration(username, password);
    } catch (err) {
      this._logInStatus = logInStates.logInFailed;
      _createRegistrationErrorResponse({'code': 'registration_failed'});
      notifyListeners();
    }
  }

  Future resetPassword(String username) async {
    this._logInStatus = logInStates.pending;
    notifyListeners();

    try {
      var response = await _wooCommApi.resetPassword(username);
      if (response == null || response['id'] == null) {
        this._logInStatus = logInStates.logInFailed;
        _createRegistrationErrorResponse(response);
        notifyListeners();
        return;
      }
      this.wcUserInfo = response;
      this.wpUserInfo = {
        'user_display_name': username,
      };

      this._logInStatus = logInStates.loggedIn;
      notifyListeners();
      // completeAuthOnRegistration(username);
    } catch (err) {
      this._logInStatus = logInStates.logInFailed;
      _createRegistrationErrorResponse({'code': 'registration_failed'});
      notifyListeners();
    }
  }

  Future completeAuthOnRegistration(String username, String password) async {
    try {
      var response = await this._wooCommApi.getAuthToken(username, password);
      if (response != null && response['token'] != null) {
        this.wpUserInfo = response;
        this._logInStatus = logInStates.loggedIn;
        notifyListeners();
      }
      await _storeUserDataLocally();
    } catch (err) {
      print(err);
    }
  }

  logOut() async {
    this.wpUserInfo = null;
    this.wcUserInfo = null;
    this._logInStatus = logInStates.loggedOut;
    notifyListeners();
    await this
        ._secureStorage
        .write(key: 'grodudes_login_status', value: 'false');
  }

  Future getOrders(int page) async {
    int customerId = this.wcUserInfo!['id'];
    if (customerId == null) return false;
    try {
      List<dynamic> orders = await this
          ._wooCommApi
          .getAsync('orders?customer=$customerId&&per_page=10&&page=$page');
      return orders;
    } catch (err) {
      print('orders not found $err');
      return false;
    }
  }

  Future<String> updateUser(Map<String, dynamic> user) async {
    try {
      var response = await this._wooCommApi.putAsync(
        'customers/${this.wcUserInfo!['id']}',
        user,
        userHeaders: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      if (response['id'] != null) {
        this.wcUserInfo = response;
        notifyListeners();
        return "Updated";
      }
      Map<String, dynamic> errorMap = response['data']['params'];
      if (errorMap == null) return 'Update Failed';
      String errorMsg = errorMap.values.elementAt(0);
      return errorMsg != null ? 'Update Failed: $errorMsg' : 'Update Failed';
    } catch (err) {
      print('could not get wcomm details $err');
      return 'Update Failed';
    }
  }

  Future cancelOrder(int id) async {
    Map<String, dynamic> body = {
      'id': id,
      'status': 'cancelled',
    };
    var response = await this._wooCommApi.putAsync(
      'orders/$id',
      body,
      userHeaders: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    if (response['id'] != null)
      return response;
    else
      return false;
  }

  _createLoginErrorResponse(Map<String, dynamic> response) {
    final code = response['code'];

    if (code == '[jwt_auth] invalid_username') {
      this.wpUserInfo = {
        'code': 'Invalid Username',
        'errMsg': 'Unknown username. Check again or try your email address.'
      };
    } else if (code == '[jwt_auth] incorrect_password') {
      this.wpUserInfo = {
        'code': 'Wrong Password',
        'errMsg': 'Please retry with the correct password'
      };
    } else if (code == 'token_error') {
      this.wpUserInfo = {
        'code': 'Authorization Problem',
        'errMsg': 'Could not get authorization token'
      };
    } else {
      this.wpUserInfo = {
        'code': 'Unknown Error',
        'errMsg': 'An Error Occured while trying to login'
      };
    }
    this.wcUserInfo = this.wpUserInfo;
  }

  _createRegistrationErrorResponse(Map<String, dynamic> response) {
    final code = response['code'];

    if (code == 'registration_failed') {
      this.wpUserInfo = {
        'code': code,
        'errMsg': 'Failed to create User! Please try again.',
      };
    }
    this.wpUserInfo = {
      'code': response['code'] ?? 'registration_failed',
      'errMsg': response['message'] ?? 'Registration Failed',
    };
    this.wcUserInfo = this.wpUserInfo;
  }
}
