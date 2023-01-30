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

class ProductCardN extends StatelessWidget {
  final Product item;

  ProductCardN(this.item);

  @override
  Widget build(BuildContext context) {
    if (this.item == null || this.item.data['id'] == null) {
      return SizedBox(height: 0);
    }
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();


      },
      child: Container(
        width: 297.w,
        height: 366.h,
        // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        // padding: EdgeInsets.all(8),
        decoration: Styles.tilesDecoration.copyWith(
            borderRadius: BorderRadius.all(
              Radius.circular(29.r),
            )),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 207.w,
                    height: 207.h,
                    margin:
                    Provider
                        .of<LocaleProvider>(context, listen: false)
                        .locale
                        .languageCode != "ar" ?
                    EdgeInsets.only(left: 22.w, right: 68.w, top: 21.h) :
                    EdgeInsets.only(right: 22.w, left: 68.w, top: 21.h),
                    child: Center(
                        child: Container(
                            decoration: Styles.shadowPrimaryDecoration.copyWith(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(207.r),
                                ),
                                boxShadow: [  ]),
                            child:

                            ClipRRect(
                              // color: Colors.black,

                              borderRadius: BorderRadius.circular(207.r),
                              child: item.data['images'].length != 0
                                  ? ImageFetcher.getImage(
                                  item.data['images'][0]['src'])
                                  : ImageFetcher.getImage(""),
                            )
                        )
                    )),
                SizedBox(
                  height: 14.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 22.w,
                    ),
                    Column(
                      children: [
                        Container(
                            width: 150.w,
                            child: Text(

                              item.data['name'],
                              maxLines: 1,

                              overflow: TextOverflow.ellipsis,
                              style: Styles.boldTextStyle
                                  .copyWith(fontSize: Styles.fontSize24),
                            )),
                      ],
                    ),
                    Expanded(child: Container()),

                    SizedBox(width: 21.w,),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                  SizedBox(
                    width:14.w ,
                  ),
                  Container(

                    width: 200.w,
                    height: 44.h,
                    child: this.item.data['description'].length > 0
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: ProductDescriptionText(
                        S
                            .of(context)
                            .about,
                        this.item.data['description'],sizeFont: 15,
                      ),
                    )
                        : SizedBox(
                      width: 124.w,
                      height: 44.h,
                    ),
                  )

                ],),
                SizedBox(height: 1.h),
                Row(children: [
                  SizedBox(
                    width: 22.w,
                  ),
                  item.data['purchasable'] != null && item.data['purchasable']
                      ? item.data['in_stock']
                      ? StyledProductPrice(this.item.data['price'],
                      this.item.data['regular_price'],style:Styles.boldTextStyle.copyWith(
                          fontSize: Styles.fontSize19
                      )
                  )
                      : Text(
                    'Out of Stock',
                    style: Styles.boldTextStyle.copyWith(
                        fontSize: Styles.fontSize32
                    ),
                  )
                      : SizedBox(height: 0),

                ],),
                SizedBox(height: 25.h)
              ],
            ),
            Provider
                .of<LocaleProvider>(context, listen: false)
                .locale
                .languageCode != "ar" ?
            Positioned(
              bottom: 21.h,

              right: 21.w,
               child: item.data['purchasable'] != null &&
                  item.data['purchasable'] &&
                  item.data['in_stock']
                  ? SizedBox(
                width: 47.w,
                // height: 149.h,
                // alignment: Alignment.topRight,
                child: QuantityToggle(
                  this.item,
                  height: 149.h,
                  width: 47.h,
                  margin: EdgeInsets.all(0),
                  iconSize: 24,
                ),
              )
                  : SizedBox(height: 0),) :



            Positioned(
              bottom: 21.h,

              left: 21.w,
              // left: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"? 0.w:21.w,
              child: item.data['purchasable'] != null &&
                  item.data['purchasable'] &&
                  item.data['in_stock']
                  ? SizedBox(
                width: 47.w,
                // height: 149.h,
                // alignment: Alignment.topRight,
                child: QuantityToggle(
                  this.item,
                  height: 149.h,
                  width: 47.h,
                  margin: EdgeInsets.all(0),
                  iconSize: 24,
                ),
              )
                  : SizedBox(height: 0),),

          Consumer<CartManager>(
              builder: (context, userManager, child) {
                return
            Provider
                .of<LocaleProvider>(context, listen: false)
                .locale
                .languageCode != "ar" ?
            Positioned(
              top: 21.h,

              right: 27.w,
              // left: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"? 0.w:21.w,
              child:
              InkWell(
                child:

                Container(
                  width: 37.w,
                  height: 39.h,
                  padding: EdgeInsets.all(4.0.h),
                  decoration: Styles.roundedDecoration.copyWith(
                      color: Styles.colorPrimary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      )),
                  child:

                  SizedBox(
                width: 20.w,
                height: 20.h,
                // alignment: Alignment.topRight,

                child:


                  SvgPicture.asset(   Provider.of<CartManager>(context, listen: false)
                      .isPresentInWishList(item) ?Assets.SVG_likeFilled:Assets.SVG_wishlist, color:
             Styles
                    .ColorWhite,fit: BoxFit.scaleDown,
                  // height:149.h ,
                  //   width: 47.h,
                  //   margin: EdgeInsets.all(0),
                  //   iconSize: 24,
                )),
                //   Icon( Provider.of<CartManager>(context, listen: false)
                //       .isPresentInWishList(item)?
                //
                //   Icons.favorite:Icons.favorite_border, color:Styles.ColorWhite))
              ),
                onTap: () {
                Provider.of<CartManager>(context, listen: false)
                    .isPresentInWishList(item)
                    ? Provider.of<CartManager>(context, listen: false)
                    .removeWishItem(item) : Provider.of<CartManager>(
                    context, listen: false).addWishItem(item);
              },)


            ) :
            Positioned(
              top: 21.h,

              left: 27.w,
              // left: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"? 0.w:21.w,

              child:   Container(
                  width: 37.w,
                  height: 39.h,
                  padding: EdgeInsets.all(4.0.h),
                  decoration: Styles.roundedDecoration.copyWith(
                      color: Styles.colorPrimary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.r),
                      )),
                  child:  InkWell(child:
              SizedBox(
                width: 20.w,
                height: 20.h,
                // alignment: Alignment.topRight,
                child:

                SvgPicture.asset( Provider.of<CartManager>(context, listen: false)
                    .isPresentInWishList(item)?
                Assets.SVG_likeFilled:Assets.SVG_wishlist,
               color: Styles
                    .ColorWhite,
                  fit: BoxFit.scaleDown,
                  // height:149.h ,
                  //   width: 47.h,
                  //   margin: EdgeInsets.all(0),
                  //   iconSize: 24,
                ),
                // Icon( Provider.of<CartManager>(context, listen: false)
                //     .isPresentInWishList(item)?Icons.favorite:Icons.favorite_border, color:Styles.ColorWhite)
              ), onTap: () {
                Provider.of<CartManager>(context, listen: false)
                    .isPresentInWishList(item)
                    ? Provider.of<CartManager>(context, listen: false)
                    .removeWishItem(item) : Provider.of<CartManager>(
                    context, listen: false).addWishItem(item);
              },))
            );

              }
          )
          ],
        ),
      ),
    );
  }
}
