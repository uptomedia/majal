
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/QuantityToggle.dart';
import 'package:grodudes/components/StyledProductPrice.dart';
import 'package:grodudes/core/configurations/assets.dart';
import 'package:grodudes/disturbers.dart';
import 'package:grodudes/helper/ImageFetcher.dart';
import 'package:grodudes/models/Product.dart';
 import 'package:grodudes/state/cart_state.dart';
import 'package:provider/provider.dart';

import '../core/configurations/styles.dart';
import '../core/utils.dart';
import '../generated/l10n.dart';
import '../l10n/locale_provider.dart';
import '../models/disturber.dart';
import '../routing/route_paths.dart';
import '../state/user_state.dart';
import 'ProductDescriptionText.dart';


class DisturberCardCart extends StatefulWidget {
   late final Disturber item;
  late final double width;
  late final double height;
  late bool isSelected;
  DisturberCardCart({required this.item,required this.width,required this.height,
    this.isSelected:true});

  @override
  State<DisturberCardCart> createState() => _DisturberCardCartState();
}

class _DisturberCardCartState extends State<DisturberCardCart> {





  @override
  Widget build(BuildContext context) {

    return
     Container(
        width: widget.width *1 ,
        height: widget.height*1.2,

        margin: EdgeInsets.only(
            top: 0.h,
            bottom: 0.h,
            left: 0,right: 0),
           child:
            Stack(children: [

         Positioned(
             top: widget.height*0.1,
             left:  widget.width*0.0 ,
             bottom: widget.height*0.1,
             right: widget.width*0.05,
             child:

             Container(
                 width: widget.width,
                 height: widget.height,
                 decoration: widget.isSelected? Styles.cartDisturbterDecoration:Styles.cartDisturbterDecoration.copyWith(
                     border: Border.all(
                         width: 1.sp,
                         color:  Styles.colorunSelectedCart),
                  ) ,
                 child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 18.h,),
                  Container(
                    width: 36.r,
                    child:

                        Center(
                            child: Container(
                                height: 36.r,
                                width: 36.r,
                                child:
                                ClipRRect(
                                  // color: Colors.black,
                                  borderRadius: BorderRadius.circular(28.r),
                                  child:
                                  // widget.item.imagePath! ==null
                                  //     ? ImageFetcher.getImage(
                                  //     widget.item.imagePath)
                                  //     :
                                    ImageFetcher.getImage(Assets.AssetsLogo),
                                )
                            )
                        )),
               SizedBox(height:15.h),
               Expanded(child:   Container(
                   // height: 30.h,

                  child:Text(widget.item.name??"",style: Styles.boldTextStyle.copyWith(
fontSize: Styles.fontSize13
                  ) ),))

                   ],))),
              Positioned(
                  top: widget.height *0.05,
                  right: widget.width *0.00 ,

                  child:

                  Container(
                      width: 27.r,
                      height:27.r,
                     decoration: widget.isSelected? Styles.cartDisturbterDecoration.copyWith(

                       border: Border.all(
                       width: 1.sp,
                         color:  Colors.transparent),
                     ):
                     Styles.cartDisturbterDecoration.copyWith(
                       color:Styles.colorunSelectedCart,
                        border: Border.all(
                            width: 1.sp,
                            color:  Styles.colorunSelectedCart),
                      ) ,                      child:

                  Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.transparent,

                      ),
                      child: Checkbox(
                          checkColor: Colors.white,
                          activeColor:Styles.secondary2Color,
shape:  RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6.r)),

                         onChanged: (value){
widget.isSelected=!widget.isSelected;
setState(() {
 });
Provider.of<CartManager>(context, listen: false).filterCartItem(
widget.item,show:widget.isSelected);

                        },

                        value: widget.isSelected,

                      // checkColor: Styles.colorPrimary,
                      //   shape: OutlinedBorder(side: BorderSide.none ),
                       )
                      //   Text("sadasds")

                  )
                  )
              )

            ],)




    );
  }
}
