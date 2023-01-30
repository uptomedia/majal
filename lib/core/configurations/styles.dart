import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

class Styles {
  /// App Settings
  static Color get colorPrimary => Color(0xFF1D8F78);

  static Color get colorSecondary3 => Color(0xFF484D4D);

  static Color get colorSecondary2 => Color(0xFF474C4E);

  static Color get colorSecondary => Color(0xFF121212);

  static Color get colorBackGround => Color(0xFFF9F9F9);

  static Color get secondaryColor => Color(0xFF6AAF9C);
  static Color get secondary2Color => Color(0xFF96C43D);
  static Color get colorFontTitle => Color(0xFF292929);
  static Color get colorUnselectTabFontTitle => Color(0xFF303030);
  static Color get colorDeleteBackground => Color(0xFFE43030);
  static Color get colorFontColorDark => Color(0xFF1E1E1E);
  static Color get colorRemoveIcon => Color(0xFF121212);
  static Color get colorunSelectedCart => Color(0xFFB4B4B4);

  //font

  static double get fontSize33 => 33.0.sp; //30
  static double get fontSize17 => 17.0.sp; //30
  static double get fontSize16 => 16.0.sp; //30
  static double get fontSize29 => 29.0.sp; //30
  static double get fontSize27 => 27.0.sp; //30
  static double get fontSize22 => 22.0.sp; //30
  static double get fontSize24 => 24.0.sp; //30
  static double get fontSize25 => 25.0.sp; //30
  static double get fontSize18 => 18.0.sp; //30
  static double get fontSize19 => 19.0.sp; //30
  static double get fontSize21 => 21.0.sp; //30
  static double get fontSize20 => 20.0.sp; //30
  static double get fontSize13 => 13.0.sp; //30
  static double get fontSize14 => 14.0.sp; //30
  static double get fontSize28 => 28.0.sp; //30
  static double get fontSize30 => 30.0.sp; //30
  static double get fontSize32 => 32.0.sp; //30
  static double get fontSize31 => 31.0.sp; //30
  static double get fontSize15 => 15.0.sp; //30
  static double get fontSize12 => 12.0.sp; //30
  static double get fontSize10 => 10.0.sp; //30





  static Color get colorTertiary => Color(0xFFFFFFFF);

  static double get fontSize6 => 30.0.sp;
  static double fontSize11 = 11.0.sp;

//10
  /// font
  static const FontFamily = 'Roboto';
  static const FontFamilyBlack = 'Roboto';
  static const FontFamilyRegular = 'Roboto';
  static const FontFamilyBold = 'Roboto';
  static const FontFamilySemiBold = 'Roboto';
  static const FontFamilyLight = 'Roboto';
  static const FontFamilyRobotoMedium = 'Roboto';

  static const FontColorWhite = Color(0xFFFFFFFF);
  static const FontColorGray = Color(0xFFBCBCBC);
  static const FontColorDarkGray = Color(0xFF8D9595);
  static const FontColorLiteGray = Color(0xFFE8E8E8);
  static const FontColorLiteGraycallendar = Color(0xFFCBCFD3);
  static const FontColorDarkGray1 = Color(0xFF9A9A9A);
  static const FontColorLiteGray2 = Color.fromRGBO(198, 198, 198, 1.0);

  static const FontColorLiteGrayClendar = Color.fromRGBO(222, 222, 222, 1);
  static const ColorLogout = Color(0xFFE85A5A);
  static const ColorStatusOrder = Color(0xff1D8F78);
//Color(0xFFDEDEDE);
  static const FontColorLiteGray3 = Color(0xFFF3F3F3);
  static const OccpanyColorFree = Color(0xFFA0A0A0);

  static const FontColorBlack = Color(0xFF494949);
  static const ColorYellow = Color(0xFFFFDFA0);
  static const ColorDarkYellow = Color(0xFFC0C48A);
  static const FontColorNiagara = Color(0xFF0FB0A2);
  static const FontColorOrange = Color(0xFFE8833B);
  static const FontColorOrangeLite = Color(0xFFFFA337);
  static const FontColorYellow = Color(0xFFEAC170);
  static const FontColorBlueTurquoise = Color(0xFF13A7C8);
  static const FontColorLiteBlack = Color(0xFF707070);
  static const FontColorLiteBlack2 = Color(0xFF474C4E);
  static const FontColorLiteBlack3 = Color(0xFF636363);
  static const FontColorBlackDark = Color(0xFF000000);

