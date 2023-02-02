import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:provider/provider.dart';

import '../../core/configurations/assets.dart';
import '../../core/configurations/styles.dart';
import '../../core/constants.dart';
import '../../core/widget/majl/majal_app_bar.dart';
import '../../l10n/locale_provider.dart';

class AddressUpdatePage extends StatefulWidget {
  late final Map<String, dynamic> address;
  late final Function updateCb;
  final bool? shouldDisplayPostcodeDropdown;
  AddressUpdatePage(
      {required this.address,
      required this.updateCb,
      this.shouldDisplayPostcodeDropdown});

  @override
  _AdressUpdatePageState createState() => _AdressUpdatePageState();
}

class _AdressUpdatePageState extends State<AddressUpdatePage> {
  final List<TextEditingController> _textEditingControllers = [];

  _capitalize(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}';
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

  List<DropdownMenuItem<String>> _getMenuCountryItems(String value) {
    List<String> tt = [];
    Provider.of<LocaleProvider>(context, listen: false).locale.languageCode ==
            "ar"
        ? Constants.ar.forEach((k, v) => tt.add(v))
        : Constants.en.forEach((k, v) => tt.add(v));

    List<DropdownMenuItem<String>> menuItems = tt
        .map(
          (e) => DropdownMenuItem<String>(
            child: Text(e),
            value: e,
          ),
        )
        .toList();

    if (pincodes.contains(value)) return menuItems;
    menuItems.add(DropdownMenuItem<String>(
      child: Text(S.of(context).choose),
      value: value,
    ));
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.address == null || widget.address.length == 0) {
      return Scaffold(
        appBar: AppBar(title: Text(S.of(context).updateYourAddressDetails)),
        body: Center(child: Text(S.of(context).addressNotFound)),
      );
    }
    return Scaffold(
        backgroundColor: Styles.colorBackGround,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min,
                    // scrollDirection: Axis.vertical,
                    children: [
              Container(
                // height: 25.h,
                // width: 360.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

                child: Row(
                  children: <Widget>[
                    SizedBox(
                        width: 13.w,
                        height: 13.w,
                        child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: SvgPicture.asset(
                                Assets.SVGArrow,
                                width: 26.w,
                                color: Styles.secondary2Color,
                              ),
                            ))),
                    SizedBox(
                      width: 110.w,
                    ),
                    // SizedBox(width: 16.w,),
                    Center(
                        child: Text(
                      "Review order",
                      textAlign: TextAlign.center,
                      style: Styles.boldTextStyle.copyWith(
                          color: Styles.secondary2Color,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700),
                    )),
                    // Center(child:
                    // ),
                    Expanded(child: Container())
                    // SizedBox(width: 16.w,),
                  ],
                ),
              ),
              SizedBox(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                child: Text(
                  S.of(context).updateYourAddressDetails,
                  style: Styles.boldTextStyle
                      .copyWith(fontSize: Styles.fontSize20),
                ),
              )),
              ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 21.h,
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                itemCount: widget.address.length,
                itemBuilder: (context, index) {
                  String key = widget.address.keys.elementAt(index);
                  String keyText =
                      key.split('_').map((e) => _capitalize(e)).join(' ');
                  TextEditingController _controller =
                      TextEditingController(text: widget.address[key] ?? '');
                  this._textEditingControllers.add(_controller);
                  if (widget.shouldDisplayPostcodeDropdown! &&
                      (key == 'postcode')) {
                    return Container(
                        height: 60.h,
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                        decoration: Styles.textFieldDecoration,

                        // padding: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),
                        child: TextField(
                          controller: _controller,
                          onChanged: (value) {
                            widget.address[key] = value!;
                          },
                          onSubmitted: (value) {
                            _controller.text = value!;
                            widget.address[key] = value!;
                          },
                          decoration: Styles.LoginFieldDecoration(
                            radius: 23.r,
                            hint: keyText,

                            // style: TextStyle(fontSize: 20),
                          ),
                        ));
                  } else if (key == 'country') {
                    return Container(
                        height: 60.h,
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                        child: DropdownButtonFormField<String>(
                          value: _controller.text,
                          isExpanded: true,
                          items: <DropdownMenuItem<String>>[
                            ..._getMenuCountryItems(_controller.text)
                          ],
                          onChanged: (value) => _controller.text = value!,
                          decoration: Styles.LoginFieldDecoration(
                              radius: 23.r,
                              hint: _formatName(
                                  widget.address.keys.elementAt(index))),
                          // border: OutlineInputBorder(
                          //     borderSide:
                          //     BorderSide(color: Colors.blue)),
                          // contentPadding: EdgeInsets.symmetric(
                          //     horizontal: 6, vertical: 2),
                          // ),
                          dropdownColor: Colors.white,
                          style: Styles.lightTextStyle
                              .copyWith(fontSize: Styles.fontSize18),
                        ));
                  }
                  return Container(
                      height: 60.h,
                      margin:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
                      decoration: Styles.textFieldDecoration,

                      // padding: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          widget.address[key] = value!;
                        },
                        onSubmitted: (value) {
                          _controller.text = value!;
                          widget.address[key] = value!;
                        },
                        decoration: Styles.LoginFieldDecoration(
                          radius: 23.r,
                          hint: keyText,

                          // style: TextStyle(fontSize: 20),
                        ),
                      ));
                },
              ),
              Container(

                  // padding: EdgeInsets.all(20),
                  // height: 150.h,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                    SizedBox(
                      height: 32.h,
                    ),
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
                                child: Text(S.of(context).update,
                                    style: Styles.boldTextStyle.copyWith(
                                        fontSize: Styles.fontSize24,
                                        color: Colors.white)))),
                        onTap: () async {
                          this.widget.updateCb(this.widget.address);
                          Navigator.pop(context);
                        }),
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

                    // Container(
                    //   height: 45,
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.stretch,
                    //     children: [
                    //       Expanded(
                    //         child: ElevatedButton(
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.zero,
                    //             side: BorderSide(
                    //               color: GrodudesPrimaryColor.primaryColor[700]!,
                    //               width: 2,
                    //             ),
                    //           ),
                    //           color: Colors.white,
                    //           child: Text(
                    //             S.of(context).cancel,
                    //             style: TextStyle(color: Colors.black87, fontSize: 16),
                    //           ),
                    //           onPressed: () => Navigator.pop(context),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         child: ElevatedButton(
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.zero,
                    //           ),
                    //           child: Text(
                    //             S.of(context).update,
                    //             style: TextStyle(color: Colors.white, fontSize: 16),
                    //           ),
                    //           onPressed: () {
                    //             this.updateCb(this.address);
                    //             Navigator.pop(context);
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ]))
            ]))));
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
      default:
        {
          s = "not defined";
        }
    }

    return s;
  }
}
