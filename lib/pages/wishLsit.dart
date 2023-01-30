import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/CartListItem.dart';
import 'package:grodudes/components/wishListItem.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/pages/checkout/ConfirmationPage.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

import '../core/configurations/assets.dart';
import '../core/utils.dart';
import '../core/widget/majl/majal_app_bar.dart';
import '../l10n/locale_provider.dart';
import '../routing/route_paths.dart';
import '../state/user_state.dart';
import 'account/AccountRoot.dart';
import 'account/LogInPage.dart';

class Wishtems extends StatefulWidget {
  @override
  _WishtemsState createState() => _WishtemsState();
}

class _WishtemsState extends State<Wishtems>
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
        (item) => total += double.parse(item.data!['price']) * item.quantity!);
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

      body:

      SafeArea(child:

    SingleChildScrollView  (child:

    Column(
    // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      // scrollDirection: Axis.vertical,
      children: [
         MajalAppBar(
          withBack: true,

        ),

        SizedBox(child:
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),

          child: Center(child: Text(S.of(context).wishlist,
            style: Styles.boldTextStyle,),
        ))
        ),



        Container(

          // width: 162,
          child: Text(
            S.of(context).dragToDelete,style: Styles.regularTextStyle.copyWith(
              color: Styles.colorFontTitle,
              fontSize: Styles.fontSize17
          ),
          ),
        ),

SizedBox(height: 24.h,),
          Container(
            child: Consumer<CartManager>(builder: (context, value, child) {
              print("value.cartItems.length");
              for (int i = 0; i < value.cartWishItems.length; i++)
                print(value.cartWishItems[i].data);
              return ListView.separated(
                shrinkWrap: true,
                  physics:NeverScrollableScrollPhysics(),
                  itemCount: value.cartWishItems.length,
                  itemBuilder: (context, index) {
                    return WishListItem(value.cartWishItems[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 20.h,
                    );
                  });
            }),
          ),
        SizedBox(height: 40.h,),
         ],
      )
    )
      )
        ,
      // bottomNavigationBar:,
    );
  }

 }
