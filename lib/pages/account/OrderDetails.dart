import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/ProductListTile.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/core/widget/majl/majal_app_bar.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:provider/provider.dart';

import '../../core/configurations/assets.dart';
import '../../core/widget/majl/dashed_divider.dart';

class OrderDetails extends StatelessWidget {
  final Map<String, dynamic> order;

  OrderDetails(this.order);

  String _getQuantityById(int id) {
    List<dynamic> lineItems = this.order['line_items'];
    if (lineItems == null) return 'Not Found';
    String quantity = 'Not Found';
    lineItems.forEach((item) {
      if (item['product_id'] == id) {
        quantity = item['quantity'].toString();
      }
    });
    return quantity;
  }

  @override
  Widget build(BuildContext context) {
    if (order == null || order['id'] == null) {
      return Scaffold(
        // backgroundColor: Styles.colorBackGround,
        // appBar: AppBar(
        //   title: Text(
        //     S.of(context).orderDetails,
        //     style: Styles.appBarTextStyle,
        //   ),
        //   iconTheme: IconThemeData(color: Colors.black87, size: 36),
        //   backgroundColor: Styles.colorBackGround,
        // ),
        body:
    SafeArea(child:
    SingleChildScrollView(
    child:
        Container(
          decoration: BoxDecoration(


              color: Colors.white

          ),
          alignment: Alignment.center,

          child: Column(
        // scrollDirection: Axis.vertical,
        children: [
          MajalAppBar(
            withBack: true,
            boxDecoration: BoxDecoration(


                color: Colors.white

            ),
          ),

          SizedBox(child:
          Center(
            child: Text(S.of(context).orderDetails,
              style: Styles.boldTextStyle,),
          )),
        SizedBox(
          height: 100.h,
        ),
        Text(
            S.of(context).somethingWentWrong,
            style: Styles.boldTextStyle,
            textAlign: TextAlign.center,
          ),

          ]
          ),
      )
    )
      )
      );
    }
    // print(order);
    final String date = order['date_created'].toString().substring(0, 10);
    final Map<String, dynamic> shippingAddress = this.order['shipping'];
    final Map<String, dynamic> billingAddress = this.order['billing'];
    // final Map<String, dynamic> couponDetails = this.order['coupon_lines'];
    return Scaffold(
      backgroundColor: Styles.colorBackGround,
      // appBar: AppBar(
      //   title: Text(
      //     S.of(context).orderDetails,
      //     style: Styles.appBarTextStyle,
      //   ),
      //   iconTheme: IconThemeData(color: Colors.black87, size: 36),
      //   backgroundColor: Styles.colorBackGround,
      // ),
      body:
      SafeArea(child:
      SingleChildScrollView(
          child: Container(
              color: Styles.ColorWhite,

              // padding: EdgeInsets.symmetric(horizontal:41.w ),
              child: Column(
                // scrollDirection: Axis.vertical,
                children: [

                  MajalAppBar(
                    withBack: true,
                    boxDecoration: BoxDecoration(


                        color: Colors.white

                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal:41.w ),
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                  SizedBox(height: 15),
Center(child:
                    SizedBox(
    height: 24.8.h,
    width: 39.h,

    child:
    SvgPicture.asset(
    Assets.SVG_order,)
                    )    ),
                  SizedBox(child:
                  Center(
                    child: Text(S.of(context).orderDetails,
                      style: Styles.boldTextStyle,),
                  )),



                        SizedBox(height: 4.h,),
                  Row(
                    children: [
                      Text(S.of(context).orderTotal,
                                        style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize27),
          ),
                      SizedBox(width: 16),
                      order['coupon_lines'].length > 0
                          ? Expanded(
                              child: Text(
                                '${double.parse(order['total']) * double.parse(order['coupon_lines'][0]["discount"]) / 100}'+S.of(context).currencyLogo,
                                style: Styles.boldTextStyle.copyWith(color: Styles.colorPrimary,fontSize: Styles.fontSize27),
                              ),
                            )
                          : Expanded(
                              child: Text(
                                '${order['total']} '+S.of(context).currencyLogo,
                                         style: Styles.boldTextStyle.copyWith(color: Styles.colorPrimary,fontSize: Styles.fontSize27),

                              ),
                            ),
                    ],
                  ),
                        SizedBox(height: 4.h,),
                  Row(
                    children: [
                      Text(S.of(context).orderStatus,
                          style: Styles.boldTextStyle.copyWith(
                            // fontSize: Styles.fontSize2,
                              fontSize: Styles.fontSize27
                          )),
                      // SizedBox(width: 16),
                      Text(
  " "+order['status'].split('-').join(' '),
                         style: Styles.boldTextStyle.copyWith(
                      // fontSize: Styles.fontSize2,
                           color: Styles.colorPrimary,
                      fontSize: Styles.fontSize27

                        ),
                      ),
                    ],
                  ),
                        SizedBox(height: 4.h,),

                        Row(children: [

                     Text(
                       S.of(context).itemquantity+" ",
                       style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize27)),

                   Text(
                    '${order['line_items'].length} ${order['line_items'].length > 1 ? 'items' : 'item'}',
                       style: Styles.boldTextStyle.copyWith(
                           color: Styles.colorPrimary,
                           fontSize: Styles.fontSize27)
          ),
                   ],),
                        SizedBox(height: 15.h,),

                   Text(
                    S.of(context).orderPlacedon + date.split('-').reversed.join('//'),
                    style:  Styles.lightTextStyle,
                  ),
                        SizedBox(height: 4.h,),

                        // CommonSizes.vSmallestSpace,
                  Text(
                    S.of(context).paymentMethod +
                        (order['payment_method_title'] ??
                            S.of(context).notFound),
                      style:  Styles.lightTextStyle,),



                    ],)),
SizedBox(height: 36.h,),
                  //DashedLine
                  DashedDivider(height: 4.h,),
                  //
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 38.w,),
                    color: Styles.colorBackGround,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
SizedBox(height: 23.h,),

                  Text(S.of(context).shippingAddress,
                      style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize28)),
SizedBox(height: 14.h,),
                        Column(
                    children: [
                      ...(shippingAddress ?? {'error': 'Something went wrong'})
                          .entries
                          .map((e) => _OrderAddressRow(e.key, e.value)),
                    ],
                  ),
                        SizedBox(height: 34.h,),

                   Text(S.of(context).billingAddress,
                      style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize28)),
                        SizedBox(height: 14.h,),
                  Column(
                    children: [
                      ...(billingAddress ?? {'error': 'Something went wrong'})
                          .entries
                          .map((e) => _OrderAddressRow(e.key, e.value)),
                    ],
                  ),

