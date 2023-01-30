import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:provider/provider.dart';

import '../core/configurations/styles.dart';

class QuantityToggle extends StatelessWidget {
  final Product item;
  final EdgeInsetsGeometry margin;
  final double iconSize;
  final double height;
  final double width;
  final double raduis;
  final double scale;
  QuantityToggle(this.item,
      {this.margin = const EdgeInsets.symmetric(horizontal: 4),
        required this.height,required this.width,this.raduis:12,this.scale:0.6,
      this.iconSize = 26});
  @override
  Widget build(BuildContext context) {
    if (this.item == null || this.item.data['id'] == null) {
      return SizedBox(height: 0);
    }
    return Consumer<CartManager>(
      builder: (context, cart, child) {
        // if (cart.isPresentInCart(item)) {
          return
            Container(
                // decoration: Styles.roundedDecoration.copyWith(
                //     color: Styles.colorPrimary,
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(this.raduis),
                //     )),
                child: Container(
                  // width: width ,
                  height: height,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      SizedBox(
                          // width: (height*80/150).h ,
                          // height:  (height*20/150).h,
                          child:

                    Container(
                    width:  20.r  ,
                    height: 20.r ,
                    decoration: new BoxDecoration(
                      color: Styles.colorRemoveIcon,
                      shape: BoxShape.circle,
                    ),
                          child:
                          InkWell(
                              child: Center(
                                  child: Icon(
                                    Icons.remove,
                                    size: 20.r,
                                    color: Styles.ColorWhite,
                                    // size:  (height*40/150).h,
                                  )),
                              onTap: () {
                                Provider.of<CartManager>(context, listen: false)
                                    .decrementQuantityOfProduct(item);
                              }
                          ),)) ,
                      SizedBox(width: 8.w,),
                       Expanded(child:
                      Container(

                        // width: width,
                       height: height  ,
                      decoration: Styles.speicialOfferDecoration,
                           child: Center(
                            child: Text(
                              "${this.item.quantity}",
                              style: Styles.boldTextStyle.copyWith(
                                  fontSize: Styles.fontSize11,
                                  fontWeight: FontWeight.w700,
                                  color: Styles.ColorText),
                            ),
                          ))),
                      SizedBox(width: 8.w,),
                       SizedBox(

                          width:  20.r  ,
                          height: 20.r ,
                          child: Container(
                      width:  20.r  ,
        height: 20.r ,

        decoration: new BoxDecoration(
        color: Styles.colorPrimary,
        shape: BoxShape.circle,
        ),
        child: InkWell(
                              child: Center(
                                  child: Icon(
                                    Icons.add_outlined,
                                    color: Colors.white,
                                    size: 20.r,
                                    // size:  (height*40/150).h,

                                  ),),
                              onTap: () {
                                Provider.of<CartManager>(context, listen: false)
                                    .incrementQuantityOfProduct(item);
                              }
                          )) ),
                      SizedBox(width: 8.w,),
                     ],
                  ),
                ));





       },
    );
  }
}