  static const DividerColorLiteBlack = Color(0xFF0990AD);
  static const shadowColor  = Color(0xFF000000);
  static const shadowPrimaryColor  = Color(0xFF24D8A1);
  static const loginFontColor  = Color(0xFF242424);
  static const loginTextFontColor  = Color(0xFF96C43D);

  // static TextStyle get fontStyle => FontFamily;
  // static get mediumFontStyle => fontStyle.copyWith(
  //     fontFamily: "Poppins",
  //     fontWeight: FontWeight.w500);
  // static get semiBoldFontStyle =>
  //     fontStyle.copyWith(
  //         fontFamily: "Poppins",
  //         fontWeight: FontWeight.w600);

  // static TextStyle formInputTextStyle = fontStyle.copyWith(
  //
  //     fontWeight: FontWeight.w200, fontFamily: Styles.FontFamily);


  static TextStyle boldTextStyle = TextStyle(
      fontSize: fontSize33,
      fontWeight: FontWeight.w700,
      fontFamily: Styles.FontFamilyBold,
      color: colorFontTitle);
   static TextStyle regularTextStyle = TextStyle(
      fontSize: fontSize17,
      fontWeight: FontWeight.w400,
      fontFamily: Styles.FontFamilyRegular,
      color: colorFontTitle);
   static TextStyle meduimTextStyle = TextStyle(
      fontSize: fontSize22,
      fontWeight: FontWeight.w500,
      fontFamily: Styles.FontFamilyRobotoMedium,
      color: colorFontTitle);
   static TextStyle lightTextStyle = TextStyle(
      fontSize: fontSize18,
      fontWeight: FontWeight.w300,
      fontFamily: Styles.FontFamilyLight,
      color: colorFontTitle);

  static InputDecoration formInputDecoration = InputDecoration(
      border: InputBorder.none, filled: true, fillColor: Colors.white);
  static AppBar pharmaAppBar = AppBar(
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    backgroundColor: Styles.colorBackGround,
  );

  static InputDecoration borderlessRoundedFieldDecoration(
          {double radius = 40}) =>
      formInputDecoration.copyWith(
          border: InputBorder.none,
          focusedBorder: roundedTransparentBorder(radius: radius),
          enabledBorder: roundedTransparentBorder(radius: radius),
          errorBorder: roundedTransparentBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedTransparentBorder(radius: radius),
          contentPadding: EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white);

  static InputDecoration borderedRoundedFieldDecoration({double radius = 40}) =>
      formInputDecoration.copyWith(

          border: roundedOutlineInputBorder(radius: radius),
          focusedBorder: roundedOutlineInputBorder(radius: radius),
          enabledBorder: roundedOutlineInputBorder(radius: radius),
          errorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedOutlineInputBorder(radius: radius),
          contentPadding: EdgeInsets.all(10),
          filled: true,
          fillColor: Colors.white);
  static InputDecoration PharmaFieldDecoration({double radius = 40,String hint="",Color color=ColorWhite}) =>
      formInputDecoration.copyWith(
        hintText: hint,

          hintStyle: lightTextStyle.copyWith(fontSize: fontSize18),
          border: roundedTransparentBorder(radius: radius),

          focusedBorder: roundedOutlineInputBorder(radius: radius),
          enabledBorder: roundedTransparentBorder(radius: radius),
          errorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedOutlineInputBorder(radius: radius),
          contentPadding: EdgeInsets.symmetric(horizontal: 34.w,vertical: 17.h),
          filled: true,
          fillColor: color);
  static InputDecoration LoginFieldDecoration({double radius = 40,String hint="",
    Color color=ColorWhite}) =>
      formInputDecoration.copyWith(
        hintText: hint,

          hintStyle: lightTextStyle.copyWith(fontSize: fontSize18),
          border: roundedTransparentBorder(radius: radius).
          copyWith(borderSide: BorderSide(color:color)),

          focusedBorder: roundedTransparentBorder(radius: radius).
          copyWith(borderSide: BorderSide(color:color)),
          enabledBorder: roundedTransparentBorder(radius: radius).
          copyWith(borderSide: BorderSide(color:color)),
          errorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedOutlineInputBorder(radius: radius),
          contentPadding: EdgeInsets.symmetric(horizontal: 34.w,vertical: 17.h),
          filled: true,
          fillColor: color);



