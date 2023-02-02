import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/core/constants.dart';
import 'package:grodudes/core/widget/majl/majal_app_bar.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/pages/account/AddressDetails.dart';
import 'package:grodudes/pages/account/Orders.dart';
import 'package:grodudes/pages/account/profile_Details.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../core/configurations/assets.dart';
import '../../core/shared_preferences_items.dart';
import '../../core/utils.dart';
import '../../l10n/locale_provider.dart';
import '../../routing/route_paths.dart';
import '../wishLsit.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final listTileTextStyle = TextStyle(fontSize: 16);

  // AccountDetails(this.wpUserInfo, this.wcUserInfo);
  List<String> Languages = [
    "English",
    "العربية",
  ];
  // List<double> Scales = [
  //   0.5,0.7,0.8,0.85,0.9,0.95,0.98,1,1.01,1.05,1.1,1.15,1.2,1.5,1.6
  //  ];
  // List<String> selectedLanguges = [];
  String _chosenValue = "العربية";
  int _selectedIndex = 0;
  int _selectedScale = 0;
  late SharedPreferences _spf;
  SfRangeValues _values = SfRangeValues(0.0, 2.0);

  Map<String, dynamic> _filterData(Map<String, dynamic> data) {
    Map<String, dynamic> filteredData = {};
    for (final String key in data.keys) {
      if (key == 'email' && data[key] == null || data[key].length == 0)
        continue;
      filteredData[key] = data[key];
    }
    return filteredData;
  }

  _initfAsync() async {
    _spf = await SharedPreferences.getInstance();

    setState(() {
      _selectedIndex = _spf.getInt(SharedPreferencesKeys.LanguageIndex) ?? 0;
      _chosenValue = getStringValue(_selectedIndex + 1);
      _selectedScale = 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initfAsync();
    _values = SfRangeValues(0.0, 2);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dataProvider = Provider.of<UserManager>(context, listen: false);
    if (dataProvider.wcUserInfo == null ||
        dataProvider.wcUserInfo!['id'] == null)
      return _LoginErrorDescriptionWidget(dataProvider.wpUserInfo!);
    if (dataProvider.wpUserInfo == null ||
        dataProvider.wcUserInfo!['email'] == null)
      return _LoginErrorDescriptionWidget(dataProvider.wpUserInfo!);

    return Scaffold(
        // appBar: AppBar(
        //
        //   actions: [
        //   ],
        //   iconTheme: IconThemeData(
        //     color: Colors.black, //change your color here
        //   ),
        //   // backgroundColor: Styles.colorBackGround,
        // ),
        backgroundColor: Styles.colorBackGround,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            // scrollDirection: Axis.vertical,
            children: <Widget>[
              MajalAppBar(
                isProfile: true,
                withBack: false,
                tail: [
                  InkWell(
                      onTap: () {
                        _logoutFuntction(context, dataProvider);
                      },
                      child: Container(
                          decoration: Styles.iconDecoration
                              .copyWith(color: Styles.ColorLogout),
                          height: 47.h,
                          width: 45.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 11.h),
                          child:
                              // Icon(Icons.chevron_right,color:Colors.white,)
                              SvgPicture.asset(
                            Assets.SVG_logout,
                            allowDrawingOutsideViewBox: true,
                            height: 47.h,
                            width: 45.h,
                          )))
                ],
              ),
              // CommonSizes.vBigSpace,
              InkWell(
                  onTap: () {},
                  child: Center(
                      child: Container(
                          decoration: Styles.tilesDecoration.copyWith(
                              borderRadius: BorderRadius.all(
                                Radius.circular(220.r),
                              ),
                              color: Colors.transparent),
                          child:
                              // Image.asset(Assets.PNG_BackgroudImage),
                              Image.asset(
                            Assets.PNG_profile,
                            fit: BoxFit.fill,

                            height: 220.h,
                            width: 220.w,

                            //   Image.network(
                            // dataProvider.wcUserInfo!['avatar_url'] ??
                            //     '',
                            // height: 220.h,
                            // width: 220.w,
                            // errorBuilder:
                            //     (context, error, stackTrace) =>
                            //
                            //         SvgPicture.asset(
                            //           Assets.SVG_UserProfile,
                            //           height: 220.h,
                            //           width: 220.w,
                            //           // color: Styles.colorSecondary,
                            //         ),
                            // Icon(Icons.person, size: 220.h),
                            // ),
                          )))),
              // CommonSizes.vSmallSpace,
              Text(
                dataProvider.wcUserInfo!['username'],
                style: Styles.boldTextStyle,
                textAlign: TextAlign.center,
              ),
              // CommonSizes.vSmallerSpace,
              Text(dataProvider.wcUserInfo!['email'],
                  style: Styles.regularTextStyle),
              CommonSizes.vSmallSpace,
              _buildEditeProfilWidget(context),
              CommonSizes.vSmallSpace,
              _buildBillingAddressWidget(context),

              CommonSizes.vSmallSpace,
              _buildWilshlistWidget(context),
              CommonSizes.vSmallSpace,
              _buidLanguage(),
              // CommonSizes.vSmallSpace,
              // _buildScaleWidget(),
              // _buildLogoutWidget(context, dataProvider),
            ],
          ),
        )));
  }

  _buidLanguage() {
    return InkWell(
        onTap: () async {},
        child: Container(
            height: 60.h,
            width: 307.w,
            // margin: EdgeInsets.symmetric(horizontal: 50.w),
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
            // color: Colors.white,
            decoration: Styles.tilesDecoration,
            child: Row(children: [
              // CommonSizes.hSmallSpace,
              Expanded(
                  child: Container(
                      height: 150.h,
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        icon: Icon(
                          Icons.chevron_right,
                          color: Styles.colorSecondary2,
                        ),
                        iconSize: 0.r,
                        isExpanded: false,
                        underline: SizedBox(),
                        selectedItemBuilder: (BuildContext context) {
                          return Languages.map<Widget>((String item) {
                            return Row(
                              children: [
                                Text(item,
                                    textAlign: TextAlign.center,
                                    style: Styles.regularTextStyle),
                              ],
                            );
                          }).toList();
                        },
                        items: Languages.map((e) {
                          return DropdownMenuItem(
                              value: e,
                              child: Text(e, textAlign: TextAlign.center));
                        }).toList(),
                        value: Languages[_selectedIndex],
                        onChanged: (String? value) {
                          setState(() async {
                            _selectedIndex =
                                Languages.indexOf(value ?? "") ?? 0;
                            _chosenValue = getStringValue(_selectedIndex + 1);

                            await _spf.setString(
                                SharedPreferencesKeys.LanguageCode,
                                getLocal(_selectedIndex).languageCode);
                            await _spf.setInt(
                                SharedPreferencesKeys.LanguageIndex,
                                _selectedIndex);

                            Provider.of<LocaleProvider>(context, listen: false)
                                .setLocale(getLocal(_selectedIndex));
                          });
                        },
                      ))),
              Container(
                  decoration: Styles.iconDecoration
                      .copyWith(color: Styles.colorPrimary.withOpacity(0.7)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.h, vertical: 11.h),
                  height: 40.h,
                  width: 40.h,
                  child: SvgPicture.asset(
                    Assets.SVG_Languges,
                    allowDrawingOutsideViewBox: true,
                    height: 40.h,
                    width: 40.w,
                  )
                  // Icon(Icons.chevron_right,color:Colors.white,)
                  ),
              // CommonSizes.hSmallSpace,
            ])));
  }

  getStringValue(int index) {
    switch (index) {
      case 1:
        return S.of(context).english;
      case 2:
        return S.of(context).arabic;
      case 3:
        return S.of(context).german;

      default:
        {
          return S.of(context).english;
        }
    }
  }

  Locale getLocal(int index) {
    switch (index) {
      case 0:
        return Locale('en');

      case 1:
        return Locale('ar');

      case 2:
        return Locale('de');

      default:
        return Locale('en');
    }
  }

  _buildEditeProfilWidget(context) {
    return GestureDetector(
        onTap: () {
          Utils.pushNewScreenWithRouteSettings(
            context,
            settings: RouteSettings(name: RoutePaths.ProductDetailsPage),
            withNavBar: false,
            screen: ProfileDetails(
              title: S.of(context).editeProfile,
              type: 'profile',
              updateCb: (Map<String, dynamic> newAddress) async {
                String msg =
                    await Provider.of<UserManager>(context, listen: false)
                        .updateUser(_filterData(newAddress));
                return msg;
              },
            ),
          );
          // Navigator.push(
          //     context, CupertinoPageRoute(builder: (context) => Orders()));
        },
        child: Center(
            child: Container(
                height: 60.h,
                width: 307.w,
                // margin: EdgeInsets.symmetric(horizontal: 50.w),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18.w),
                // color: Colors.black,
                decoration: Styles.tilesDecoration,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // CommonSizes.hSmallSpace,
                      Text(
                        S.of(context).editAccountDetails,
                        style: Styles.regularTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(child: Container()),
                      Container(
                          decoration: Styles.iconDecoration.copyWith(
                              color: Styles.colorPrimary.withOpacity(0.7)),
                          height: 40.h,
                          width: 40.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 11.h),
                          child: SvgPicture.asset(
                            Assets.edit_profile,
                            allowDrawingOutsideViewBox: true,
                            height: 40.h,
                            width: 40.h,
                          )

                          // Icon(Icons.chevron_right,color:Colors.white,)
                          ),
                      // CommonSizes.hSmallSpace,
                    ]))));
  }

  _buildBillingAddressWidget(context) {
    return GestureDetector(
        onTap: () {
          Utils.pushNewScreenWithRouteSettings(
            context,
            settings: RouteSettings(name: RoutePaths.AddressDetails),
            withNavBar: false,
            screen: AddressDetails(
              title: S.of(context).billingAddress,
              type: 'billing',
              updateCb: (List<Map<String, dynamic>> newAddress) async {
                Map<String, dynamic> res = {};
                if (newAddress.length == 1) {
                  res.addAll({'billing': _filterData(newAddress[0])});
                }
                if (newAddress.length == 2) {
                  res.addAll({
                    'billing': _filterData(newAddress[0]),
                    'shipping': _filterData(newAddress[1])
                  });
                }
                String msg =
                    await Provider.of<UserManager>(context, listen: false)
                        .updateUser(res);
                return msg;
              },
            ),
          );
        },
        child: Center(
            child: Container(
                height: 60.h,
                width: 307.w,
                // margin: EdgeInsets.symmetric(horizontal: 50.w),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18.w),
                // color: Colors.white,
                decoration: Styles.tilesDecoration,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // CommonSizes.hSmallSpace,
                      Text(
                        S.of(context).billingAndShipping,
                        style: Styles.regularTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(child: Container()),
                      Container(
                          decoration: Styles.iconDecoration.copyWith(
                              color: Styles.colorPrimary.withOpacity(0.7)),
                          height: 40.h,
                          width: 40.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.h, vertical: 11.h),
                          child:
                              // Icon(Icons.chevron_right,color:Colors.white,)
                              SvgPicture.asset(
                            Assets.SVG_Address,
                            allowDrawingOutsideViewBox: true,
                            height: 40.h,
                            width: 40.h,
                          )),
                      // CommonSizes.hSmallSpace,
                    ]))));
  }

  // _buildShippingAddressWidget(context) {
  //   return GestureDetector(
  //       onTap: () {
  //         Utils.pushNewScreenWithRouteSettings(
  //           context,
  //           settings: RouteSettings(name: RoutePaths.AddressDetails),
  //           withNavBar: false,
  //           screen: AddressDetails(
  //             title: S.of(context).shippingAddress,
  //             type: 'shipping',
  //             updateCb: (Map<String, dynamic> newAddress) async {
  //               String msg =
  //                   await Provider.of<UserManager>(context, listen: false)
  //                       .updateUser({'shipping': _filterData(newAddress)});
  //               return msg;
  //             },
  //           ),
  //         );
  //
  //       },
  //       child: Container(
  //           height: 60.h,
  //           width: 307.w,
  //           // margin: EdgeInsets.symmetric(horizontal: 50.w),
  //           padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18.w),
  //           // color: Colors.white,
  //           decoration: Styles.tilesDecoration,
  //           child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: <Widget>[
  //                 // CommonSizes.hSmallSpace,
  //                 Text(
  //                   S.of(context).shippingAddress,
  //                   style: Styles.regularTextStyle,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //                 Expanded(child: Container()),
  //       Container(
  //           decoration: Styles.iconDecoration.copyWith(color: Styles.colorPrimary.withOpacity(0.7)),
  //
  //           height: 40.h,
  //           width: 40.h,
  //           padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 11.h),
  //
  //           child:
  //           // Icon(Icons.chevron_right,color:Colors.white,)
  //           SvgPicture.asset(
  //             Assets.SVG_wishlist,
  //             // allowDrawingOutsideViewBox: true,
  //
  //             // height: 40.h,
  //             // width: 40.h,
  //
  //           )
  //       ),
  //                 // CommonSizes.hSmallSpace,
  //               ])));
  // }
  _buildWilshlistWidget(context) {
    return GestureDetector(
        onTap: () {
          Utils.pushNewScreenWithRouteSettings(
            context,
            settings: RouteSettings(name: RoutePaths.Wishtems),
            withNavBar: false,
            screen: Wishtems(),
          );
        },
        child: Container(
            height: 60.h,
            width: 307.w,
            // margin: EdgeInsets.symmetric(horizontal: 50.w),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18.w),
            // color: Colors.white,
            decoration: Styles.tilesDecoration,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // CommonSizes.hSmallSpace,
                  Text(
                    S.of(context).wishlist,
                    style: Styles.regularTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(child: Container()),
                  Container(
                      decoration: Styles.iconDecoration.copyWith(
                          color: Styles.colorPrimary.withOpacity(0.7)),
                      height: 40.h,
                      width: 40.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.h, vertical: 11.h),
                      child:
                          // Icon(Icons.chevron_right,color:Colors.white,)
                          SvgPicture.asset(
                        Assets.SVG_wishlist,
                        fit: BoxFit.scaleDown,
                        // allowDrawingOutsideViewBox: true,

                        // height: 40.h,
                        // width: 40.h,
                      )),
                  // CommonSizes.hSmallSpace,
                ])));
  }

  _logoutFuntction(context, dataProvider) {
    dataProvider.logOut();
    // Provider.of<CartManager>(context, listen: false).clearCart();
    Phoenix.rebirth(context);
  }

  _buildLogoutWidget(context, dataProvider) {
    return GestureDetector(
        onTap: () {
          dataProvider.logOut();
          // Provider.of<CartManager>(context, listen: false).clearCart();
          Phoenix.rebirth(context);
        },
        child: Container(
            height: 150.h,
            margin: EdgeInsets.symmetric(horizontal: 50.w),
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
            // color: Colors.white,
            decoration: Styles.tilesDecoration,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CommonSizes.hSmallSpace,
                  Text(
                    S.of(context).logout,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: Icon(Icons.chevron_right)),
                  CommonSizes.hSmallSpace,
                ])));
  }
  // _buildScaleWidget( ) {
  //
  //     return InkWell(
  //         onTap: () async {},
  //         child: Container(
  //             height: 60.h,
  //             width: 307.w,
  //             // margin: EdgeInsets.symmetric(horizontal: 50.w),
  //             padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
  //             // color: Colors.white,
  //             decoration: Styles.tilesDecoration,
  //             child: Row(children: [
  //               // CommonSizes.hSmallSpace,
  //               Expanded(
  //                   child: Container(
  //
  //                       height: 150.h,
  //                       child: DropdownButton(
  //                         dropdownColor: Colors.white,
  //                         icon: Icon(
  //
  //                           Icons.chevron_right,
  //                           color: Styles.colorSecondary2,
  //                         ),
  //                         iconSize: 0.r,
  //                         isExpanded: false,
  //                         underline: SizedBox(),
  //                         selectedItemBuilder: (BuildContext context) {
  //                           return Scales.map<Widget>((double item) {
  //                             return Row(
  //                               children: [
  //                                 Text(
  //                                     (item*100).toString()+"%",
  //                                     textAlign: TextAlign.center,
  //                                     style:Styles.regularTextStyle
  //                                 ),
  //                               ],
  //                             );
  //                           }).toList();
  //                         },
  //                         items: Scales.map((e) {
  //                           return DropdownMenuItem(
  //                               value: e,
  //                               child: Text(e.toString(), textAlign: TextAlign.center));
  //                         }).toList(),
  //                         value: Scales[_selectedScale],
  //                         onChanged: (double? value) {
  //                           setState(() async {
  //                             _selectedScale=    Scales.indexOf(value ?? 1.0) ?? 0;
  //                             Provider.of<LocaleProvider>(context, listen: false)
  //                                 .setScale(value??1.0);
  //                           });
  //                         },
  //                       ))),
  //               Container(
  //                   decoration: Styles.iconDecoration.copyWith(color: Styles.colorPrimary.withOpacity(0.7)),
  //                   padding:EdgeInsets.symmetric(horizontal: 10.h,vertical: 11.h),
  //
  //                   height: 40.h,
  //                   width: 40.h,
  //                   child:
  //                   SvgPicture.asset(
  //                     Assets.SVG_Languges,
  //                     allowDrawingOutsideViewBox: true,
  //
  //                     height: 40.h,
  //                     width: 40.w,
  //
  //                   )
  //                 // Icon(Icons.chevron_right,color:Colors.white,)
  //               ),
  //               // CommonSizes.hSmallSpace,
  //             ])));
  //   }
}

class _LoginErrorDescriptionWidget extends StatelessWidget {
  final Map<String, dynamic> errorData;

  _LoginErrorDescriptionWidget(this.errorData);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorData == null
                ? 'An Unknown error has occured. Please retry Login'
                : errorData['errMsg'] ??
                    'An Unknown error has occured. Please retry Login',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: Text('Retry Login'),
          )
        ],
      ),
    );
  }
}
