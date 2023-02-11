import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/pages/Home.dart';
import 'package:grodudes/pages/account/AccountDetails.dart';
import 'package:grodudes/pages/account/LogInPage.dart';
import 'package:grodudes/pages/account/Orders.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Root.dart';
import '../components/custom_nav_bar_widget.dart';
import '../core/configurations/assets.dart';
import '../disturbers.dart';
import '../messges.dart';
import 'CartItems.dart';
import 'account/AccountRoot.dart';

class NavigationScreen extends StatefulWidget {
  late BuildContext menuScreenContext;

  NavigationScreen(
      //{ required this.loginInfo}
      );

  @override
  State<StatefulWidget> createState() => _AppMainScreenDocState();
}

class _AppMainScreenDocState extends State<NavigationScreen> {
  late SharedPreferences _spf;
  late DateTime _timeoutAt;

  late PersistentTabController _controller;
  late bool _hideNavBar;
  DateTime? backButtonPressTime;
  static const flutterToastDuration = const Duration(seconds: 3);

  List<ValueKey<String>> home = [
    ValueKey<String>("calenderPage"),
    ValueKey<String>("appointmentPage"),
    ValueKey<String>("addAppointmentPage"),
    ValueKey<String>("patientPage"),
    ValueKey<String>("profilePage")
  ]; //new GlobalKey<FormFieldState<String>>(debugLabel:"passWordKey");
  late Widget _form;
  int navIndex = 0, prevNavIndex = 0;

  bool pass = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (context, user, child) {
        var logInStatus = user.getLogInStatus();
        return logInStatus == logInStates.pending
            ? Center(
                child: CircularProgressIndicator(
                color: Styles.colorPrimary,
              ))
            : logInStatus != logInStates.loggedIn
                ? LoginPage()
                : Scaffold(
                    backgroundColor: Styles.colorBackGround,
                    resizeToAvoidBottomInset: true,
                    body: PersistentTabView.custom(
                      context,
                      controller: _controller,
                      screens: _buildScreens(),
                      // items: _navBarsItems(),
                      confineInSafeArea: true,

                      backgroundColor: Colors.white,
                      // Default is Colors.white.
                      handleAndroidBackButtonPress: true,
                      onWillPop: (context) async {
                        // FocusScope.of(context!).unfocus();

                        DateTime currentTime = DateTime.now();
                        bool
                            backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
                            backButtonPressTime == null ||
                                currentTime.difference(backButtonPressTime!) >
                                    flutterToastDuration;
                        if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
                          backButtonPressTime = currentTime;

                          Fluttertoast.showToast(
                              msg: S.of(context!).pressTwiceToExit,
                              textColor: Styles.ColorWhite,
                              backgroundColor:
                                  Styles.colorPrimary.withOpacity(1));
                          return false;
                        } else {
                          SystemNavigator.pop();

                          return true;
                        }
                      },
                      // Default is true.
                      resizeToAvoidBottomInset: true,
                      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                      stateManagement: true,
                      // Default is true.
                      hideNavigationBarWhenKeyboardShows: true,

                      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.

                      // decoration: NavBarDecoration(
                      //   borderRadius: BorderRadius.circular(10.0),
                      //   colorBehindNavBar: Colors.white,
                      // ),
                      // popAllScreensOnTapOfSelectedTab: true,
                      // popActionScreens: PopActionScreensType.all,
                      // itemAnimationProperties: ItemAnimationProperties(
                      // Navigation Bar's items animation properties.
                      // duration: Duration(milliseconds: 200),
                      // curve: Curves.ease,
                      // ),
                      screenTransitionAnimation: ScreenTransitionAnimation(
                        // Screen transition animation on change of selected tab.
                        animateTabTransition: true,
                        curve: Curves.ease,
                        duration: Duration(milliseconds: 200),
                      ),

                      customWidget: CustomNavBarWidget(
                        items: _navBarsItems(),
                        navBarHeight: CommonSizes.navBarHeight,
                        keys: home,
                        onItemSelected: (index) {
                          _controller.index = index;

                          setState(() {});
                        },
                        selectedIndex: _controller.index,
                      ),
                      itemCount: 4,
                      navBarHeight: 69.h,
                    ),
                    // Choose the nav bar style with this property.
                  );
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      Root(),
      HomeCategory(Provider.of<ProductsManager>(context)),
      Orders(),
      AccountDetails(),
      // Messages(),
      // Disturbers(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.SVG_homeActive,
          width: 26.w,
        ),
        title: S.of(context).home,
        inactiveIcon: SvgPicture.asset(
          Assets.SVG_homeinActive,
          width: 26.w,
        ),
        activeColorPrimary: Styles.secondaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.SVG_disturbersActive,
          width: 26.w,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.SVG_disturbersInActive,
          width: 26.w,
        ),
        title: S.of(context).disturbers,
        activeColorPrimary: Styles.secondaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.SVG_orderActive,
          width: 26.w,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.SVG_orderinActive,
          width: 26.w,
        ),
        title: S.of(context).orders,
        activeColorPrimary: Styles.secondaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Assets.SVG_profileActive,
          width: 26.w,
        ),
        inactiveIcon: SvgPicture.asset(
          Assets.SVG_profileinActive,
          width: 26.w,
        ),
        title: S.of(context).profile,
        activeColorPrimary: Styles.secondaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    widget.menuScreenContext = context;
    _controller = PersistentTabController(initialIndex: 0);
    _controller.addListener(() {
      if (mounted)
        setState(() {
          navIndex = _controller.index;
        });
    });

    _hideNavBar = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
