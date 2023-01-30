import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/QuantityToggle.dart';
import 'package:grodudes/components/StyledProductPrice.dart';
import 'package:grodudes/core/configurations/assets.dart';
import 'package:grodudes/helper/ImageFetcher.dart';
import 'package:grodudes/models/Product.dart';
 import 'package:grodudes/state/cart_state.dart';
import 'package:provider/provider.dart';

import '../core/configurations/styles.dart';
import '../core/utils.dart';
import '../generated/l10n.dart';
import '../l10n/locale_provider.dart';
import '../routing/route_paths.dart';
import '../state/user_state.dart';
import 'ProductDescriptionText.dart';

class DisturbersCardAumetH extends StatelessWidget {
  final Product item;
  final double width;
  final double height;


  DisturbersCardAumetH({required this.item,required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
    if (this.item == null || this.item.data['id'] == null) {
      return SizedBox(height: 0);
    }
    return GestureDetector(
      onTap: () {
        // WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
        // Utils.pushNewScreenWithRouteSettings(context,
        //     settings: RouteSettings(name: RoutePaths.ProductDetailsPage),
        //     withNavBar: false,
        //     screen: ProductDetailsPage(
        //       this.item,
        //     ));


      },
      child: Container(
        width: width ,
        height: height,

        // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: EdgeInsets.all(12.h),
        decoration: Styles.speicialOfferDecoration.copyWith(
            borderRadius: BorderRadius.all(
              Radius.circular(0.r),
            )),
        child:
            Row(

              children: [
              Container(
                width: 28.r,
              child:
                   Container(
height: 25.r,
                      width: 25.r,
                      // margin:
                      // Provider
                      //     .of<LocaleProvider>(context, listen: false)
                      //     .locale
                      //     .languageCode != "ar" ?
                      // EdgeInsets.only(left: 22.w, right: 68.w, top: 21.h) :
                      // EdgeInsets.only(right: 22.w, left: 68.w, top: 21.h),
                      child: Center(
                          child: Container(
                              // decoration: Styles.shadowPrimaryDecoration.copyWith(
                              //     borderRadius: BorderRadius.all(
                              //       Radius.circular(0.r),
                              //     ),
                              //     boxShadow: [  ]),

                               child:

                              ClipRRect(
                                // color: Colors.black,

                                borderRadius: BorderRadius.circular(28.r),
                                child: item.data['images'].length != 0
                                    ? ImageFetcher.getImage(
                                    item.data['images'][0]['src'])
                                    : ImageFetcher.getImage(""),
                              )
                          )
                      )),

               ),
SizedBox(width: 13.w,),
Expanded(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[



                          Container(
                              width: 150.w,
                              child: Text(

                                item.data['name'],
                                maxLines: 1,

                                overflow: TextOverflow.ellipsis,
                                style: Styles.boldTextStyle
                                    .copyWith(fontSize: Styles.fontSize11,


                                     color: Styles.ColorText,
                                 ),
                              )),
                   SizedBox(height: 6.h,),
                   SizedBox(
                    height: 13.h,
                      child:Container(
                           child:
                      Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                        SizedBox(

                          height: 13.h,

                          child:
                          FittedBox(
                            fit: BoxFit.scaleDown,

                            child:
                          Icon(
                            Icons.star,
                            color: Color(0xFFEAC133),

                          ),
                        ),),
                        item.data['purchasable'] != null && item.data['purchasable']
                            ? item.data['in_stock']
                            ?

                        Container(
                             height: 13.h,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Text(
                                this.item.data['price'].toString()+ "   (${ this.item.data['price'].toString()})",
                                style:Styles.boldTextStyle.copyWith(

                                    fontSize: 11.sp,
                                    color: Styles.ColorText,
                                    fontWeight: FontWeight.w400)


                            ))
                            :    Container(
                          height: 13.h,

                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Text(
                              'Out of Stock',
                              style: Styles.boldTextStyle.copyWith(
                                  fontSize: Styles.fontSize32
                              )),
                        )
                            : SizedBox(
                          width: 124.w,
                          height: 13.h,)

                      ],))
                    ,),
                   SizedBox(
                    height: 13.h,
                      child:Container(
                           child:
                      Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                         item.data['purchasable'] != null && item.data['purchasable']
                            ? item.data['in_stock']
                            ?

                        Container(
                             height: 13.h,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Text(
                              "minimum order 400"+ "   (${ this.item.data['price'].toString()})",
                                style:Styles.boldTextStyle.copyWith(

                                    fontSize: 11.sp,
                                    color: Styles.ColorText,
                                    fontWeight: FontWeight.w400)


                            ))
                            :    Container(
                          height: 13.h,

                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Text(
                              'Out of Stock',
                              style: Styles.boldTextStyle.copyWith(
                                  fontSize: Styles.fontSize32
                              )),
                        )
                            : SizedBox(
                          width: 124.w,
                          height: 13.h,)

                      ],))
                    ,),
                ],
              ),
)
            ],)


      ),
    );
  }
}
