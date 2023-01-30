import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:grodudes/components/CategoryCard.dart';
import 'package:grodudes/models/Category.dart';
import 'package:grodudes/pages/CartItems.dart';
import 'package:grodudes/pages/account/AccountRoot.dart';
import 'package:grodudes/pages/account/Orders.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:grodudes/state/user_state.dart';

import '../core/configurations/assets.dart';
import '../core/configurations/styles.dart';

class RootDrawer extends StatelessWidget {
  final TextStyle _whiteText = TextStyle(color: Colors.white, fontSize: 15);

  String _formatName(String name) {
    return name.replaceAll('&amp;', '&');
  }

  Future _openSnapPage() async {
    String url = "https://www.grodudes.com/take-a-snap";
    try {
      if (await canLaunch(url)) {
        await launch(url, enableJavaScript: true);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (context, userManager, child) {
        bool isLoggedIn = userManager.isLoggedIn();
        List<Category> categories =
            Provider.of<ProductsManager>(context, listen: false)
                .categories
                .values
                .toList();
        return Drawer(
          backgroundColor:  Styles.ColorWhite ,
          child: ListView(
            children: <Widget>[
              Container(
                height: 123.h,
                decoration: BoxDecoration(color: Color(0xFFEAEAEA)),
                // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 36),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => AccountRoot()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      SizedBox(height: 46.h),
                      isLoggedIn
                          ? Expanded(
                              child:
                                  Text(
                                      userManager.wcUserInfo!['username'] ??
                                          'Username not found',
                                      style: Styles.boldTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: Styles.fontSize20
                                      )),
                                  // Text(
                                  //     userManager.wcUserInfo!['email'] ??
                                  //         'Email not found',
                                  //     style: _whiteText)

                            )
                          : Text('Guest', style:  Styles.boldTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: Styles.fontSize20
                      )),  isLoggedIn
                          ? Expanded(
                              child:
                                  Text(
                                     "active pharmacy"??
                                          'Username not found',
                                      style: Styles.boldTextStyle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: Styles.fontSize13
                                      )),
                                  // Text(
                                  //     userManager.wcUserInfo!['email'] ??
                                  //         'Email not found',
                                  //     style: _whiteText)

                            )
                          : Text('Guest', style:  Styles.boldTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: Styles.fontSize20
                      )),
                      SizedBox(height: 36.h),

                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text('my account'),
                leading:
                        SvgPicture.asset(Assets.SVGAccountDrawer,width: 26.w,),


                onTap: () {
                  if (!isLoggedIn) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please Login to track your Orders'),
                      ),
                    );
                    Navigator.pop(context);
                    return;
                  }
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => Orders(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('my pharmacy'),
                leading:   SvgPicture.asset(Assets.SVGmypharmacy,width: 26.w,),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => CartItems()),
                  );
                },
              ),
              ListTile(
                title: Text('stock alert'),
                leading: SvgPicture.asset(Assets.SVGStockAlert,width: 26.w,),
                 onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => CartItems()),
                  );
                },
              ),
              ListTile(
                title: Text('payment request'),
                leading: SvgPicture.asset(Assets.SVGPaymentMethod,width: 26.w,),
                 onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => CartItems()),
                  );
                },
              ),
              ListTile(
                title: Text('contact'),
                leading: SvgPicture.asset(Assets.SVGContacts,width: 26.w,),
                 onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => CartItems()),
                  );
                },
              ),


              isLoggedIn
                  ? ListTile(
                      title: Text('Logout'),
                      leading:
                          Icon(Icons.power_settings_new, color: Colors.red),
                      onTap: () {
                        Navigator.pop(context);
                        userManager.logOut();
                      },
                    )
                  : SizedBox(height: 0),
            ],
          ),
        );
      },
    );
  }
}
