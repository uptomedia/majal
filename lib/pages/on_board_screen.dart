import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grodudes/core/configurations/assets.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/shared_preferences_items.dart';
import '../core/utils.dart';
import '../routing/route_paths.dart';

class OnBoardScreen extends StatefulWidget {
    SharedPreferences preferences;

  OnBoardScreen({required this.preferences,Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  late Material materialButton;
  late int index;

  final onboardingPagesList = [
     PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Styles.colorBackGround,
          border: Border.all(
            width: 0.0,
            color: Styles.colorBackGround,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column

            (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 170.h,),

              SizedBox(
                height: 268.h,
                 child: SvgPicture.asset(Assets.SVGonBoarding,
                     ),
              ),
              SizedBox(height: 135.h,),
              Center(child:   Container(
                  width: 88.w,
                // padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Track order !!',
                    style:
                    Styles.regularTextStyle.copyWith(
                        fontSize: Styles.fontSize27,
                        fontWeight: FontWeight.w700,
                        color: Styles.colorFontColorDark),
                    textAlign:  TextAlign.center,
                  ),
                ),
              ),),
              SizedBox(height: 14.h,),

              Center(child:   Container(
                width: 300.w,
                // padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Lorem ipsum dolor sit amet,\n consectetur adipiscing,\nsed do eiusmod tempor ut labore',
                    style:
                    Styles.regularTextStyle.copyWith(
                        fontSize: Styles.fontSize16,
                        fontWeight: FontWeight.w300,
                        color: Styles.colorFontColorDark),
                    textAlign: TextAlign.center,
                  ),

                ),
              ),)
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Styles.colorBackGround,
          border: Border.all(
            width: 0.0,
            color: Styles.colorBackGround,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column

            (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 170.h,),

              SizedBox(
                height: 268.h,
                child: SvgPicture.asset(Assets.SVGonBoarding1,
                ),
              ),
              SizedBox(height: 135.h,),
              Center(child:   Container(
                width: 88.w,
                // padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Track order !!',
                    style:
                    Styles.regularTextStyle.copyWith(
                        fontSize: Styles.fontSize27,
                        fontWeight: FontWeight.w700,
                        color: Styles.colorFontColorDark),
                    textAlign:  TextAlign.center,
                  ),
                ),
              ),),
              SizedBox(height: 14.h,),

              Center(child:   Container(
                width: 300.w,
                // padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Lorem ipsum dolor sit amet,\n consectetur adipiscing,\nsed do eiusmod tempor ut labore',
                    style:
                    Styles.regularTextStyle.copyWith(
                        fontSize: Styles.fontSize16,
                        fontWeight: FontWeight.w300,
                        color: Styles.colorFontColorDark),
                    textAlign: TextAlign.center,
                  ),

                ),
              ),)
            ],
          ),
        ),
      ),
    ),
    PageModel(
      widget: DecoratedBox(
        decoration: BoxDecoration(
          color: Styles.colorBackGround,
          border: Border.all(
            width: 0.0,
            color: Styles.colorBackGround,
          ),
        ),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column

            (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 170.h,),

              SizedBox(
                height: 268.h,
                child: SvgPicture.asset(Assets.SVGonBoarding2,
                ),
              ),
              SizedBox(height: 135.h,),
              Center(child:   Container(
                width: 88.w,
                // padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Track order !!',
                    style:
                    Styles.regularTextStyle.copyWith(
                        fontSize: Styles.fontSize27,
                        fontWeight: FontWeight.w700,
                        color: Styles.colorFontColorDark),
                    textAlign:  TextAlign.center,
                  ),
                ),
              ),),
              SizedBox(height: 14.h,),

              Center(child:   Container(
                width: 300.w,
                // padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Lorem ipsum dolor sit amet,\n consectetur adipiscing,\nsed do eiusmod tempor ut labore',
                    style:
                    Styles.regularTextStyle.copyWith(
                        fontSize: Styles.fontSize16,
                        fontWeight: FontWeight.w300,
                        color: Styles.colorFontColorDark),
                    textAlign: TextAlign.center,
                  ),

                ),
              ),)
            ],
          ),
        ),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton();
    index = 0;
  }

  Material _skipButton({void Function(int)? setIndex}) {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color:       Styles.colorPrimary,

      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          if (setIndex != null) {
            index = 2;
            setIndex(2);
          }
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: Styles.colorPrimary,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          widget.preferences.setBool(SharedPreferencesKeys.OnBoarding, true);
          Utils.clearAndPush(context,   RoutePaths.SplashScreen,);

        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Continue',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Styles.colorBackGround,
        body: Onboarding(
          pages: onboardingPagesList,
          onPageChange: (int pageIndex) {
            index = pageIndex;
          },
          startPageIndex: 0,
          footerBuilder: (context, dragDistance, pagesLength, setIndex) {
            return   ColoredBox(
                color: Styles.colorBackGround,
                child: Padding(
                  padding: const EdgeInsets.all(45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width:MediaQuery.of(context).size.width*0.35),
                      CustomIndicator(
                        netDragPercent: dragDistance,
                        pagesLength: pagesLength,
                        indicator: Indicator(
                          activeIndicator: ActiveIndicator(color: Styles.colorPrimary),
                         closedIndicator: ClosedIndicator(color:Color(0xff1D8F78
                         ) ),
                          indicatorDesign: IndicatorDesign.polygon(
                              polygonDesign: PolygonDesign(
                              polygon: DesignType.polygon_circle,


                          )
                          // IndicatorDesign.line(
                          //   lineDesign: LineDesign(
                          //     lineType: DesignType.line_uniform,
                          //   ),
                          ),
                        ),
                      ),
                      // SizedBox(width:MediaQuery.of(context).size.width*0.2),
Expanded(child: Container()),
                      index == pagesLength - 1
                          ? _signupButton
                          : _skipButton(setIndex: setIndex)
                    ],
                  ),
                ),

            );
          },
        ),

    );
  }
}