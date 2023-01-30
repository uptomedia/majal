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

class TopProductCard extends StatelessWidget {
  final Product item;

  TopProductCard(this.item);

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
        // width: 196.w,
        height: 139.h,
        decoration: Styles.tilesDecoration.copyWith(
            borderRadius: BorderRadius.all(
          Radius.circular(0.r),
        )),
        child:
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:

        <Widget>[
         SizedBox(width: 11.w,),
          Container(
            width: 9.r,
            height: 9.r,
             child: Icon(Icons.circle,color: Styles.ColorMessageCircle,size: 9.r,),),
          Container(child:Container(
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
              ))),
          Expanded(child: Container(
              padding: EdgeInsets.symmetric(vertical:30.h),
              child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          // width: 150.w,
                          child: Text(
                            item.data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.boldTextStyle
                                .copyWith(fontSize: Styles.fontSize14),
                          )),





                      Container(                  height: 22.h,


                        child: this.item.data['brands'].length > 0
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0),
                  child:

                  Text(
                    this.item.data['brands'][0]['name'],
                  ),
                )
                    : SizedBox(
                  width: 75.w,
                  height: 22.h,
                ),
              ),
                      Container(
                         height: 22.h,
                child: this.item.data['brands'].length > 0
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0),
                  child:

                  Text(
                    // S.of(context).about,
                    this.item.data['date_modified'],
                  ),
                )
                    : SizedBox(
                   height: 22.h,
                ),
              ),

                    ])),
),
          Container(child:  SizedBox
            (
            // height: 21.r,
            // width: 10.r,
            child:

            SvgPicture.asset( Assets.SVGArrow,
              // allowDrawingOutsideViewBox: true,
              // height: 21.r,
              // width: 10.r,
              fit: BoxFit.scaleDown,
            ),)),
SizedBox(width: 29.w,)
        ]),
      ),
    );
  }
}
