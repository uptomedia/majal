// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `login`
  String get login {
    return Intl.message(
      'login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Add Post`
  String get addPost {
    return Intl.message(
      'Add Post',
      name: 'addPost',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `forget`
  String get forget {
    return Intl.message(
      'forget',
      name: 'forget',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `العربية`
  String get arabic {
    return Intl.message(
      'العربية',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get german {
    return Intl.message(
      'German',
      name: 'german',
      desc: '',
      args: [],
    );
  }

  /// `Login to your Account`
  String get logintoyourAccount {
    return Intl.message(
      'Login to your Account',
      name: 'logintoyourAccount',
      desc: '',
      args: [],
    );
  }

  /// `forget Password`
  String get forgetPassword {
    return Intl.message(
      'forget Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create a new Account`
  String get createAnewAccount {
    return Intl.message(
      'Create a new Account',
      name: 'createAnewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `new User`
  String get newUser {
    return Intl.message(
      'new User',
      name: 'newUser',
      desc: '',
      args: [],
    );
  }

  /// `Existing User`
  String get existingUser {
    return Intl.message(
      'Existing User',
      name: 'existingUser',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `press twice to exit`
  String get pressTwiceToExit {
    return Intl.message(
      'press twice to exit',
      name: 'pressTwiceToExit',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get profile {
    return Intl.message(
      'profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `cart`
  String get cart {
    return Intl.message(
      'cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart`
  String get yourCart {
    return Intl.message(
      'Your Cart',
      name: 'yourCart',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Latest Products`
  String get latestProducts {
    return Intl.message(
      'Latest Products',
      name: 'latestProducts',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Price Range`
  String get priceRange {
    return Intl.message(
      'Price Range',
      name: 'priceRange',
      desc: '',
      args: [],
    );
  }

  /// `Thanks For Waiting`
  String get splashMessage {
    return Intl.message(
      'Thanks For Waiting',
      name: 'splashMessage',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch data! You can try pressing the see all button to retry`
  String get errorMessage {
    return Intl.message(
      'Failed to fetch data! You can try pressing the see all button to retry',
      name: 'errorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Order Placement`
  String get orderPlacement {
    return Intl.message(
      'Order Placement',
      name: 'orderPlacement',
      desc: '',
      args: [],
    );
  }

  /// `Sorry there was an error`
  String get orderErrorMessage {
    return Intl.message(
      'Sorry there was an error',
      name: 'orderErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Connection problem \n please check your Internt connection`
  String get connectionErrorMessage {
    return Intl.message(
      'Connection problem \n please check your Internt connection',
      name: 'connectionErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Failed to place order. Something went wrong on our side`
  String get errorMessageOrderServer {
    return Intl.message(
      'Failed to place order. Something went wrong on our side',
      name: 'errorMessageOrderServer',
      desc: '',
      args: [],
    );
  }

  /// `Thank You For Shopping with Us!`
  String get thankYouForShoppingWithUs {
    return Intl.message(
      'Thank You For Shopping with Us!',
      name: 'thankYouForShoppingWithUs',
      desc: '',
      args: [],
    );
  }

  /// `Your Order ID is`
  String get yourOrderId {
    return Intl.message(
      'Your Order ID is',
      name: 'yourOrderId',
      desc: '',
      args: [],
    );
  }

  /// `Your Order is due to be paid through`
  String get youOrderIsDueToBePaid {
    return Intl.message(
      'Your Order is due to be paid through',
      name: 'youOrderIsDueToBePaid',
      desc: '',
      args: [],
    );
  }

  /// `Cash on Delivery (CoD)`
  String get youOrderIsDueToBePaid2 {
    return Intl.message(
      'Cash on Delivery (CoD)',
      name: 'youOrderIsDueToBePaid2',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Sorry there was an error`
  String get sorryThereWasAnError {
    return Intl.message(
      'Sorry there was an error',
      name: 'sorryThereWasAnError',
      desc: '',
      args: [],
    );
  }

  /// `Account Details`
  String get accountDetails {
    return Intl.message(
      'Account Details',
      name: 'accountDetails',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Billing Address`
  String get billingAddress {
    return Intl.message(
      'Billing Address',
      name: 'billingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `An error occured`
  String get errorOccured {
    return Intl.message(
      'An error occured',
      name: 'errorOccured',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all the fields`
  String get pleaseFillAllTheFields {
    return Intl.message(
      'Please fill all the fields',
      name: 'pleaseFillAllTheFields',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed. Please try again.`
  String get loginFailedPleaseTryAgain {
    return Intl.message(
      'Login Failed. Please try again.',
      name: 'loginFailedPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Something went Wrong!`
  String get somethingWentWrong {
    return Intl.message(
      'Something went Wrong!',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get orderID {
    return Intl.message(
      'Order ID',
      name: 'orderID',
      desc: '',
      args: [],
    );
  }

  /// `Order Total: `
  String get orderTotal {
    return Intl.message(
      'Order Total: ',
      name: 'orderTotal',
      desc: '',
      args: [],
    );
  }

  /// `Order Status: `
  String get orderStatus {
    return Intl.message(
      'Order Status: ',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `date: orderd in `
  String get placedOn {
    return Intl.message(
      'date: orderd in ',
      name: 'placedOn',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method:  `
  String get paymentMethod {
    return Intl.message(
      'Payment Method:  ',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get notFound {
    return Intl.message(
      'Not Found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Ordered Products`
  String get orderedProducts {
    return Intl.message(
      'Ordered Products',
      name: 'orderedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch products`
  String get failedToFetchProducts {
    return Intl.message(
      'Failed to fetch products',
      name: 'failedToFetchProducts',
      desc: '',
      args: [],
    );
  }

  /// `Order Quantity - `
  String get orderQuantity {
    return Intl.message(
      'Order Quantity - ',
      name: 'orderQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Successfully requested order cancellation`
  String get successfullyRequestedOrderCancellation {
    return Intl.message(
      'Successfully requested order cancellation',
      name: 'successfullyRequestedOrderCancellation',
      desc: '',
      args: [],
    );
  }

  /// `Failed to Cancel Order`
  String get failedToCancelOrder {
    return Intl.message(
      'Failed to Cancel Order',
      name: 'failedToCancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancellation Failed`
  String get cancellationFailed {
    return Intl.message(
      'Cancellation Failed',
      name: 'cancellationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Are you Sure?`
  String get areYouSure {
    return Intl.message(
      'Are you Sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yes {
    return Intl.message(
      'YES',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `NO`
  String get no {
    return Intl.message(
      'NO',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `recieved error response`
  String get recievedNullResponse {
    return Intl.message(
      'recieved error response',
      name: 'recievedNullResponse',
      desc: '',
      args: [],
    );
  }

  /// `Your orders`
  String get yourOrders {
    return Intl.message(
      'Your orders',
      name: 'yourOrders',
      desc: '',
      args: [],
    );
  }

  /// `You have no Orders`
  String get youHaveNoOrders {
    return Intl.message(
      'You have no Orders',
      name: 'youHaveNoOrders',
      desc: '',
      args: [],
    );
  }

  /// `There was an error in fetching the orders\n  swipe down to reload`
  String get thereWasAnErrorInFetchingTheOrders {
    return Intl.message(
      'There was an error in fetching the orders\n  swipe down to reload',
      name: 'thereWasAnErrorInFetchingTheOrders',
      desc: '',
      args: [],
    );
  }

  /// `Dispatched Orders cannot be cancelled`
  String get dispatchedOrdersCannotBeCancelled {
    return Intl.message(
      'Dispatched Orders cannot be cancelled',
      name: 'dispatchedOrdersCannotBeCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `details`
  String get details {
    return Intl.message(
      'details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Update your address details`
  String get updateYourAddressDetails {
    return Intl.message(
      'Update your address details',
      name: 'updateYourAddressDetails',
      desc: '',
      args: [],
    );
  }

  /// `Address not found`
  String get addressNotFound {
    return Intl.message(
      'Address not found',
      name: 'addressNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your details`
  String get confirmYourDetails {
    return Intl.message(
      'Confirm your details',
      name: 'confirmYourDetails',
      desc: '',
      args: [],
    );
  }

  /// `Please login to proceed to checkout`
  String get pleaseLoginToProceedToCheckout {
    return Intl.message(
      'Please login to proceed to checkout',
      name: 'pleaseLoginToProceedToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address`
  String get enterYourEmailAddress {
    return Intl.message(
      'Enter your email address',
      name: 'enterYourEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterYourPhoneNumber {
    return Intl.message(
      'Enter your phone number',
      name: 'enterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Place Order`
  String get placeOrder {
    return Intl.message(
      'Place Order',
      name: 'placeOrder',
      desc: '',
      args: [],
    );
  }

  /// `Please fill out your Email and Phone number`
  String get pleaseFillOutYourEmailAndPhoneNumber {
    return Intl.message(
      'Please fill out your Email and Phone number',
      name: 'pleaseFillOutYourEmailAndPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch categories`
  String get failedToFetchCategories {
    return Intl.message(
      'Failed to fetch categories',
      name: 'failedToFetchCategories',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated Products`
  String get topRatedProducts {
    return Intl.message(
      'Top Rated Products',
      name: 'topRatedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Popular Products`
  String get popularProducts {
    return Intl.message(
      'Popular Products',
      name: 'popularProducts',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `There was an Error! You can try pressing the see all button to retry`
  String get thereWasAnErrorYouCanTryPressingTheSeeAllButtonToRetry {
    return Intl.message(
      'There was an Error! You can try pressing the see all button to retry',
      name: 'thereWasAnErrorYouCanTryPressingTheSeeAllButtonToRetry',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch the products! You can try pressing the see all button to retry`
  String get failedToFetchTheProductsYouCanTryPressingTheSeeAllButtonToRetry {
    return Intl.message(
      'Failed to fetch the products! You can try pressing the see all button to retry',
      name: 'failedToFetchTheProductsYouCanTryPressingTheSeeAllButtonToRetry',
      desc: '',
      args: [],
    );
  }

  /// `Failed to Load Products`
  String get failedToLoadProducts {
    return Intl.message(
      'Failed to Load Products',
      name: 'failedToLoadProducts',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Data Not Found`
  String get dataNotFound {
    return Intl.message(
      'Data Not Found',
      name: 'dataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Out of Stock`
  String get outOfStock {
    return Intl.message(
      'Out of Stock',
      name: 'outOfStock',
      desc: '',
      args: [],
    );
  }

  /// `Currently Not Purchasable`
  String get currentlyNotPurchasable {
    return Intl.message(
      'Currently Not Purchasable',
      name: 'currentlyNotPurchasable',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Item added to cart`
  String get itemAddedToCart {
    return Intl.message(
      'Item added to cart',
      name: 'itemAddedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Item removed from cart`
  String get itemRemovedFromCart {
    return Intl.message(
      'Item removed from cart',
      name: 'itemRemovedFromCart',
      desc: '',
      args: [],
    );
  }

  /// `Remove from Cart`
  String get removeFromCart {
    return Intl.message(
      'Remove from Cart',
      name: 'removeFromCart',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `An Error Occured. Please Try Again`
  String get anErrorOccuredPleaseTryAgain {
    return Intl.message(
      'An Error Occured. Please Try Again',
      name: 'anErrorOccuredPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Category Filters`
  String get categoryFilters {
    return Intl.message(
      'Category Filters',
      name: 'categoryFilters',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `item`
  String get item {
    return Intl.message(
      'item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `items`
  String get items {
    return Intl.message(
      'items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Coupon`
  String get coupon {
    return Intl.message(
      'Coupon',
      name: 'coupon',
      desc: '',
      args: [],
    );
  }

  /// `you can't buy more`
  String get youCantBuyMore {
    return Intl.message(
      'you can\'t buy more',
      name: 'youCantBuyMore',
      desc: '',
      args: [],
    );
  }

  /// `JD`
  String get currencyLogo {
    return Intl.message(
      'JD',
      name: 'currencyLogo',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `Address_1`
  String get address_1 {
    return Intl.message(
      'Address_1',
      name: 'address_1',
      desc: '',
      args: [],
    );
  }

  /// `Address_2`
  String get address_2 {
    return Intl.message(
      'Address_2',
      name: 'address_2',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Postcode`
  String get postcode {
    return Intl.message(
      'Postcode',
      name: 'postcode',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Edite Profile`
  String get editeProfile {
    return Intl.message(
      'Edite Profile',
      name: 'editeProfile',
      desc: '',
      args: [],
    );
  }

  /// `apply`
  String get apply {
    return Intl.message(
      'apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `status : `
  String get status {
    return Intl.message(
      'status : ',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `cancel order`
  String get cancelOrder {
    return Intl.message(
      'cancel order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message(
      'delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `go back`
  String get goback {
    return Intl.message(
      'go back',
      name: 'goback',
      desc: '',
      args: [],
    );
  }

  /// `are you sure you want\nto cancel your order?`
  String get areyouSureYouWant {
    return Intl.message(
      'are you sure you want\nto cancel your order?',
      name: 'areyouSureYouWant',
      desc: '',
      args: [],
    );
  }

  /// `this will delete your order and you can't undo it`
  String get thisWillDelete {
    return Intl.message(
      'this will delete your order and you can\'t undo it',
      name: 'thisWillDelete',
      desc: '',
      args: [],
    );
  }

  /// `item quantity: `
  String get itemquantity {
    return Intl.message(
      'item quantity: ',
      name: 'itemquantity',
      desc: '',
      args: [],
    );
  }

  /// `order placed on: `
  String get orderPlacedon {
    return Intl.message(
      'order placed on: ',
      name: 'orderPlacedon',
      desc: '',
      args: [],
    );
  }

  /// `discount: `
  String get discount {
    return Intl.message(
      'discount: ',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `code: `
  String get code {
    return Intl.message(
      'code: ',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `add another billing address `
  String get addAnotherBillingAddress {
    return Intl.message(
      'add another billing address ',
      name: 'addAnotherBillingAddress',
      desc: '',
      args: [],
    );
  }

  /// `from category`
  String get fromCategory {
    return Intl.message(
      'from category',
      name: 'fromCategory',
      desc: '',
      args: [],
    );
  }

  /// `Featured`
  String get featured {
    return Intl.message(
      'Featured',
      name: 'featured',
      desc: '',
      args: [],
    );
  }

  /// `swipe right to remove`
  String get swipeRightToRemove {
    return Intl.message(
      'swipe right to remove',
      name: 'swipeRightToRemove',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `after discount : `
  String get afterdiscount {
    return Intl.message(
      'after discount : ',
      name: 'afterdiscount',
      desc: '',
      args: [],
    );
  }

  /// `finish order`
  String get finishOrder {
    return Intl.message(
      'finish order',
      name: 'finishOrder',
      desc: '',
      args: [],
    );
  }

  /// `welcome back`
  String get welcomeback {
    return Intl.message(
      'welcome back',
      name: 'welcomeback',
      desc: '',
      args: [],
    );
  }

  /// `sign in to your account`
  String get signInToYourAccount {
    return Intl.message(
      'sign in to your account',
      name: 'signInToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `welcome`
  String get welcome {
    return Intl.message(
      'welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `sign in or create new account`
  String get signInOrCreateNewAccount {
    return Intl.message(
      'sign in or create new account',
      name: 'signInOrCreateNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `already have accoun`
  String get alreadyHaveAccountSignin {
    return Intl.message(
      'already have accoun',
      name: 'alreadyHaveAccountSignin',
      desc: '',
      args: [],
    );
  }

  /// `sign in`
  String get signIn {
    return Intl.message(
      'sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `enter your email to receive email`
  String get enterYourEmailToReceiveEmail {
    return Intl.message(
      'enter your email to receive email',
      name: 'enterYourEmailToReceiveEmail',
      desc: '',
      args: [],
    );
  }

  /// `with link to reset your password`
  String get withLinkToResetYourPassword {
    return Intl.message(
      'with link to reset your password',
      name: 'withLinkToResetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `don't have account`
  String get youDontHaveAccount {
    return Intl.message(
      'don\'t have account',
      name: 'youDontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `signup`
  String get signup {
    return Intl.message(
      'signup',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `An error occured while loading`
  String get anErrorOccuredWhileLoading {
    return Intl.message(
      'An error occured while loading',
      name: 'anErrorOccuredWhileLoading',
      desc: '',
      args: [],
    );
  }

  /// `edit account details`
  String get editAccountDetails {
    return Intl.message(
      'edit account details',
      name: 'editAccountDetails',
      desc: '',
      args: [],
    );
  }

  /// `billing and shipping`
  String get billingAndShipping {
    return Intl.message(
      'billing and shipping',
      name: 'billingAndShipping',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message(
      'Wishlist',
      name: 'wishlist',
      desc: '',
      args: [],
    );
  }

  /// `personal info`
  String get personalInfo {
    return Intl.message(
      'personal info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `update profile`
  String get updateProfile {
    return Intl.message(
      'update profile',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `remove this billing address`
  String get removeThisBillingAddress {
    return Intl.message(
      'remove this billing address',
      name: 'removeThisBillingAddress',
      desc: '',
      args: [],
    );
  }

  /// `drag to delete`
  String get dragToDelete {
    return Intl.message(
      'drag to delete',
      name: 'dragToDelete',
      desc: '',
      args: [],
    );
  }

  /// `click to see full details`
  String get clickToSeeFullDetails {
    return Intl.message(
      'click to see full details',
      name: 'clickToSeeFullDetails',
      desc: '',
      args: [],
    );
  }

  /// `category`
  String get category {
    return Intl.message(
      'category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `product`
  String get product {
    return Intl.message(
      'product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `best selling`
  String get bestselling {
    return Intl.message(
      'best selling',
      name: 'bestselling',
      desc: '',
      args: [],
    );
  }

  /// `choose`
  String get choose {
    return Intl.message(
      'choose',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `Disturbers`
  String get disturbers {
    return Intl.message(
      'Distributors',
      name: 'distributors',
      desc: '',
      args: [],
    );
  }

  /// `Special Offers`
  String get specialOffers {
    return Intl.message(
      'Special Offers',
      name: 'specialOffers',
      desc: '',
      args: [],
    );
  }

  /// `Top Distribuers`
  String get topDistribuers {
    return Intl.message(
      'Top Distribuers',
      name: 'topDistribuers',
      desc: '',
      args: [],
    );
  }

  /// `All Distribuers`
  String get allDistribuers {
    return Intl.message(
      'All Distribuers',
      name: 'allDistribuers',
      desc: '',
      args: [],
    );
  }

  /// `filters`
  String get filters {
    return Intl.message(
      'filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Total Value`
  String get totalValue {
    return Intl.message(
      'Total Value',
      name: 'totalValue',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Received`
  String get markAsReceived {
    return Intl.message(
      'Mark as Received',
      name: 'markAsReceived',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `empty data`
  String get emptyData {
    return Intl.message(
      'empty data',
      name: 'emptyData',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
