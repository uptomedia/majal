import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/StyledProductPrice.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/ImageFetcher.dart';
import 'package:grodudes/l10n/locale_provider.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

import '../core/configurations/assets.dart';

class CartListItem extends StatefulWidget {
  final Product item;
  bool deletable;

  CartListItem(this.item, {this.deletable: false});

  @override
  _CartListItemState createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  String getTotalPrice() {
    return (double.parse(widget.item.data['price']) * widget.item.quantity)
        .toStringAsFixed(2)??"0";
  }
  bool isdeletable=false;
  @override
  Widget build(BuildContext context) {
    bool isRTL=Provider.of<LocaleProvider>(context, listen: false).locale.languageCode=="ar";

    try {
      if (this.widget.item == null || this.widget.item.data['id'] == null) {
         return SizedBox(height: 0);
      }
      print(widget.item.data['images'][0]['src']);

      return
              Container(
height: 183.h,
                 padding: EdgeInsets.symmetric(horizontal: 12.w),
                 // color: Colors.white,
                decoration:  Styles.cartDisturbterDecoration.copyWith(
                   border: Border.all(
                      width: 1.sp,
                      color:  Styles.colorunSelectedCart),
                    borderRadius: BorderRadius.all(
                Radius.circular(12.r)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // if (isdeletable)
                    //   InkWell(
                    //     child: Container(
                    //         height: 203.h,
                    //         width: 79.w,
                    //         color: Styles.colorDeleteBackground,
                    //         child: SizedBox(
                    //           height: 53.h,
                    //           width: 47.5.w,
                    //           child: SvgPicture.asset(
                    //             Assets.SVG_trash,
                    //             // allowDrawingOutsideViewBox: true,
                    //             height: 53.h,
                    //             width: 47.5.w,
                    //             fit: BoxFit.scaleDown,
                    //           ),
                    //         )),
                    //     onTap: () {
                    //       Provider.of<CartManager>(context, listen: false)
                    //           .removeCartItem(widget.item);
                    //     },
                    //   ),
                    SizedBox(width: 24.w,),
                    Container(
                         width: 79.w,
                        height: 79.w,
                        child: ClipRRect(
                            // color: Colors.black,

                            borderRadius: BorderRadius.circular(0.r),
                            child: Center(
                                child: Container(
                              decoration: Styles.tilesDecoration.copyWith(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(141.r),
                              )),
                              child: widget.item.data['images'].length != 0
                                  ? ImageFetcher.getImage(
                                      widget.item.data['images'][0]['src'])
                                  : ImageFetcher.getImage(""),
                            )))),
                    SizedBox(
                      width: 13.w,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 13.h,
                          ),
                          Container(
                            // width: 150.w,
                            child: Text(
                              widget.item.data['name'] ?? "",
                              maxLines: 1,
                              style: Styles.boldTextStyle
                                  .copyWith(
                                  fontWeight: FontWeight.w500,

                                  fontSize: Styles.fontSize15),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: 11.h,
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  // width: 150.w,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      child: Text(
                                        S.of(context).price +" ",
                                        style: Styles.boldTextStyle.copyWith(
                                          fontSize: Styles.fontSize13,
                                            color: Styles.FontColorBlackDark,

                                            fontWeight: FontWeight.w300),
                                      ))),


                                Container(
                                  // width: 150.w,
                                    child: Padding(
                                        padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                        child:
                                        Text(
    this.widget.item.data['price'] ?? 0,
                                          style: Styles.boldTextStyle.copyWith(
                                              fontSize: Styles.fontSize13,
                                              color: Styles.FontColorBlackDark,
                                              fontWeight: FontWeight.w500),
                                        )
                                    )
                                ),



                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  // width: 150.w,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      child: Text(
                                        S.of(context).date+" ",
                                        style: Styles.boldTextStyle.copyWith(
                                          fontSize: Styles.fontSize13,
                                            color: Styles.FontColorBlackDark,

                                            fontWeight: FontWeight.w300),
                                      ))),

