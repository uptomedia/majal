import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/pages/account/AccountRoot.dart';
import 'package:grodudes/pages/account/LogInPage.dart';
import 'package:grodudes/pages/checkout/AddressUpdatePage.dart';
import 'package:grodudes/pages/checkout/OrderPlacementPage.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:provider/provider.dart';

import '../../core/configurations/assets.dart';
import '../../core/utils.dart';
import '../../core/widget/majl/majal_app_bar.dart';
import '../../routing/route_paths.dart';

class ConfirmationPage extends StatefulWidget {
  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  Map<String, dynamic>? shippingAddress;
  Map<String, dynamic>? billingAddress;
  UserManager? userManager;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  FocusNode _emailFocusNode = FocusNode();
  final _emailKey = new GlobalKey<FormFieldState<String>>();

  //styles
  final _textFieldDecoration = InputDecoration(
    labelStyle: TextStyle(color: GrodudesPrimaryColor.primaryColor[600]),
    alignLabelWithHint: true,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: GrodudesPrimaryColor.primaryColor[600]!, width: 2)),
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  );
  final _headerTextStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

  @override
  void initState() {
    this.userManager = Provider.of<UserManager>(context, listen: false);
    if (this.userManager?.wcUserInfo!['id'] != null) {
      this.shippingAddress = new Map.from(userManager!.wcUserInfo!['shipping']);
      this.billingAddress = new Map.from(userManager!.wcUserInfo!['billing']);

      String wordpressEmail = userManager!.wpUserInfo!['user_email'] ?? '';
      String email = wordpressEmail;
      String woocommerceEmail = billingAddress!['email'];
      String phone = billingAddress!['phone'] ?? '';

      if (woocommerceEmail != null && woocommerceEmail.length > 0) {
        email = woocommerceEmail;
      }

      this._emailController = TextEditingController(text: email);

      this._phoneController = TextEditingController(text: phone);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (this._emailController != null) this._emailController!.dispose();
    if (this._phoneController != null) this._phoneController!.dispose();
    super.dispose();
  }

  _capitalize(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.colorBackGround,
        key: _scaffoldKey,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min,
                    // scrollDirection: Axis.vertical,
                    children: [
              Container(
                // height: 25.h,
                // width: 360.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

                child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: 13.w,
                        height: 13.w,
                        child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: SvgPicture.asset(
                                Assets.SVGArrow,
                                width: 26.w,
                                color: Styles.secondary2Color,
                              ),
                            ))),
                    SizedBox(
                      width: 110.w,
                    ),
                    // SizedBox(width: 16.w,),
                    Center(
                        child: Text(
                      "confirm order",
                      textAlign: TextAlign.center,
                      style: Styles.boldTextStyle.copyWith(
                          color: Styles.secondary2Color,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700),
                    )),
                    // Center(child:
                    // ),
                    Expanded(child: Container())
                    // SizedBox(width: 16.w,),
                  ],
                ),
              ),

              SizedBox(height: 10.h),
              Container(
                  height: 60.h,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                  decoration: Styles.textFieldDecoration,
                  child: TextField(
                      focusNode: _emailFocusNode,
                      key: _emailKey,
                      controller: this._emailController,
                      // onChanged: (value){
                      //   this._emailController!.text=value;
                      // },
                      onSubmitted: (value) {
                        this._emailController!.text = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: Styles.LoginFieldDecoration(
                          radius: 18.r,
                          hint: S.of(context).email,
                          color: Styles
                              .ColorWhite // prefixIcon: title == S.of(context).username

                          ))),
              SizedBox(height: 20.h),

              Container(
                  height: 60.h,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                  decoration: Styles.textFieldDecoration,
                  child: TextField(
                      controller: this._phoneController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      // onChanged: (value){
                      //   this._phoneController!.text=value;
                      // },
                      onSubmitted: (value) {
                        this._phoneController!.text = value;
                      },
                      decoration: Styles.LoginFieldDecoration(
                          radius: 23.r, hint: S.of(context).phoneNumber))),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(S.of(context).shippingAddress,
                        style: this._headerTextStyle),
                    IconButton(
                      icon: Icon(Icons.edit, color: Styles.colorPrimary),
                      onPressed: () => Utils.pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(name: RoutePaths.AccountRoot),
                          withNavBar: false,
                          screen: AddressUpdatePage(
                            address: this.shippingAddress!,
                            updateCb: (newAddress) {
                              setState(() => this.shippingAddress = newAddress);
                              // print(this.shippingAddress);
                            },
                            shouldDisplayPostcodeDropdown: true,
                          )

                          //   Navigator.push(
                          // context,
                          // CupertinoPageRoute(
                          //   builder: (context) => AddressUpdatePage(
                          //     this.shippingAddress!,
                          //     (newAddress) {
                          //       setState(() => this.shippingAddress = newAddress);
                          //       // print(this.shippingAddress);
                          //     },
                          //     shouldDisplayPostcodeDropdown: true,
                          //   ),
                          // ),
                          ),
                    )
                  ],
                ),
              ),
              // SizedBox(height: 8),
              ...this.shippingAddress!.entries.map(
                    (e) => Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Text(
                              e.key
                                  .split('_')
                                  .map((e) => _capitalize(e))
                                  .join(' '),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 7,
                            child: Text(
                              e.value,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              SizedBox(height: 16.h),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(S.of(context).billingAddress,
                          style: this._headerTextStyle),
                      IconButton(
                        icon: Icon(Icons.edit, color: Styles.colorPrimary),
                        onPressed: () => Utils.pushNewScreenWithRouteSettings(
                          context,
                          settings:
                              RouteSettings(name: RoutePaths.AddressUpdatePage),
                          withNavBar: false,
                          screen: AddressUpdatePage(
                            address: this.billingAddress!,
                            updateCb: (newAddress) {
                              setState(() => this.billingAddress = newAddress);
                              // print(this.billingAddress);
                            },
                            shouldDisplayPostcodeDropdown: false,
                          ),
                        ),
                      )
                    ],
                  )),
              // SizedBox(height: 8),
              ...this.billingAddress!.entries.map((e) => Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            e.key
                                .split('_')
                                .map((e) => _capitalize(e))
                                .join(' '),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 7,
                          child: Text(
                            e.value,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )),
              InkWell(
                  child: Container(
                      width: 280.w,
                      height: 54.h,
                      decoration: Styles.roundedDecoration.copyWith(
                        color: Styles.colorPrimary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(27.r),
                        ),
                      ),
                      child: Center(
                        child: Text(S.of(context).placeOrder,
                            style: Styles.boldTextStyle.copyWith(
                                color: Styles.ColorWhite,
                                fontSize: Styles.fontSize22)),
                      )),
                  onTap: () {
                    if (this._emailController!.text.length == 0 ||
                        this._phoneController!.text.length == 0) {
                      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                          .showSnackBar(SnackBar(
                              content: Text(S
                                  .of(context)
                                  .pleaseFillOutYourEmailAndPhoneNumber)));
                      return;
                    }
                    if (this._emailController!.text.contains('@') &&
                        billingAddress!['email'] !=
                            this._emailController!.text) {
                      billingAddress!['email'] = this._emailController!.text;
                    }
                    if (this._phoneController!.text.indexOf(RegExp(r'[,. ]')) ==
                            -1 &&
                        billingAddress!['phone'] !=
                            this._phoneController!.text) {
                      billingAddress!['phone'] = this._phoneController!.text;
                    }
                    Utils.pushNewScreenWithRouteSettings(
                      context,
                      settings:
                          RouteSettings(name: RoutePaths.OrderPlacementPage),
                      withNavBar: false,
                      screen: OrderPlacementPage(
                        customerId: userManager!.wcUserInfo!['id'],
                        billingAddress: this.billingAddress!,
                        shippingAddress: this.shippingAddress!,
                        items: Provider.of<CartManager>(context, listen: false)
                            .filterCartItems,
                      ),
                    );
                  }),
              SizedBox(height: 25.h)
            ]))));
  }
}
