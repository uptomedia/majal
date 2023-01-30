import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/RootDrawer.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/pages/AllCategoriesPage.dart';
import 'package:grodudes/pages/AllProductsPage.dart';
import 'package:grodudes/pages/CartItems.dart';
import 'package:grodudes/pages/Home.dart';
import 'package:grodudes/pages/SearchResultsPage.dart';
import 'package:grodudes/pages/account/AccountRoot.dart';
import 'package:grodudes/pages/messages_content.dart';
import 'package:grodudes/routing/route_paths.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:provider/provider.dart';

import 'core/configurations/assets.dart';
import 'core/configurations/styles.dart';
import 'core/utils.dart';
import 'generated/l10n.dart';
import 'l10n/locale_provider.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages>{
  var currentPage;

  @override
  initState() {


    super.initState();
  }

  @override
  void dispose() {
     super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackGround,

      body:

Container(
   // height:MediaQuery.of(context).size.height ,
  child:             Column(children: [
  SizedBox(height:MediaQuery.of(context).padding.top,),
    Container(
      height: 46.h,
      // width: 360.w,
      padding: EdgeInsets.symmetric(
          horizontal:16.h,vertical: 16.h),
      // decoration: Styles.textFieldDecoration,

      child:
      Row(
        children: <Widget>[


          // SizedBox(width: 16.w,),
          SizedBox(width: 26.w,
              child:

                  SvgPicture.asset(Assets.SVGDrawerIcon,width: 26.w,)

              ),
          SizedBox(width: 16.w,),
          Expanded(child: Center(child: Text("Pharma logo",style: Styles.boldTextStyle.copyWith(
              color: Styles.colorPrimary,
              fontSize: 15.sp,fontWeight: FontWeight.w700
          ),),)),
          // Center(child:
          // ),
          SizedBox(width: 13.w,),

          SizedBox(
              width: 26.w,
              child:

              Consumer<CartManager>(
                  builder: (context, userManager, child) {
                    return
                      Badge(
                          badgeColor: Styles.colorPrimary,
                          shape: BadgeShape.circle,

                          showBadge:Provider
                              .of<CartManager>(context, listen: false).cartItems.length>0 ,
                          badgeContent: Text( Provider
                              .of<CartManager>(context, listen: false).cartItems.length.toString(),
                              style:Styles.boldTextStyle.copyWith(
                                  color: Styles.colorSecondary,
                                  fontSize: Styles.fontSize10
                              )),

                          child:
                          GestureDetector(
                              onTap:
                                  () =>null,// openSearchPage(this._searchController!.text),
                              child:
                              SvgPicture.asset(Assets.SVG_cart,width: 26.w,)

                          )
                      );    }),

                ),
          // SizedBox(width: 16.w,),

        ],

      ),
    ),
  Expanded(child: MessageContent()),


],)
  ,)

    );
  }
}
