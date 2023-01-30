import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grodudes/generated/intl/messages_all.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'configurations/assets.dart';
import 'configurations/styles.dart';

class LoaderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoaderScreenState();
}
class AppBody {
  final String title;
  final Widget widget;
  AppBody(
      this.title,
      this.widget,
      );
}

class LoaderScreenState extends State<LoaderScreen> {
  late PageController _pageController;

  final listOfAnimations  = <AppBody>[

       AppBody(
        'waveDots',
        LoadingAnimationWidget.waveDots(
          color:Styles.colorPrimary,
          size: 100.h,
        ),
      ),


  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ..initialize().th
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
Expanded(child: Container()),
              SizedBox(
                height: 250.h,
                child:
          Center(child:
             Image.asset(Assets.PNG_SplashImage,color: Styles.colorPrimary,
             ),)),

    SizedBox(
    height: 100.h,),
              Expanded(
                child: Center(
                  child: listOfAnimations.first.widget,
                ),
              ),
              Expanded(child: Container()),
            ],
          ),


    );
  }


}