                  SizedBox(height: 15.h),
                        Text(S.of(context).coupon,
                            style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize28)),

                  SizedBox(height: 15.h),
                  // order['coupon_lines'].length > 0
                  //     ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                 Text(S.of(context).code,
                                      style: Styles.meduimTextStyle.copyWith(fontSize:Styles.fontSize20 )),

                              Text(order['coupon_lines'].length > 0
                                  ?
                                        order['coupon_lines'][0]["code"]:"",
                                          style: Styles.lightTextStyle.copyWith(fontSize:Styles.fontSize20 )),


                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                               Text(S.of(context).discount,
                                      style: Styles.meduimTextStyle.copyWith(fontSize:Styles.fontSize20),
                                ),
                               Text(   order['coupon_lines'].length > 0
                                     ?
                                        order['coupon_lines'][0]["discount"] +
                                            "%":"",
                                        style: Styles.meduimTextStyle.copyWith(fontSize:Styles.fontSize20),

                                ),
                              ],
                            )
                          ],
                        ),
                      // : SizedBox(
                      //     height: 0,
                      //   ),
                  SizedBox(height: 15.h),
                  Text(S.of(context).orderedProducts,
                      style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize28)),
                  SizedBox(height: 8),
                  FutureBuilder(
                    future: Provider.of<ProductsManager>(context)
                        .getProductsInOrder(order),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (snapshot.hasError) {
                        return Column(
                          children: [
                            SizedBox(height: 15.h),
                            Icon(Icons.error, color: Colors.red[600], size: 36),
                            Text(
                              S.of(context).failedToFetchProducts,
                              style:Styles.boldTextStyle,
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot!.data!.length,
                          itemBuilder: (context, index) =>
                              _OrderedProductListTile(
                                  snapshot.data![index]!,
                                  _getQuantityById(
                                      snapshot.data![index].data['id'])),
                        );
                      }
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    },
                  )

                    ],),
                  )
                ],
              ))),
    ));
  }
}

class _OrderedProductListTile extends StatelessWidget {
  final Product item;
  final String orderQuantity;
  _OrderedProductListTile(this.item, this.orderQuantity);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 4.h,),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).product +": ",
              style: Styles.meduimTextStyle.copyWith(fontSize:Styles.fontSize20),
            ),
            Text(   item.data["name"],
              style: Styles.lightTextStyle.copyWith(fontSize:Styles.fontSize20),

            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).category+": ",
              style: Styles.meduimTextStyle.copyWith(fontSize:Styles.fontSize20),
            ),
            Text(  item.data["categories"].length>0?  item.data["categories"][0]["name"]:"",
              style: Styles.lightTextStyle.copyWith(fontSize:Styles.fontSize20),

            ),
          ],
        ),



        SizedBox(height: 15.h,),
        // ProductListTile(
        //   item,
        //   withAction: false,
        // ),
        CommonSizes.vSmallSpace,
        Text(
          S.of(context).orderQuantity + orderQuantity,
          // S.of(context).notFound,
          style: Styles.lightTextStyle.copyWith(fontSize: Styles.fontSize20)
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class _OrderAddressRow extends StatelessWidget {
  final String addressKey;
  final String addressValue;
  _OrderAddressRow(this.addressKey, this.addressValue);

  _capitalize(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  String _formatName(String name) {
    return name.split('_').map((e) => _capitalize(e)).join(' ')+": ";
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 26.h+15.h,
           child:

      Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [



              Text(_formatName(this.addressKey), style: Styles.meduimTextStyle.copyWith(fontSize: Styles.fontSize20)),


          Container(
            child: Text(this.addressValue,
                style: Styles.lightTextStyle.copyWith(fontSize: Styles.fontSize20)),
          ),

      ],
    ));
  }
}
