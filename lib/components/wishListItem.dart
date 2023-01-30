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
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

import '../core/configurations/assets.dart';
import 'package:draggable_widget/draggable_widget.dart';

import '../core/utils.dart';
 import '../routing/route_paths.dart';

class WishListItem extends StatefulWidget {
  final Product item;
  bool deletable;

  WishListItem(this.item, {this.deletable: false});

  @override
  _WishListItemState createState() => _WishListItemState();
}

class _WishListItemState extends State<WishListItem> {
  final dragController = DragController();

bool isdeletable=false;
  @override
  Widget build(BuildContext context) {

    try {
      if (this.widget.item == null || this.widget.item.data['id'] == null) {
        print("nooooo1111");
        return SizedBox(height: 0);
      }

      return
        // Container(child:
      SwipeTo(
          onLeftSwipe: () {
            // if (!widget.deletable) {
              setState(() {
                isdeletable = false;
              });
              print("aada");
            // }
          },
          onRightSwipe: () {
            print("aadarrrrrrrrrrr");
            // if (widget.deletable) {
              setState(() {
                isdeletable = true;
              });
            // }
          },
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              child:
      Container(
                // color: Colors.red,
                width:  isdeletable ?
                487.w : 356.w,
                 margin:  !isdeletable?
                 EdgeInsets.symmetric(horizontal:34.w)
                   :
          EdgeInsets.only(right:  0.w ),
                padding: isdeletable  //EdgeInsets.symmetric(vertical: 8, horizontal: 34.w),
                    ?
                EdgeInsets.symmetric(vertical: 0, horizontal: 0.w)
                    : EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                // color: Colors.white,
                decoration: Styles.itemWishDecoration ,
                child:


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (isdeletable)
                      InkWell(
                        child: Container(
                            height: 203.h,
                            width: 79.w,
                          color: Styles.colorDeleteBackground,

                            child: SizedBox(
                              height: 53.h,
                              width: 47.5.w,
                              child: SvgPicture.asset(
                                Assets.SVG_trash,
                                // allowDrawingOutsideViewBox: true,
                                height: 53.h,
                                width: 47.5.w,
                                fit: BoxFit.scaleDown,
                              ),
                            )),
                        onTap: () {
                          Provider.of<CartManager>(context, listen: false)
                              .removeWishItem(widget.item);
                          isdeletable=false;
                        },
                      ),


                    Container(
                        width: 141.w,
                        height: 141.h,

                        child: ClipRRect(
                            // color: Colors.black,

                            borderRadius: BorderRadius.circular(141),
                            child: Center(
                                child: Container(
                              decoration: Styles.tilesDecoration.copyWith(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(220.r),
                              )),
                              child: widget.item.data['images'].length != 0
                                  ? ImageFetcher.getImage(
                                      widget.item.data['images'][0]['src'])
                                  : ImageFetcher.getImage(""),
                            )))),
                     SizedBox(
                      width: 42.w,
                    ),
                    InkWell(
                      onTap: (){
                        WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();



                      },
                      child:

                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 29.h,
                          ),
                          Container(
                            width: 150.w,
                            child: Text(
                              widget.item.data['name'] ?? "",
                              maxLines: 1,
                              style: Styles.boldTextStyle
                                  .copyWith(fontSize: Styles.fontSize21),
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                              width: 150.w,
                              child: Text(
                                widget.item.data['categories'][0]["name"] ?? "",
                                maxLines: 1,
                                style: Styles.regularTextStyle.copyWith(
                                    fontSize: Styles.fontSize16,
                                    color: Styles.colorFontTitle),
                                overflow: TextOverflow.clip,
                              )),
                          SizedBox(
                            height: 5.h,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //     // width: 150.w,
                              //     child: Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 0),
                              //         child: Text(
                              //           S.of(context).price,
                              //           style: Styles.boldTextStyle.copyWith(
                              //               fontSize: Styles.fontSize19),
                              //         ))),

                              Container(
                                  // width: 150.w,
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                child: StyledProductPrice(
                                  this.widget.item.data['price'] ?? 0,
                                  this.widget.item.data['regular_price'] ?? 0,
                                  style: Styles.boldTextStyle.copyWith(
                                      fontSize: Styles.fontSize19,
                                      ),
                                ),
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Container(

                            // width: 162,
                            child: Text(
                              S.of(context).clickToSeeFullDetails,style: Styles.lightTextStyle.copyWith(
                                color: Styles.colorFontTitle,
                                fontSize: Styles.fontSize12
                            ),
                            ),
                          ),

                          SizedBox(
                            height: 28.h,
                          )

                         ]),
                    )
                  ],
                ),
                    // IconButton(icon: Icon(Icons.close), onPressed: () {})

      )  ),
      );
    } catch (ex) {
      print(ex);

      return SizedBox(
        height: 25,
      );
    }
  }
}