  static InputDecoration PharmaFieldSearchDecoration({double radius = 40,
    String hint="",Color color=ColorWhite}) =>
      formInputDecoration.copyWith(
          hintText: hint,


          hintStyle: lightTextStyle.copyWith(fontSize: fontSize18),
          border: roundedTransparentBorder(radius: radius),

          focusedBorder: roundedOutlineInputBorder(radius: radius,
            // color:Colors.black
          ),
          enabledBorder: roundedOutlineInputBorder(radius: radius),
          errorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedOutlineInputBorder(radius: radius),
          contentPadding: EdgeInsets.symmetric(horizontal: 34.w,vertical: 17.h),
          filled: true,
          // fillColor: color
      );
  static InputDecoration PharmaCouponFieldDecoration({double radius = 40,String hint="",}) =>
      formInputDecoration.copyWith(
        hintText: hint,
          hintStyle: regularTextStyle.copyWith(fontSize: fontSize18,color: colorPrimary),
          border: roundedOutlineInputBorder(radius: radius),

          focusedBorder: roundedOutlineInputBorder(radius: radius),
          enabledBorder: roundedOutlineInputBorder(radius: radius),
          errorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: roundedOutlineInputBorder(radius: radius)
              .copyWith(borderSide: BorderSide(color: Colors.red)),
          disabledBorder: roundedOutlineInputBorder(radius: radius),
          contentPadding: EdgeInsets.symmetric(horizontal: 34.w,vertical: 17.h),
          filled: true,
           fillColor: Colors.white);

  static InputBorder roundedTransparentBorder({double radius = 40}) =>
      OutlineInputBorder(
        // borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(radius),
      );

  static InputBorder roundedOutlineInputBorder({double radius = 40}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          // color: Styles.colorPrimary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(radius),
      );

  ///
  ///
  /// Colors

  static const ColorGray = Color(0xFFCBCFD3);

  static const ColorBlack = Color(0xFF424243);
  static const ColorText  = Color(0xFF121212);
  static const ColorWhite = Color(0xFFFFFFFF);
  static const ColordecreaseToggleOrder = Color(0xFFD9D9D9);
  static const ColorLiteWhiteBackground = Color(0xFFF6F6F6);
  static const ColorWhiteBackground = Color(0xFFFFFFFF);
  static const ColorLiteGray = Color(0xFFECECEC);
  static const ColorLiteGray1 =
      Color.fromRGBO(245, 245, 245, 1); //Color(0xF5F5FFFF);
  static const ColorLiteGray2 = Color(0xFFE9E9E9); //timeline background
  static const ColorLiteGray3 = Color(0xFFF5F5F5); // background
  static const ColorLiteBlack = Color(0xFF707070);
  static const ColorLiteGray4 = Color(0xFFDEDEDE);
  static const ColorLiteGray6 = Color(0xFFE7E7E7); //header
  static const ColorGray5 = Color(0xFF565656);
  static const ColorGrayPayementStatus = Color(0xFF696969);

  static const ColorBlueTurquoiseLite = Color(0xFF10B6C0);
  static const ColorOrangeLite = Color(0xFFFFA337);
  static const ColorMenuDivider = Color.fromRGBO(83, 191, 215, 0.19);
  static const ColorBorderImage = Color(0xFF53BFD7);
  static const ColorBorderSpecialOffer = Color(0xFF000000);
  static const ColorMessageCircle = Color(0xFFF53F3F);


  ///gradient color
  static const Colorstart = Color(0xFFDEDEDE);
  static const ColorEnd = Color(0xFFE7E7E7);

  ///
  /// Bottom navigation
  static TextStyle bottomNavigationStyle = TextStyle(color: colorPrimary);
  static Color bottomNavigationSelectedIconColor = colorPrimary;
  static const BottomNavigationUnselectedIconColor = ColorGray;



