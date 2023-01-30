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

class ProductCardAumet extends StatelessWidget {
  final Product item;

  ProductCardAumet(this.item);

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
        // width: 250.w,
        height: 177.h,
        // margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: EdgeInsets.all(12.h),
        decoration: Styles.speicialOfferDecoration.copyWith(
            borderRadius: BorderRadius.all(
              Radius.circular(0.r),
            )),
        child:
            Row(children: [
              Container(width: 95.w,
              child:
                Column(children: [
                  Container(
                      width: 71.w,
                      height: 62.h,
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
                                    Radius.circular(0.r),
                                  ),
                                  boxShadow: [  ]),


                              child:

                              ClipRRect(
                                // color: Colors.black,

                                borderRadius: BorderRadius.circular(0.r),
                                child: item.data['images'].length != 0
                                    ? ImageFetcher.getImage(
                                    item.data['images'][0]['src'])
                                    : ImageFetcher.getImage(""),
                              )
                          )
                      )),
                SizedBox(height: 44.h,),
                Text(
                  'Bounses',
                  style: Styles.boldTextStyle.copyWith(
                      fontSize: Styles.fontSize11,

                      color: Styles.ColorText,
                      fontWeight: FontWeight.w400
                  ),)

                ],),
              ),
Expanded(child:
              Column(
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
                          Container(
                              // width: 300.w,
                              child:

                              this.item.data['tags'].length > 0?

                              Text(

                                getTagName(),
                                maxLines: 1,

                                overflow: TextOverflow.ellipsis,
                                style: Styles.boldTextStyle
                                    .copyWith(fontSize: Styles.fontSize11,


                                     color: Styles.ColorText,
                                 ),
                              ):
                              Text(" ",
                                maxLines: 1,

                                overflow: TextOverflow.ellipsis,
                                style: Styles.boldTextStyle
                                    .copyWith(fontSize: Styles.fontSize11,


                                     color: Styles.ColorText,
                                 ),
                              )
                          ),






                   SizedBox(height: 6.h,),

                  SizedBox(
                      height: 13.h,
                      child:
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
                          : SizedBox(width: 124.w,
                        height: 44.h,)),
SizedBox(height: 6.h,),
                  SizedBox(

                    // width: 200.w,
                    height: 13.h,
                    child: this.item.data["total_sales"]!= null
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: Text(
                        this.item.data['total_sales'].toString()+" Recently Orderd",
                          style:Styles.boldTextStyle.copyWith(

                        fontSize: 11.sp,
                      fontWeight: FontWeight.w700)


                    ))
                        : SizedBox(
                       height: 13.h,
                    ),
                  ),
                  SizedBox(height: 6.h,),

                  SizedBox(

                    width: 60.w,
                    height: 25.h,
                    child:

                    Container(
                      decoration:Styles.salePriceDecoration,
                        child:
                            Center(child:
                    this.item.data["on_sale"]!= null &&
                        this.item.data["on_sale"]== true
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: Text( "JOD "+
                        this.item.data["sale_price"].toString() ,
                      style:  Styles.boldTextStyle.copyWith(
                            fontSize: Styles.fontSize11,
                            fontWeight: FontWeight.w700,
                            color: Styles.ColorText),


                    ))
                        : SizedBox(
                       height: 13.h,
                    ),
                  ),),),


SizedBox(height:5.h),
                  item.data['purchasable'] != null &&
                        item.data['purchasable'] &&
                        item.data['in_stock']
                        ? SizedBox(
                      // width: 47.w,
                      height: 30.h,
                      // alignment: Alignment.topRight,
                      child: QuantityToggle(
                        this.item,
                        height: 47.h,
                        width: 230.w,
                        margin: EdgeInsets.all(0),
                        iconSize: 24,
                      ),
                    )
                        : SizedBox(height: 0),
                ],
              ),
)
            ],)


      ),
    );
  }
  String getBrandName(){
    String result="";
    for(int i=0;i<this.item.data['attributes'].length;i++){
      result=result+item.data['attributes'][i]["options"][0];
    }

    return result;
  }
  String getTagName(){
    String result="";
    for(int i=0;i<this.item.data['tags'].length;i++){
      result=result+item.data['tags'][i]["name"]+" ";
    }

    return result;
  }
}
