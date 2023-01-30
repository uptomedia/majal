import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/QuantityToggle.dart';
import 'package:grodudes/components/StyledProductPrice.dart';
import 'package:grodudes/core/configurations/assets.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/helper/ImageFetcher.dart';
import 'package:grodudes/models/Product.dart';
 import 'package:provider/provider.dart';

import '../core/utils.dart';
import '../generated/l10n.dart';
import '../l10n/locale_provider.dart';
import '../routing/route_paths.dart';
import '../state/cart_state.dart';
import 'ProductDescriptionText.dart';

class ProductFilterListTile extends StatelessWidget {
  final Product item;
  final bool withAction;

  ProductFilterListTile(this.item, {this.withAction: true});


  @override
  Widget build(BuildContext context) {
    if (this.item == null || this.item.data['id'] == null) {
      return SizedBox(height: 0);
    }
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();

        // Utils.pushNewScreenWithRouteSettings(context,
        //     settings:
        //     RouteSettings(name: RoutePaths.ProductDetailsPage),
        //     withNavBar: false,
        //     screen: ProductDetailsPage(
        //       this.item,
        //     ));


      },
      child: Container(
        width: 151.w,
        // height: 187.h,
        // margin: EdgeInsets.symmetric(horizontal: 22.w),
        // color: Colors.white,
        decoration: Styles.tilesDecoration.copyWith(
            borderRadius: BorderRadius.all(
              Radius.circular(18.r),
            )),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: 100.h,
                    height: 100.h,
                    margin:
                    Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"?
                    EdgeInsets.only(left: 11.w,  top: 10.h):
                    EdgeInsets.only(right: 11.w, top: 10.h),
                    child: Center(
                        child: Container(
                            decoration: Styles.shadowPrimaryDecoration.copyWith(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(105.r),
                                ), boxShadow: [  ]),
                            child: ClipRRect(
                              // color: Colors.black,

                              borderRadius: BorderRadius.circular(265.r),
                              child: item.data['images'].length != 0
                                  ? ImageFetcher.getImage(
                                  item.data['images'][0]['src'])
                                  : Image.asset(Assets.PNG_SplashImage),
                            )))),
                SizedBox(
                  height: 9.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 11.w,
                    ),
                    Column(
                      children: [
                        Container(
                            width: 100.w,
                            height: 18.h,
                            child: Text(

                              item.data['name'],
                              maxLines: 1,

                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: Styles.boldTextStyle
                                  .copyWith(fontSize: Styles.fontSize11),
                            )),
                      ],
                    ),
                    // Expanded(child: Container()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 4.w,
                    ),
                    Container(
                      width:90.w,
                      height: 18.h,
                      child: this.item.data['description'].length > 0
                          ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        child: ProductDescriptionText(
                          S.of(context).about,
                          this.item.data['description'],sizeFont: 9,
                        ),
                      )
                          : SizedBox(
                        width: 90.w,
                        height: 18.h,
                      ),
                    )

                  ],),
                SizedBox(height: 8.h),
                Expanded(child: Container()),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 11.w,
                    ),

                    Container(
                      width: 90.w,
                      // height: 18.h,
                      child:
                      item.data['purchasable'] != null && item.data['purchasable']
                          ? item.data['in_stock']
                          ? StyledProductPrice(this.item.data['price'],

                        this.item.data['regular_price'],style: Styles.boldTextStyle.copyWith(
                            fontSize:   Styles.fontSize11
                        ),)
                          : Text(
                        'Out of Stock',
                        style: Styles.boldTextStyle.copyWith(
                            fontSize: Styles.fontSize11
                        ),
                      )

                          : SizedBox( width: 58.w,
                        height: 18.h,),
                    )
                  ],),
                Expanded(child: Container()),

                // SizedBox(height: 34.h)
              ],
            ),
            if(this.withAction)
              Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"?
              Positioned(
                bottom: 10.h,

                right  :12.w ,
                // left: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"? 0.w:21.w,
                child:    item.data['purchasable'] != null &&
                    item.data['purchasable'] &&
                    item.data['in_stock']
                    ? SizedBox(
                  width:24.h ,
                  // height: 28.h,
                  // alignment: Alignment.topRight,
                  child: QuantityToggle(
                    this.item, height:100.h ,
                    width: 47.h,
                    margin: EdgeInsets.all(0),
                    iconSize: 20,
                    raduis: 5,
                    scale: 0.6.r,
                  ),
                )
                    : SizedBox(width:25.w ,
                  height: 28.h,),):
              Positioned(
                bottom: 10.h,

                left:  12.w ,
                // left: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"? 0.w:21.w,
                child:    item.data['purchasable'] != null &&
                    item.data['purchasable'] &&
                    item.data['in_stock']
                    ? SizedBox(
                  width:29.w ,
                  // height: 28.h,
                  // alignment: Alignment.topRight,
                  child: QuantityToggle(
                    this.item, height:100.h ,
                    width: 47.h,
                    margin: EdgeInsets.all(0),
                    iconSize: 24,
                    raduis: 5.r,
                    scale: 0.5,
                  ),
                )
                    : SizedBox(width:29.w ,
                  height: 28.h,),),


            if(this.withAction)
              Consumer<CartManager>(
                  builder: (context, userManager, child) {
                    return
                      Provider
                          .of<LocaleProvider>(context, listen: false)
                          .locale
                          .languageCode != "ar" ?
                      Positioned(
                          top: 10.h,

                          right  :13.w ,
                          child:
                          InkWell(child:
                          SizedBox(
                            width:18.w ,
                            height: 18.w,
                            child:

                            Container(
                                decoration: Styles.roundedDecoration.copyWith(
                                    color: Styles.colorPrimary,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.r),
                                    )),
                                padding: EdgeInsets.symmetric(horizontal: 4.0.h,vertical: 4.5.h),
                                child:

                                SvgPicture.asset(Provider.of<CartManager>(context, listen: false)
                                    .isPresentInWishList(item)?
                                Assets.SVG_likeFilled:Assets.SVG_wishlist, color:  Styles
                                    .ColorWhite,
                                  fit: BoxFit.scaleDown,

                                )),
                            // Icon( Provider.of<CartManager>(context, listen: false)
                            //     .isPresentInWishList(item)?Icons.favorite:Icons.favorite_border, color:Styles.ColorWhite))
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
                          top: 10.h,

                          left  :13.w ,
                          child:   Container(
                              decoration: Styles.roundedDecoration.copyWith(
                                  color: Styles.colorPrimary,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.r),
                                  )),
                              child:  InkWell(child:
                              SizedBox(
                                width:20.w ,
                                height: 20.h,
                                // alignment: Alignment.topRight,
                                child:

                                SvgPicture.asset(Provider.of<CartManager>(context, listen: false)
                                    .isPresentInWishList(item)?
                                Assets.SVG_likeFilled:Assets.SVG_wishlist, color:  Styles
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