  static BoxDecoration tilesDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(23.r),
      ),
      boxShadow: [ BoxShadow(
        color:  Styles.shadowColor.withOpacity(0.08),
         blurRadius: 6,
         offset: Offset(3, 3), // changes position of shadow
      )],
      color: Colors.white
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
  static BoxDecoration speicialOfferDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(0.r),


      ),
      border: Border.all(
          width: 1.sp,
          color: ColorBorderSpecialOffer),
      // boxShadow: [ BoxShadow(
      //   color:  Styles.shadowColor.withOpacity(0.08),
      //    blurRadius: 6,
      //    offset: Offset(3, 3), // changes position of shadow
      // )],
      // color: Colors.white
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
  static BoxDecoration cartDisturbterDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(6.r),


      ),
      border: Border.all(
          width: 1.sp,
          color: secondary2Color),
      // boxShadow: [ BoxShadow(
      //   color:  Styles.shadowColor.withOpacity(0.08),
      //    blurRadius: 6,
      //    offset: Offset(3, 3), // changes position of shadow
      // )],
      color: Colors.white
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
  static BoxDecoration outLineDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(6.r),



      ),
      border: Border.all(
          width: 1.sp,
          color: colorPrimary),
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
      );
  static BoxDecoration circleDecoration = BoxDecoration(


        shape: BoxShape.circle,
 color: colorPrimary,
      borderRadius: BorderRadius.all(
        Radius.circular(6.r),
      ),
      border: Border.all(
          width: 1.sp,
          color: colorPrimary),
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
      );
  static BoxDecoration salePriceDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(0.r),

      ),
      border: Border.all(
          width: 1.sp,
          color: colorPrimary),
      // boxShadow: [ BoxShadow(
      //   color:  Styles.shadowColor.withOpacity(0.08),
      //    blurRadius: 6,
      //    offset: Offset(3, 3), // changes position of shadow
      // )],
      color: Colors.white
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
  static BoxDecoration multySelectDecoration = BoxDecoration(

      // borderRadius: BorderRadius.all(
      //   Radius.circular(23.r),
      // ),
      // boxShadow: [ BoxShadow(
      //   color:  Styles.shadowColor.withOpacity(0.08),
      //    blurRadius: 6,
      //    offset: Offset(3, 3), // changes position of shadow
      // )],
      color: Colors.transparent
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
  static BoxDecoration itemCartDecoration = BoxDecoration(

      borderRadius: BorderRadius.only(

        topRight:Radius.circular(38.r),
        bottomRight:Radius.circular(38.r),
      ),
      boxShadow: [ BoxShadow(
        color:  Styles.shadowColor.withOpacity(0.16),
         blurRadius: 6,
         offset: Offset(3, 3), // changes position of shadow
      )],
      color: Colors.white

      );
  static BoxDecoration itemCartRTLDecoration = BoxDecoration(

      borderRadius: BorderRadius.only(

        topLeft:Radius.circular(38.r),
        bottomLeft:Radius.circular(38.r),
      ),
      boxShadow: [ BoxShadow(
        color:  Styles.shadowColor.withOpacity(0.16),
         blurRadius: 6,
         offset: Offset(3, 3), // changes position of shadow
      )],
      color: Colors.white

      );
  static BoxDecoration itemWishDecoration = BoxDecoration(

      borderRadius: BorderRadius.all( Radius.circular(29.r),),
        // bottomLeft:Radius.circular(38.r),

      boxShadow: [ BoxShadow(
        color:  Styles.shadowColor.withOpacity(0.16),
         blurRadius: 6,
         offset: Offset(3, 3), // changes position of shadow
      )],
      color: Colors.white

      );
  static BoxDecoration itemDeleteWishDecoration = BoxDecoration(

      borderRadius: BorderRadius.only(
        // Radius.circular(29.r),
        topLeft:Radius.circular(29.r),
        bottomLeft :Radius.circular(29.r),
        bottomRight:Radius.circular(29.r),
      ),
        // bottomLeft:Radius.circular(38.r),


      color: Styles.colorPrimary


  );
  static BoxDecoration itemDeleteInternalWishDecoration = BoxDecoration(



      color: Colors.transparent

      );
  static BoxDecoration finishOrderDecoration = BoxDecoration(

      borderRadius: BorderRadius.only(

        bottomLeft:Radius.circular(29.r),
        bottomRight:Radius.circular(29.r),
      ),
      boxShadow: [ BoxShadow(
        color:  Styles.shadowColor.withOpacity(0.16),
         blurRadius: 6,
         offset: Offset(3, 3), // changes position of shadow
      )],
      color:colorPrimary

      );
  static BoxDecoration shadowPrimaryDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(23.r),
      ),
      boxShadow: [ BoxShadow(
        color:  Styles.shadowPrimaryColor.withOpacity(0.21),
         blurRadius: 6,
         offset: Offset(4, 4), // changes position of shadow
      )],
      color: Colors.white
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
  static BoxDecoration roundedDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(23.r),
      ),
      boxShadow: [ BoxShadow(
        color:  Styles.shadowColor.withOpacity(0.08),
         blurRadius: 6,
         offset: Offset(3, 3), // changes position of shadow
      )],
      color: Colors.white
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
  static BoxDecoration roundedOutLineDecoration = BoxDecoration(
      border: Border.all(
           color: colorPrimary),
      borderRadius: BorderRadius.all(
        Radius.circular(5.r),

      ),
       // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
  static BoxDecoration iconDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(11.r),
      ),
      // boxShadow: [ BoxShadow(
      //   color:  Styles.ColorLiteGray6.withOpacity(1),
      //   spreadRadius: 1,
      //   blurRadius: 2,
      //   //  offset: Offset(0, 3), // changes position of shadow
      // )],
      color: colorPrimary
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
  static BoxDecoration transParentDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(11.r),
      ),
      // boxShadow: [ BoxShadow(
      //   color:  Styles.ColorLiteGray6.withOpacity(1),
      //   spreadRadius: 1,
      //   blurRadius: 2,
      //   //  offset: Offset(0, 3), // changes position of shadow
      // )],
      color: Colors.transparent
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );


  static BoxDecoration textFieldDecoration = BoxDecoration(
      border: Border.all(color:   Color(0xffffffff)),
      borderRadius: BorderRadius.all(

        Radius.circular(18.r),
      ),
      boxShadow: [ BoxShadow(
        color:  Color(0x000000).withOpacity(0.11) ,
        spreadRadius: 0,
        blurRadius: 4,
         offset: Offset(2, 2), // changes position of shadow
      )],
      color: Styles.ColorWhite
      // gradient: LinearGradient(
      //     colors: [
      //       Styles.Colorstart.withOpacity(1),
      //       Styles.ColorEnd.withOpacity(0.9)
      //     ])
      );
 }

