import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/CartListItem.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/models/disturber.dart';
import 'package:grodudes/pages/checkout/ConfirmationPage.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:provider/provider.dart';

import '../components/distrubter_card_aumet_cart.dart';
import '../core/configurations/assets.dart';
import '../core/utils.dart';
import '../routing/route_paths.dart';
import '../state/user_state.dart';
import 'account/AccountRoot.dart';

class CartItems extends StatefulWidget {
  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  TextEditingController _couponController = new TextEditingController();
  final _textFieldDecoration = InputDecoration(
    labelStyle: TextStyle(color: GrodudesPrimaryColor.primaryColor[600]),
    alignLabelWithHint: true,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: GrodudesPrimaryColor.primaryColor[600]!, width: 2)),
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  );
  String _calculateCartTotal(List<Product> items, double amount) {
    double total = 0;

    items.forEach(
        (item) => total += double.parse(item.data!['price']) * item.quantity);
    if (amount == 0) {
      total = total;
    } else {
      total = total * amount;
    }
    return total.toStringAsFixed(2);
  }

  bool showCoupon = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => () {});
    _couponController!.text = "test";
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Styles.colorBackGround,

      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        // scrollDirection: Axis.vertical,
        children: [
          Container(
            height: 46.h,
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
                  "Review order",
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
          Container(
              height: 156.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView.separated(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: Provider.of<CartManager>(context, listen: false)
                      .distrubersList
                      .length,
                  itemBuilder: (context, index) {
                    Disturber tmp =
                        Provider.of<CartManager>(context, listen: false)
                            .distrubersList[index];
                    return DisturberCardCart(
                      width: 139.w,
                      height: 156.h,
                      item:
                          Disturber(name: tmp.name, id: tmp.id, imagePath: ""),

                      //  value.cartItems[index]
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 20.w,
                    );
                  })),
          SizedBox(
            height: 28.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            //
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 460.w,

                  height: 18.h,
                  // width:153.w,

                  child: Text(
                    S.of(context).total,
                    style: Styles.boldTextStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: Styles.fontSize15,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
                // Expanded(child:Container()),
                Container(
                  height: 18.h,
                  width: 460.w,
                  child: Consumer<CartManager>(
                      builder: (context, cart, child) => Text(
                            S.of(context).currencyLogo +
                                " " +
                                Provider.of<CartManager>(context, listen: false)
                                    .totalFiltered
                                    .toString() +
                                S.of(context).currencyLogo,
                            style: Styles.boldTextStyle.copyWith(
                              color: Styles.secondary2Color,
                              fontWeight: FontWeight.w700,
                              fontSize: Styles.fontSize15,
                            ),
                            // textAlign: TextAlign.center,
                          )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 61.h,
          ),
          Consumer<CartManager>(
            builder: (context, cart, child) => Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: cart.filterCartItems.length,
                  itemBuilder: (context, index) {
                    print(cart.filterCartItems[index].quantity);
                    return CartListItem(cart.filterCartItems[index]

                        //  value.cartItems[index]
                        );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20.h,
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          Consumer<CartManager>(
            builder: (context, cart, child) => Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // height:26.5.h,
                          // width:153.w,

                          child: Text(
                            S.of(context).total,
                            style: Styles.boldTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: Styles.fontSize15,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          child: Consumer<CartManager>(
                              builder: (context, cart, child) => Text(
                                  S.of(context).currencyLogo +
                                      " "
                                          '${cart.total} ' +
                                      S.of(context).currencyLogo,
                                  style: Styles.boldTextStyle.copyWith(
                                    color: Styles.secondary2Color,
                                    fontWeight: FontWeight.w700,
                                    fontSize: Styles.fontSize15,
                                  ))
                              // textAlign: TextAlign.center,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                            height: 26.5.h,
                            // width:153.w,
                            child: Center(
                                child: Text(
                              Provider.of<UserManager>(context, listen: false)
                                  .wcUserInfo!['username'],
                              style: Styles.boldTextStyle.copyWith(
                                  fontSize: Styles.fontSize12,
                                  fontWeight: FontWeight.w500),
                            ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Provider.of<CartManager>(context, listen: false)
                              .cartItems
                              .length >
                          0
                      ? Center(
                          child: InkWell(
                              onTap: () {
                                if (
                                    // this.userManager.isLoggedIn() == false ||
                                    Provider.of<UserManager>(context,
                                                listen: false)
                                            .wcUserInfo!['id'] ==
                                        null) {
                                  Utils.pushNewScreenWithRouteSettings(
                                    context,
                                    settings: RouteSettings(
                                        name: RoutePaths.AccountRoot),
                                    withNavBar: false,
                                    screen: AccountRoot(),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   CupertinoPageRoute(builder: (context) => AccountRoot()),
                                  // );
                                } else {
                                  Utils.pushNewScreenWithRouteSettings(context,
                                      settings: RouteSettings(
                                          name: RoutePaths.ConfirmationPage),
                                      withNavBar: false,
                                      screen: ConfirmationPage());
                                }
                                // Navigator.push(
                                //     context,
                                //     CupertinoPageRoute(
                                //         builder: (context) => ConfirmationPage()));

                                showCoupon = false;
                                setState(() {});
                              },
                              child: Container(
                                width: 370.w,
                                height: 66.h,
                                decoration: Styles.roundedDecoration.copyWith(
                                  color: Styles.secondary2Color,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(33.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text("Review order",
                                      style: Styles.meduimTextStyle.copyWith(
                                        fontSize: Styles.fontSize20,
                                        fontWeight: FontWeight.w900,
                                        color: Styles.ColorWhite,
                                      )),
                                ),
                              )))
                      : SizedBox(height: 0),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          )
        ],
      ))),
      // bottomNavigationBar:,
    );
  }

  _buildCouponWidget() {
    return Container(
      // height: 150.h,
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Provider.of<CartManager>(context, listen: false).cartState ==
              cartStates.pending
          ? CircularProgressIndicator(
              color: Styles.colorPrimary,
            )
          : Column(
              children: [
                TextField(
                    controller: _couponController,
                    keyboardType: TextInputType.text,
                    onSubmitted: (value) {
                      Provider.of<CartManager>(context, listen: false)
                          .applyCoupon(
                              _couponController!.text.toString() ?? "");
                      // _couponController.text = value!;
                      // address[key] = value!;
                    },
                    onChanged: (value) {
                      // _couponController.text = value!;
                      // address[key] = value!;
                    },
                    style: Styles.regularTextStyle.copyWith(
                        fontSize: Styles.fontSize18,
                        color: Styles.colorPrimary),
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      filled: true,

                      fillColor: Colors.white,
                      hintText: S.of(context).coupon,
                      hintStyle: Styles.regularTextStyle.copyWith(
                          fontSize: Styles.fontSize18,
                          color: Styles.colorPrimary),
                      border: Styles.roundedOutlineInputBorder(
                        radius: 25.r,
                      ),
                      focusedBorder:
                          Styles.roundedOutlineInputBorder(radius: 25.r),
                      enabledBorder:
                          Styles.roundedOutlineInputBorder(radius: 25.r),
                      errorBorder: Styles.roundedOutlineInputBorder(
                              radius: 25.r)
                          .copyWith(borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: Styles.roundedOutlineInputBorder(
                              radius: 25.r)
                          .copyWith(borderSide: BorderSide(color: Colors.red)),
                      disabledBorder:
                          Styles.roundedOutlineInputBorder(radius: 25.r),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 34.w, vertical: 17.h),
                      // filled: true,
                      suffixIcon: GestureDetector(
                        child: Icon(
                          Icons.add_outlined,
                          color: Styles.colorPrimary,
                          size: 19.6.w,
                        ),
                        onTap: () {
                          setState(() {
                            Provider.of<CartManager>(context, listen: false)
                                .applyCoupon(
                                    _couponController!.text.toString() ?? "")
                                .then((value) => setState(() {}));
                            // isHiddenPassword = !isHiddenPassword;
                            // passwordIcon = isHiddenPassword == true
                            //     ? Icons.visibility_off
                            //     : Icons.visibility;
                          });
                        },
                      ),

                      // style: TextStyle(fontSize: 20),
                    )),
              ],
            ),
    );
  }
}
