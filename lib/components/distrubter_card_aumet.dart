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

class DisturbersCardAumet extends StatelessWidget {
  final Product item;
  final double width;
  final double height;


  DisturbersCardAumet({required this.item,required this.width,required this.height});

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
        // width: width ,
        height: height,
        // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: EdgeInsets.all(12.h),
        decoration: Styles.speicialOfferDecoration.copyWith(
            borderRadius: BorderRadius.all(
              Radius.circular(0.r),
            )),
        child:
            Row(children: [
              Container(width: 28.r,
              child:
                   Container(
height: 28.r,
                      width: 34.r,
                      // margin:
                      // Provider
                      //     .of<LocaleProvider>(context, listen: false)
                      //     .locale
                      //     .languageCode != "ar" ?
                      // EdgeInsets.only(left: 22.w, right: 68.w, top: 21.h) :
                      // EdgeInsets.only(right: 22.w, left: 68.w, top: 21.h),
                      child: Center(
                          child: Container(
                              decoration: Styles.shadowPrimaryDecoration.copyWith(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(34.r),
                                  ),
                                  boxShadow: [  ]),


                              child:

                              ClipRRect(
                                // color: Colors.black,

                                borderRadius: BorderRadius.circular(34.r),
                                child: item.data['images'].length != 0
                                    ? ImageFetcher.getImage(
                                    item.data['images'][0]['src'])
                                    : ImageFetcher.getImage(""),
                              )
                          )
                      )),

               ),
              SizedBox(width: 20.w),

Expanded(child:

Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [


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
  Container(
      width: 150.w,
      child: Text(

        item.data['name'],
        maxLines: 1,

        overflow: TextOverflow.ellipsis,
        style: Styles.boldTextStyle
            .copyWith(fontSize:
        9.sp,


          color: Styles.ColorText,
        ),
      )),

],)

),
              SizedBox(
                width: 50.w,
                child:
Row(

  mainAxisAlignment:MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,

  children: [

  SizedBox(
    height:10.w,
    width: 10.w,
    child:
    FittedBox(
    fit: BoxFit.scaleDown,
  child:

    Icon(Icons.star,color: Color(0xFFEAC133),)),),
                       Expanded(child:
                       item.data['purchasable'] != null && item.data['purchasable']
                          ? item.data['in_stock']
                          ?

                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Text( "JOD "+
                              this.item.data['price'].toString(),
                              style:Styles.boldTextStyle.copyWith(

                                  fontSize: 11.sp,
                                  color: Styles.ColorText,
                                  fontWeight: FontWeight.w400)


                          ))
                          :    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: Text(
                            'Out of Stock',
                            style: Styles.boldTextStyle.copyWith(
                                fontSize: Styles.fontSize32
                            )),
                      )
                          : SizedBox(width: 0.w,
                        // height: 44.h,
                       ))

    ],)),
              SizedBox(width: 20.w)

            ],)


      ),
    );
  }
}