abstract class CommonSizes {
  /// Mozzaik application sizes
  static const TINY_LAYOUT_W_GAP = 10.0;
  static const SMALL_LAYOUT_W_GAP = 25.0;
  static const MED_LAYOUT_W_GAP = 50.0;
  static const BIG_LAYOUT_W_GAP = 75.0;
  static const BIGGER_LAYOUT_W_GAP = 100.0;
  static const BIGGEST_LAYOUT_W_GAP = 125.0;
  static const BORDER_RADIUS_STANDARD = 15.0;
  static const BORDER_RADIUS_CORNERS_BIG = 18.0;

  static final appBarHeight = 120.h;

  static final navBarHeight = 120.h;

  /// --------------- ///
  static final vSmallestSpace5v = SizedBox(height: 5.h);
  static final vSmallestSpace = SizedBox(height: 10.h);
  static final vSmallerSpace = SizedBox(height: 20.h);
  static final vSmallSpace = SizedBox(height: 30.h);
  static final vBigSpace = SizedBox(height: 40.h);
  static final vBiggerSpace = SizedBox(height: 50.h);
  static final vBiggestSpace = SizedBox(height: 60.h);
  static final vLargeSpace = SizedBox(height: 70.h);
  static final vLargerSpace = SizedBox(height: 80.h);
  static final vLargestSpace = SizedBox(height: 90.h);
  static final vHugeSpace = SizedBox(height: 100.h);

  static final hSmallestSpace = SizedBox(width: 10.w);
  static final hSmallerSpace = SizedBox(width: 20.w);
  static final hSmallSpace = SizedBox(width: 30.w);
  static final hBigSpace = SizedBox(width: 40.w);
  static final hBiggerSpace = SizedBox(width: 50.w);
  static final hBiggestSpace = SizedBox(width: 60.w);
  static final hLargeSpace = SizedBox(width: 70.w);
  static final hLargerSpace = SizedBox(width: 80.w);
  static final hLargestSpace = SizedBox(width: 90.w);
  static final hHugeSpace = SizedBox(width: 100.w);

  static const divider = const Divider(thickness: 10);
}
