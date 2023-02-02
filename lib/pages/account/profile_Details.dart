import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:provider/provider.dart';

import '../../core/configurations/assets.dart';
import '../../core/widget/majl/majal_app_bar.dart';

class ProfileDetails extends StatefulWidget {
  final String title;
  final String type;
  final Future<String> Function(Map<String, dynamic>) updateCb;

  ProfileDetails({
    required this.title,
    required this.type,
    required this.updateCb,
  });

  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  Map<String, TextEditingController> _textControllers = {};
  bool _isLoading = false;

  @override
  void initState() {
    this._textControllers = {};
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    this._textControllers.values.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  capitalize(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  Map<String, dynamic> formatData() {
    Map<String, dynamic> data = {};
    this._textControllers.keys.forEach((key) {
      data[key] = this._textControllers[key]!.text;
    });
    return data;
  }

  String _formatName(String name) {
    return getString(name);

    // name.split('_').map((e) => capitalize(e)).join(' ');
  }

  String getString(String name) {
    String s = "";

    switch (name) {
      case "first_name":
        s = S.of(context).first_name;
        break;
      case "last_name":
        s = S.of(context).last_name;
        break;
      case "company":
        s = S.of(context).company;
        break;
      case "address_1":
        s = S.of(context).address_1;
        break;
      case "address_2":
        s = S.of(context).address_2;
        break;
      case "city":
        s = S.of(context).city;
        break;
      case "postcode":
        s = S.of(context).postcode;
        break;
      case "country":
        s = S.of(context).country;
        break;
      case "state":
        s = S.of(context).state;
        break;
      case "email":
        s = S.of(context).email;
        break;
      case "phone":
        s = S.of(context).phone;
        break;

      case "username":
        s = S.of(context).username;
        break;
      case "password":
        s = S.of(context).password;
        break;
      default:
        {
          s = "not defined";
        }
    }

    return s;
  }

  List<DropdownMenuItem<String>> _getMenuItems(String value) {
    List<DropdownMenuItem<String>> menuItems = pincodes
        .map(
          (e) => DropdownMenuItem<String>(
            child: Text(e),
            value: e,
          ),
        )
        .toList();

    if (pincodes.contains(value)) return menuItems;
    menuItems.add(DropdownMenuItem<String>(
      child: Text('Not Specified'),
      value: value,
    ));
    return menuItems;
  }

  Map<String, dynamic> address = {};
  final headerTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (context, user, child) {
        if (address == null || address.length == 0) {
          address.addAll({"first_name": user.wcUserInfo!["first_name"]});
          address.addAll({"last_name": user.wcUserInfo!["last_name"]});
          address.addAll({"username": user.wcUserInfo!["username"]});
          address.addAll({"email": user.wcUserInfo!["email"]});
          // address.addAll({"password": ""});
        }
        // address.addAll({"first_name":user.wcUserInfo!["first_name"]});
        // print(address);
        if (address == null || address.length == 0) {
          return Scaffold(
              // backgroundColor: Styles.colorBackGround,
              key: _scaffoldKey,
              body: SafeArea(
                  child: SingleChildScrollView(
                      child: Container(
                          alignment: Alignment.center,
                          child: Column(
                              // scrollDirection: Axis.vertical,
                              children: [
                                MajalAppBar(
                                  withBack: true,
                                ),
                                SizedBox(
                                    child: Center(
                                  child: Text(
                                    widget.title,
                                    style: Styles.boldTextStyle,
                                  ),
                                )),
                                SizedBox(
                                  height: 100.h,
                                ),
                                Text(
                                  S.of(context).somethingWentWrong,
                                  style: Styles.boldTextStyle,
                                  textAlign: TextAlign.center,
                                )
                              ])))));
        }
        return Scaffold(
            backgroundColor: Styles.colorBackGround,
            key: _scaffoldKey,
            body: SafeArea(
                child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // scrollDirection: Axis.vertical,
                children: [
                  MajalAppBar(
                    withBack: true,
                  ),

                  Container(

                      // width: 220.w,
                      // height: 220.h,

                      child: ClipRRect(
                          // color: Colors.black,

                          borderRadius: BorderRadius.circular(1),
                          child: Center(
                              child: Container(
                                  decoration: Styles.tilesDecoration.copyWith(
                                      borderRadius: BorderRadius.all(
                                    Radius.circular(220.r),
                                  )),
                                  child:
                                      // Image.asset(Assets.PNG_BackgroudImage),
                                      SvgPicture.asset(
                                    Assets.SVG_UserProfile,
                                    allowDrawingOutsideViewBox: true,
                                    height: 220.h,
                                    width: 220.w,
                                  ))))),
                  // CommonSizes.vSmallSpace,
                  Text(
                    address['username'],
                    style: Styles.boldTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  CommonSizes.vSmallerSpace,
                  Text(
                      // address['email'],
                      S.of(context).personalInfo,
                      style: Styles.regularTextStyle),
                  CommonSizes.vSmallSpace,

                  ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 25,
                        );
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: address.keys.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final key = address.keys.elementAt(index);

                        final text = address[key];

                        TextEditingController _controller;
                        _controller = TextEditingController(text: text);
                        this._textControllers[key] = _controller;

                        return Container(
                            height: 60.h,
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 37.w),
                            decoration: Styles.textFieldDecoration,

                            // padding: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),
                            child: TextField(
                              readOnly: key == "email" ? true : false,
                              controller: _controller,
                              onSubmitted: (value) {
                                _controller.text = value!;
                                address[key] = value!;
                              },
                              onChanged: (value) {
                                // _controller.text = value!;
                                // address[key] = value!;
                              },
                              decoration: Styles.PharmaFieldDecoration(
                                radius: 23.r,
                                hint:
                                    _formatName(address.keys.elementAt(index)),

                                // style: TextStyle(fontSize: 20),
                              ),
                            ));
                      }),

                  _isLoading
                      ? Container(
                          color: Colors.white,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Styles.colorPrimary,
                          )))
                      : SizedBox(height: 0, width: 0),
                  Container(
                    // padding: EdgeInsets.all(20),
                    // height: 150.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 32.h,
                        ),
                        // CommonSizes.hSmallSpace,
                        InkWell(
                          child: Container(
                              width: 280.w,
                              height: 54.h,
                              decoration: Styles.roundedDecoration.copyWith(
                                color: Styles.colorPrimary,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(27.r),
                                ),
                              ),
                              child: Center(
                                  child: Text(S.of(context).updateProfile,
                                      style: Styles.boldTextStyle.copyWith(
                                          fontSize: Styles.fontSize24,
                                          color: Colors.white)))),
                          onTap: () async {
                            this.setState(() {
                              _isLoading = true;
                            });
                            String? msg;
                            msg = await this
                                .widget
                                .updateCb(formatData())
                                .catchError((err) {
                              print(err);
                              msg = null;
                            });
                            this.setState(() {
                              _isLoading = false;
                            });

                            ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                                .showSnackBar(SnackBar(
                                    content: Text(
                                        msg ?? S.of(context).errorOccured)));
                            if (msg == "Updated") {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        InkWell(
                          child: Container(
                              width: 280.w,
                              height: 54.h,
                              color: Colors.transparent,
                              child: Center(
                                  child: Text(
                                S.of(context).cancel,
                                style: Styles.meduimTextStyle,
                              ))),
                          onTap: () => Navigator.pop(context),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                      ],
                    ),
                  ),

                  // _isLoading
                  //     ? Container(
                  //         color: Colors.white,
                  //         child: Center(child: CircularProgressIndicator()))
                  //     : SizedBox(height: 0, width: 0),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //
                  //   decoration: Styles.tilesDecoration,
                  //   // padding: EdgeInsets.all(20),
                  //   height: 150.h,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     crossAxisAlignment: CrossAxisAlignment.stretch,
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: ElevatedButton(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(20)),
                  //             side: BorderSide(
                  //               color: GrodudesPrimaryColor.primaryColor[700]!,
                  //               width: 2,
                  //             ),
                  //           ),
                  //           color: Colors.white,
                  //           child: Text(
                  //             S.of(context).cancel,
                  //             style: TextStyle(
                  //                 color: Colors.black87, fontSize: 16),
                  //           ),
                  //           onPressed: () => Navigator.pop(context),
                  //         ),
                  //       ),
                  //       CommonSizes.hSmallSpace,
                  //       Expanded(
                  //         child: ElevatedButton(
                  //           textColor: Colors.white,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(20)),
                  //           ),
                  //           child: Text(
                  //             S.of(context).update,
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold, fontSize: 16),
                  //           ),
                  //           onPressed: () async {
                  //
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            )));
      },
    );
  }
}
