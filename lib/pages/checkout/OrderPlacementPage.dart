import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/WooCommerceAPI.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:provider/provider.dart';

import '../../core/configurations/assets.dart';
import '../../core/widget/majl/dashed_divider.dart';
import '../../core/widget/majl/majal_app_bar.dart';
import '../../secret.dart';

class OrderPlacementPage extends StatefulWidget {
  final int customerId;
  final Map<String, dynamic> billingAddress;
  final Map<String, dynamic> shippingAddress;
  final List<Product> items;

  OrderPlacementPage({
    required this.customerId,
    required this.billingAddress,
    required this.shippingAddress,
    required this.items,
  });

  @override
  _OrderPlacementPageState createState() => _OrderPlacementPageState();
}

class _OrderPlacementPageState extends State<OrderPlacementPage> {
  Map<String, dynamic>? orderDetails;

  @override
  initState() {
    this.orderDetails = {};
    super.initState();
  }

  Future _placeOrder() async {
    if (this.orderDetails!['id'] != null) return this.orderDetails;

    List<dynamic> lineItems = [];
    for (Product item in this.widget.items) {
      lineItems.add({
        "product_id": item.data!['id'],
        "quantity": item.quantity > 0 ? item.quantity : 1,
        'total':100,

        "code": "test",
        "discount_total	":
            (100 * Provider.of<CartManager>(context, listen: false).amount)
                .toString()
      });
    }

    Map<String, dynamic> orderBody = {
      "payment_method": "Cod",
      "payment_method_title": "Cash on delivery",
      "customer_id": this.widget.customerId,
      "billing": this.widget.billingAddress,
      "shipping": this.widget.shippingAddress,
      "line_items": lineItems,
      'coupon_lines': [
        {
          'code': 'mycouponcode',
          'discount': '50',
          'discount_tax': '0.75',
        }
      ],
    };

    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: Secret.baseUrl,
        consumerKey: Secret.consumerKey,
        consumerSecret: Secret.consumerSecret);

    this.orderDetails = await wooCommerceAPI.postAsync('orders', orderBody);
    return this.orderDetails;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.customerId == null ||
        widget.billingAddress == null ||
        widget.shippingAddress == null) {
      return Scaffold(
         body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // scrollDirection: Axis.vertical,
                children: [

                  Center(
          child: Text(
            S.of(context).sorryThereWasAnError,
            style:   Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize29),
          )
            )
            ]
              ),
        ),
      )
      );
    }
    return Scaffold(
      backgroundColor: Styles.colorBackGround,
      body: SafeArea(
               child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  // scrollDirection: Axis.vertical,
                  children: [

                    // SizedBox(height: 260.h),
Expanded(child: Container()),



             FutureBuilder(
              future: _placeOrder(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done)
                  return Center(child: CircularProgressIndicator(color: Styles.colorPrimary,));
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(S.of(context).connectionErrorMessage,
                            style:Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize29)),
                        MaterialButton(
                          child: Text(S.of(context).retry),
                          onPressed: () => setState(() {}),
                        )
                      ],
                    ),
                  );
                }
                if (snapshot.hasData) {
                  if (snapshot.data['id'] == null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            S.of(context).errorMessageOrderServer,style:Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize29
                          )),
                          MaterialButton(
                            child: Text(S.of(context).retry),
                            onPressed: () => setState(() {}),
                          )
                        ],
                      ),
                    );
                  } else {

                    return Center(
                      child: Container(
                        // height: 272.h,
                        width: 356.w,
                        decoration: Styles.roundedDecoration.copyWith(
                            borderRadius: BorderRadius.all(
                        Radius.circular(29.r),
                      )
                        ),
                        // shrinkWrap: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [


                           SizedBox(height: 30.2.h),

                          SizedBox(height: 24.8.h,
                          width: 38.2.w,
                          child: SvgPicture.asset(Assets.SVG_orderConfirm,color: Styles.colorPrimary,            fit: BoxFit.scaleDown,
                          ),),
                          SizedBox(height: 8.h,),
                         Container(
                           height:38.h ,
                           // width: 272.w,
                           child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                              S.of(context).yourOrderId ,
                            textAlign: TextAlign.center,
                            style:  Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize29
                            )),
                            Text(

                                  " ${snapshot.data['id']}",
                              textAlign: TextAlign.center,
                              style:  Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize29,color: Styles.colorPrimary
                              ),
                            )
                          ],)),


                          SizedBox(height: 20.h),
                            Container(
                              width: 262.w,
                              child:Center(child:

                            Text(

                                S.of(context).youOrderIsDueToBePaid+"\n"+
                                S.of(context).youOrderIsDueToBePaid2,
                                style: Styles.regularTextStyle.copyWith(
                                  fontSize: Styles.fontSize17  ,


                                )  ,
                              textAlign: TextAlign.center,
                              // softWrap: true,
maxLines: 3,

                            )
                              )
                            ),
                          SizedBox(height: 29.h),
                         Container(
                           height: 89.h,
                           width: 356.w,
                           decoration: Styles.finishOrderDecoration,

                             child:
Column(children: [
  SizedBox(height: 4.h),

  DashedDivider(height: 4.h,color: Styles.ColorWhite,),
  SizedBox(height: 19.h),

                           InkWell(
                              child:
                              Center(child:
                              Text(
                                S.of(context).finishOrder,
                                style: Styles.boldTextStyle.copyWith(
                                  fontSize: Styles.fontSize25,
                                  color: Styles.ColorWhite
                                )
                              )),
                              onTap: () {
                                Provider.of<CartManager>(context, listen: false)
                                    .clearCart();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
],),
                          ),

                          ],
                        )
                      ),
                    );
                  }
                }
                return Center(child: CircularProgressIndicator(color: Styles.colorPrimary,));
              },
            ),
                    SizedBox( height:328.h),
                    ]) ),
    );
  }
}