                              Container(
                                  // width: 150.w,
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                child:
    Text(getDate(
    this.widget.item.data['date_modified'])  ,
    style: Styles.boldTextStyle.copyWith(
    fontSize: Styles.fontSize13,
        color: Styles.FontColorBlackDark,

        fontWeight: FontWeight.w500),
    ))),



                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // width: 150.w,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      child: Text(
                                        S.of(context).total+" ",
                                        style: Styles.boldTextStyle.copyWith(
                                            fontSize: Styles.fontSize13,
                                            fontWeight: FontWeight.w300),
                                      ))),

                              Container(
                                // width: 150.w,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                    child: StyledProductPrice(
                                    getTotalPrice(),
                                      getTotalPrice() ,
                                      style: Styles.boldTextStyle.copyWith(
                                          fontSize: Styles.fontSize13,
                                          fontWeight: FontWeight.w500,
                                          // color: Styles.colorPrimary
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 18.h,
                          ),

Container(
  width: 240.w,

  child:
                          Row(mainAxisAlignment:MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  SizedBox(width: 15.w,),


                          Container(
                              width: 120.w,
                              height: 28.h,
                              decoration: Styles.outLineDecoration.copyWith(
                                  border: Border.all(
                                      width: 1.sp,
                                      color: Styles.secondary2Color),
                                   borderRadius: BorderRadius.all(
                                    Radius.circular(33.r),
                                  )),
                              child: Container(

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(width: 10.w,),
                                    Container(
                                      decoration:BoxDecoration(


                                        shape: BoxShape.circle,
                                        color: Styles.ColordecreaseToggleOrder,
                                        // borderRadius: BorderRadius.all(
                                        //   Radius.circular(6.r),
                                        // ),
                                        border: Border.all(
                                            width: 1.sp,
                                            color: Styles.ColordecreaseToggleOrder),


                                      ),
                                        width: 18.w,
                                        height: 18.w,
                                        child: InkWell(
                                            child: Center(
                                                child: Icon(
                                              Icons.remove,
                                              color: Styles.ColorWhite,
                                                  size: 18.h,

                                                )),
                                            onTap: () {
                                              Provider.of<CartManager>(context,
                                                      listen: false)
                                                  .decrementQuantityOfProduct(
                                                      widget.item);
                                            })),
                                    Expanded(child: Container()),
                                    Expanded(
                                        child: Center(
                                      child: Text(
                                        "${this.widget.item.quantity}",
                                        style: Styles.boldTextStyle.copyWith(
                                            fontSize: Styles.fontSize17,
                                            color: Styles.ColordecreaseToggleOrder),
                                      ),
                                    )),
                                    Expanded(child: Container()),
                                    Container(
                                        decoration:BoxDecoration(


                                          shape: BoxShape.circle,
                                          color: Styles.secondary2Color,
                                          // borderRadius: BorderRadius.all(
                                          //   Radius.circular(6.r),
                                          // ),
                                          border: Border.all(
                                              width: 1.sp,
                                              color: Styles.secondary2Color),
                                          // boxShadow: [ BoxShadow(
                                          //   color:  Styles.shadowColor.withOpacity(0.08),
                                          //    blurRadius: 6,
                                          //    offset: Offset(3, 3), // changes position of shadow
                                          // )],
                                          // gradient: LinearGradient(
                                          //     colors: [
                                          //       Styles.Colorstart.withOpacity(1),
                                          //       Styles.ColorEnd.withOpacity(0.9)
                                          //     ])
                                        ),

                                        width: 18.w,
                                        height: 18.w,
                                        child: Center(
                                        child: InkWell(

                                                child: Icon(
                                              Icons.add_outlined,
                                              color: Colors.white,
                                               size: 18.h,
                                            ),
                                            // iconSize: 20.h,
                                            onTap: () {
                                              Provider.of<CartManager>(context,
                                                      listen: false)
                                                  .incrementQuantityOfProduct(
                                                      widget.item);
                                            }))),
                                    SizedBox(width: 10.w,),
                                  ],
                                ),
                              )),
Expanded(child: Container()),                           Container(
                            width: 56.w,
                              height: 28.h,
                              decoration: Styles.outLineDecoration.copyWith(
                                color: Styles.secondary2Color,
                                  border: Border.all(
                                      width: 1.sp,
                                      color: Styles.secondary2Color),
                                   borderRadius: BorderRadius.all(
                                    Radius.circular(33.r),
                                  )),
                              child:

  Center(
                                      child: Text(
                                        S.of(context).update,
                                        style: Styles.boldTextStyle.copyWith(
                                            fontSize: Styles.fontSize10,
                                            fontWeight: FontWeight.w500,
                                            color: Styles.ColorWhite),
                                        textAlign: TextAlign.center,

                                     ),



                              )),

  ],)
  ,)
                         ]),
                  ],
                ),

                );
    } catch (ex) {
      print(ex);

      return SizedBox(
        height: 25,
      );
    }
  }
  String getDate(String s){
    String res="";

try {
  DateTime? tempDate = new DateFormat("yyyy-MM-ddThh:mm:ss").parse(s);

  if (tempDate == null) {
    return "";
  }
 res= tempDate.day.toString() + "-" + tempDate.month.toString() + "-" +
      tempDate.year.toString() + " ";
}
catch(  e){
    return "";

    }
    return res;
  }

}
