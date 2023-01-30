import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/QuantityToggle.dart';
import 'package:grodudes/components/StyledProductPrice.dart';
import 'package:grodudes/helper/ImageFetcher.dart';
import 'package:grodudes/models/Product.dart';
 import 'package:provider/provider.dart';

import '../core/configurations/assets.dart';
import '../core/configurations/styles.dart';
import '../core/utils.dart';
import '../generated/l10n.dart';
import '../l10n/locale_provider.dart';
import '../routing/route_paths.dart';
import '../state/cart_state.dart';
import 'ProductDescriptionText.dart';

class ProductCard extends StatelessWidget {
  final Product item;

  ProductCard(this.item);

  @override
  Widget build(BuildContext context) {
    if (this.item == null || this.item.data['id'] == null) {
      return SizedBox(height: 0);
    }
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
        // Utils.pushNewScreenWithRouteSettings(context,
        //     settings: RouteSettings(name: RoutePaths.ProductDetailsPage),
        //     withNavBar: false,
        //     screen: ProductDetailsPage(
        //       this.item,
        //     ));

        // Navigator.push(
        //   context,
        //   CupertinoPageRoute(
        //       builder: (context) => ProductDetailsPage(
        //             this.item,
        //           )),
        // );
      },
      child: Container(
        width: 196.w,
        height: 239.h,
        decoration: Styles.tilesDecoration.copyWith(
            borderRadius: BorderRadius.all(
          Radius.circular(23.r),
        )),
        child: Stack(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: 134.w,
                  height: 135.h,
                  margin: Provider.of<LocaleProvider>(context, listen: false)
                              .locale
                              .languageCode !=
                          "ar"
                      ? EdgeInsets.only(left: 22.w, right: 68.w, top: 21.h)
                      : EdgeInsets.only(right: 22.w, left: 68.w, top: 21.h),
                  child: Center(
                      child: Container(


                          decoration: Styles.shadowPrimaryDecoration.copyWith(
                              borderRadius: BorderRadius.all(
                            Radius.circular(207.r),

                          ), boxShadow: [  ] ),
                          child: ClipRRect(



                            // color: Colors.black,

                            borderRadius: BorderRadius.circular(200.r),
                            child: item.data['images'].length != 0
                                ? ImageFetcher.getImage(
                                    item.data['images'][0]['src'],fit: BoxFit.scaleDown)
                                : ImageFetcher.getImage(""),
                          )))),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 22.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 150.w,
                          child: Text(
                            item.data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.boldTextStyle
                                .copyWith(fontSize: Styles.fontSize14),
                          )),

                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 14.w,
                  ), Container(
                width: 100.w,
                height: 32.h,
                child: this.item.data['description'].length > 0
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0),
                  child:

                  ProductDescriptionText(
                    S.of(context).about,
                    this.item.data['description'],
                  ),
                )
                    : SizedBox(
                  width: 75.w,
                  height: 22.h,
                ),
              ),]),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 22.w,
                  ),
                  SizedBox(height: 2),
                  item.data['purchasable'] != null && item.data['purchasable']
                      ? item.data['in_stock']
                          ? StyledProductPrice(
                              this.item.data['price'],
                              this.item.data['regular_price'],
                              style: Styles.boldTextStyle
                                  .copyWith(fontSize: Styles.fontSize11),
                            )
                          : Text(
                              'Out of Stock',
                              style: TextStyle(color: Colors.red[600]),
                            )
                      : SizedBox(height: 0),
                  SizedBox(height: 10.h)
                ],
              ),
            ],
          ),

          Provider.of<LocaleProvider>(context, listen: false)
                      .locale
                      .languageCode !=
                  "ar"
              ? Positioned(
                  bottom: 15.h,

                  right: 15.w,
                  // left: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"? 0.w:21.w,
                  child: item.data['purchasable'] != null &&
                          item.data['purchasable'] &&
                          item.data['in_stock']
                      ? SizedBox(
                          width: 25.w,
                          // height: 100.h,
                          // alignment: Alignment.topRight,
                          child: QuantityToggle(
                            this.item,
                            height: 100.h,
                            width: 47.h,
                            margin: EdgeInsets.all(0),
                            iconSize: 24,
                          ),
                        )
                      : SizedBox(height: 0),
                )
              : Positioned(
                  bottom: 15.h,

                  left: 15.w,
                  // left: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"? 0.w:21.w,
                  child: item.data['purchasable'] != null &&
                          item.data['purchasable'] &&
                          item.data['in_stock']
                      ? SizedBox(
                          width: 25.w,
                          // height: 25.h,
                          // alignment: Alignment.topRight,
                          child: QuantityToggle(
                            this.item,
                            height: 100.h,
                            width: 47.h,
                            margin: EdgeInsets.all(0),
                            iconSize: 24,
                          ),
                        )
                      : SizedBox(height: 0),
                ),

          //like
          Consumer<CartManager>(
              builder: (context, userManager, child) {
                return
                  Provider
                      .of<LocaleProvider>(context, listen: false)
                      .locale
                      .languageCode != "ar" ?
                  Positioned(
                      top: 15.h,

                      right: 15.w,
                       child:
                      InkWell(
                          onTap: () {
                            Provider.of<CartManager>(context, listen: false)
                                .isPresentInWishList(item)
                                ? Provider.of<CartManager>(context, listen: false)
                                .removeWishItem(item) : Provider.of<CartManager>(
                                context, listen: false).addWishItem(item);
                          },
                          child:


                        Container(
                          width: 25.w,
                          height: 25.h,
                          padding: EdgeInsets.all(4.0.h),
                          decoration: Styles.roundedDecoration.copyWith(
                              color: Styles.colorPrimary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(7.r),
                              )),
                          child:  InkWell(child:
                          SizedBox(
                              // width: 13.w,
                              // height: 10.w,
 child:
 //     .isPresentInWishList(item)?
 // Icons.favorite:Icons.favorite_border, color:Styles.ColorWhite))
                             SvgPicture.asset(

                                 Provider.of<CartManager>(context, listen: false)
                                     .isPresentInWishList(item)?
                                 Assets.SVG_likeFilled:Assets.SVG_wishlist,
                               fit: BoxFit.fitHeight,
                                 //color:
                            // Provider.of<CartManager>(context, listen: false)
                            //     .isPresentInWishList(item) ? Styles.ColorOrangeLite : Styles
                            //     .ColorWhite
                              // height:149.h ,
                              //   width: 47.h,
                              //   margin: EdgeInsets.all(0),
                              //   iconSize: 24,
                                       )),
                      ),
                      )


                  )
                  ) :

                  Positioned(
                      top: 15.h,

                      left: 15.w,
                      // left: Provider.of<LocaleProvider>(context, listen: false).locale.languageCode!="ar"? 0.w:21.w,
                      child:   Container(
                          padding: EdgeInsets.all(4.0.h),
                          width: 25.w,
                          height: 25.h,
                          decoration: Styles.roundedDecoration.copyWith(
                              color: Styles.colorPrimary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(7.r),
                              )),
                          child:  InkWell(child:
                          SizedBox(
                            width: 13.w,
                            height: 13.w,
                            // alignment: Alignment.topRight,
                            child:
                            // Icon( Provider.of<CartManager>(context, listen: false)
                            //     .isPresentInWishList(item)?Icons.favorite:Icons.favorite_border, color:Styles.ColorWhite)
                            //
                            SvgPicture.asset( Provider.of<CartManager>(context, listen: false)
                                .isPresentInWishList(item)?
                            Assets.SVG_likeFilled:Assets.SVG_wishlist, color:  Styles
                                .ColorWhite,
                              fit: BoxFit.scaleDown,
                              // height:149.h ,
                              //   width: 47.h,
                              //   margin: EdgeInsets.all(0),
                              //   iconSize: 24,
                            ),
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

        ]),
      ),
    );
  }
}
