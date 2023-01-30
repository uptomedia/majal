import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../configurations/styles.dart';



class MajalAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? tail;
  final Function? onPressed;
  final bool withBack;
  final BoxDecoration? boxDecoration;
  final TextStyle? textStyle;
  final bool isProfile;

  MajalAppBar({
    this.title = "",
    this.onPressed,
    this.tail,
    this.withBack = true,
    this.boxDecoration,
    this.textStyle,
    this.isProfile:false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CommonSizes.appBarHeight,
      decoration:boxDecoration?? BoxDecoration(
        color: Styles.colorBackGround,
        // boxShadow: [
        //   BoxShadow(color: Styles.shadowColor, blurRadius: 4, spreadRadius: -2)
        // ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:
         0.h,vertical: 0.w
        ),
        child:
        // isProfile?
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     InkWell(
        //       onTap: () => this.withBack ? (this.onPressed ?? Navigator.of(context).pop()) : {},
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.end,
        //         children: [
        //          SizedBox(width: 34.5.w,child:  Icon(
        //             Icons.arrow_back,
        //             color: this.withBack ? Styles.colorSecondary2 : Colors.transparent,
        //             size: 55.r,
        //           ),),
        //            SizedBox(width:76.5.w),
        //         Container(
        //             // width: 132.w,
        //              child:    Text(
        //             this.title ?? "    ",
        //             textAlign: TextAlign.center,
        //             style: this.textStyle??TextStyle(
        //               fontFamily: Styles.FontFamily,
        //               color: Styles.colorSecondary2,
        //               // fontSize: Styles.fontSize3,
        //               fontWeight: FontWeight.w700,
        //
        //           ),))
        //         ],
        //       ),
        //       splashColor: Colors.transparent,
        //       highlightColor: Colors.transparent,
        //     ),
        //     if ((tail != null && (tail?.length ?? 0) > 0))
        //       Row(
        //         children: [
        //           if (tail != null && (tail?.length ?? 0) > 0) ...tail!,
        //           // if (withSearch)
        //           //   InkWell(
        //           //     onTap: () {
        //           //       pushNewScreenWithRouteSettings(
        //           //         context,
        //           //         screen: SearchScreen(),
        //           //         settings: RouteSettings(
        //           //           name: SearchScreen.routeName,
        //           //         ),
        //           //       );
        //           //     },
        //           //     child: Hero(
        //           //       tag: SEARCH_HERO,
        //           //       child: Icon(
        //           //         Icons.search,
        //           //         color: CoreStyle.mozzaikBlackTextColor,
        //           //         size: ScreenUtil().setHeight(65),
        //           //       ),
        //           //     ),
        //           //   ),
        //         ],
        //       ),
        //   ],
        // ):
        Row(

          children: [
            // InkWell(
            //   onTap: () => this.withBack ? (this.onPressed ??
            //       Navigator.of(context).pop()) : {},
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //      SizedBox(width: 34.5.w,child:  Icon(
            //         Icons.arrow_back,
            //         color: this.withBack ? Styles.colorSecondary2 : Colors.transparent,
            //         size: 55.r,
            //       ),),
            //        SizedBox(width:76.5.w),
            //     Container(
            //         // width: 132.w,
            //          child:    Text(
            //         this.title ?? "    ",
            //         textAlign: TextAlign.center,
            //         style: this.textStyle??TextStyle(
            //           fontFamily: Styles.FontFamily,
            //           color: Styles.colorSecondary2,
            //           // fontSize: Styles.fontSize3,
            //           fontWeight: FontWeight.w700,
            //
            //       ),))
            //     ],
            //   ),
            //   splashColor: Colors.transparent,
            //   highlightColor: Colors.transparent,
            // ),
            if ((tail != null && (tail?.length ?? 0) > 0))
              Row(
                children: [
                  if (tail != null && (tail?.length ?? 0) > 0) ...tail!,
                  // if (withSearch)
                  //   InkWell(
                  //     onTap: () {
                  //       pushNewScreenWithRouteSettings(
                  //         context,
                  //         screen: SearchScreen(),
                  //         settings: RouteSettings(
                  //           name: SearchScreen.routeName,
                  //         ),
                  //       );
                  //     },
                  //     child: Hero(
                  //       tag: SEARCH_HERO,
                  //       child: Icon(
                  //         Icons.search,
                  //         color: CoreStyle.mozzaikBlackTextColor,
                  //         size: ScreenUtil().setHeight(65),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
