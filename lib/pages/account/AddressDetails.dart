import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/core/constants.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:provider/provider.dart';

import '../../core/widget/majl/majal_app_bar.dart';
import 'package:country_picker/country_picker.dart';

import '../../l10n/locale_provider.dart';

class AddressDetails extends StatefulWidget {
  final String title;
  final String type;
  final Future<String> Function(List<Map<String, dynamic>>) updateCb;

  AddressDetails({
    required this.title,
    required this.type,
    required this.updateCb,
  });

  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  Map<String, TextEditingController> _textControllers = {};
  Map<String, TextEditingController> _textControllersShipping = {};
  bool _isLoading = false;
  bool _withshipping = false;

  @override
  void initState() {
    this._textControllers = {};
    this._textControllersShipping = {};
    _isLoading = false;
    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    this._textControllers.values.forEach((element) {  element.dispose();
    });
    this._textControllersShipping.values.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  capitalize(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  List<Map<String, dynamic>> formatData() {
    Map<String, dynamic> data = {};
    Map<String, dynamic> dataShip = {};
    this._textControllers.keys.forEach((key) {
      data[key] = this._textControllers[key]!.text;
    });
    if(_withshipping)
      { this._textControllersShipping.keys.forEach((key) {
        dataShip[key] = this._textControllersShipping[key]!.text;
      });

      }
    return [data,dataShip];
  }

  String _formatName(String name) {

    return getString(name);

      // name.split('_').map((e) => capitalize(e)).join(' ');
  }
String getString (String name){
    String s="";

    switch(name){
      case "first_name":
        s=S.of(context).first_name;
        break;
      case "last_name":
        s=S.of(context).last_name;
        break;
  case "company":
  s=S.of(context).company;
  break;
  case "address_1":
  s=S.of(context).address_1;
  break;
  case "address_2":
  s=S.of(context).address_2;
  break;
  case "city":
  s=S.of(context).city;
  break;
  case "postcode":
  s=S.of(context).postcode;
  break;
  case "country":
  s=S.of(context).country;
  break;
   case "state":
  s=S.of(context).state;
  break; case "email":
  s=S.of(context).email;
  break; case "phone":
  s=S.of(context).phone;
  break;
      default: {
        s="not defined";
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
  List<DropdownMenuItem<String>> _getMenuCountryItems(String value) {


    List<String> tt=[];
    Provider
        .of<LocaleProvider>(context, listen: false)
        .locale
        .languageCode == "ar" ?  Constants.ar.forEach((k, v) => tt.add(v))
        :  Constants.en.forEach((k, v) => tt.add(v));


    List<DropdownMenuItem<String>> menuItems = tt
        .map(
          (  e) => DropdownMenuItem<String>(
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

  final headerTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  Map<String, dynamic> address = {};
  Map<String, dynamic> addressShip = {};
  @override
  Widget build(BuildContext context) {
    return Consumer<UserManager>(
      builder: (context, user, child) {

        if (address == null || address.length == 0)
          address = user.wcUserInfo![widget.type];
        if(addressShip == null || addressShip.length == 0){
          addressShip.addAll(
            user.wcUserInfo!["shipping"]);
        }
        // print(address);
        if (address == null || address.length == 0) {
          return Scaffold(
key: _scaffoldKey,
            body:

            SafeArea(child:
            SingleChildScrollView(
                child:
                Container(

                  alignment: Alignment.center,

                  child: Column(
                    // scrollDirection: Axis.vertical,
                      children: [
                        MajalAppBar(
                          withBack: true,

                        ),

                        SizedBox(child:
                        Center(
                          child: Text(widget.title,
                            style: Styles.boldTextStyle,),
                        )),
                        SizedBox(
                          height: 100.h,
                        ),
                        Text(
                          S.of(context).somethingWentWrong,
                          style:Styles.boldTextStyle,
                          textAlign: TextAlign.center,
                        ),

                      ]
                  ),
                )
            )
            )

          );
        }
        return Scaffold(
          backgroundColor: Styles.colorBackGround,
key: _scaffoldKey,
          body:SafeArea(child:

          SingleChildScrollView  (child:

                  Column(
                        mainAxisSize: MainAxisSize.min,
                      // scrollDirection: Axis.vertical,
                        children: [
                          MajalAppBar(
                            withBack: true,

                          ),

                          SizedBox(child:
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),

                            child: Text(widget.title,
                              style: Styles.boldTextStyle,),
                          )
                          ),
                          Container(
                              // height: 500,
                              child:

                          ListView.separated(

                             separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 21.h,
                              );
                            },
                              shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics() ,
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
                                margin: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),

                                decoration: Styles.textFieldDecoration,

                                // padding: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),
                                child:
                                  address.keys.elementAt(index) == 'postcode' &&
                                          widget.type == 'shipping'
                                          ? TextField(


                                    controller: _controller,

                                    onSubmitted: (value) {
                                      _controller.text = value!;
                                      address[key] = value!;
                                    },
                                    onChanged: (value){
                                      // _controller.text = value!;
                                      address[key] = value!;
                                    },
                                    keyboardType:TextInputType.number ,
                                    decoration:  Styles.PharmaFieldDecoration(radius: 23.r,
                                      hint: _formatName(address.keys.elementAt(index)),

                                      // style: TextStyle(fontSize: 20),
                                    ),)
                                          :

                                  address.keys.elementAt(index) == 'country'?

                                 Expanded(
                                   // height: 60.h,
                                   child:
                                  DropdownButtonFormField<String>(
 isExpanded: true,
                                    value: _controller.text,
                                    items: <DropdownMenuItem<String>>[
                                      ..._getMenuCountryItems(_controller.text)
                                    ],
                                    onChanged: (value) =>
                                    _controller.text = value!,
                                    decoration:Styles.PharmaFieldDecoration(radius: 23.r,
                                        hint: _formatName(address.keys.elementAt(index))
                                    ),
                                    // border: OutlineInputBorder(
                                    //     borderSide:
                                    //     BorderSide(color: Colors.blue)),
                                    // contentPadding: EdgeInsets.symmetric(
                                    //     horizontal: 6, vertical: 2),
                                    // ),
                                    dropdownColor: Colors.white,
                                    style: Styles.lightTextStyle.copyWith(
                                        fontSize: Styles.fontSize18
                                    ),
                                  )
                                   ,)
                                  :TextField(


                                        controller: _controller,

                                        onSubmitted: (value) {
                                          _controller.text = value!;
                                          address[key] = value!;
                                        },
                                        onChanged: (value){
                                          // _controller.text = value!;
                                           address[key] = value!;
                                        },
                                      decoration:  Styles.PharmaFieldDecoration(radius: 23.r,
                                        hint: _formatName(address.keys.elementAt(index)),

                                        // style: TextStyle(fontSize: 20),
                                      ),)



                              );
                            },
                          )),
                          _isLoading
                              ? Container(
                              color: Colors.white,
                              child: Center(child: CircularProgressIndicator(color: Styles.colorPrimary,)))
                              : SizedBox(height: 0, width: 0),

                          SizedBox(height: 29.h,),
                          // if(!_withshipping)
                          //   InkWell(
                          //   child: Container(
                          //       width: 280.w,
                          //       height: 54.h,
                          //       color: Colors.transparent,
                          //
                          //       child:
                          //       Center(child:
                          //       Row(children: [
                          //
                          //
                          //       Icon(Icons.add,color: Styles.colorPrimary,),
                          //       Text(
                          //         S.of(context).addAnotherBillingAddress,
                          //         style:  Styles.regularTextStyle.copyWith(fontSize: Styles.fontSize18,color: Styles.colorPrimary),
                          //       )
                          //       ],))),
                          //   onTap: () =>
                          //       Navigator.pop(context),
                          // ),
if(_withshipping)
  SizedBox(child:
  Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),

    child: Text(widget.title,
      style: Styles.boldTextStyle,),
  )
  ),
                          if(_withshipping)

                            Container(
                            // height: 500,
                              child:

                              ListView.separated(

                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 21.h,
                                  );
                                },
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics() ,
                                itemCount: addressShip.keys.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final key = addressShip.keys.elementAt(index);

                                  final text = addressShip[key];

                                  TextEditingController _controllerShipping;
                                  _controllerShipping = TextEditingController(text: text);
                                  this._textControllersShipping[key] = _controllerShipping;

                                  return Container(
                                      height: 60.h,
                                      margin: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),

                                      decoration: Styles.textFieldDecoration,

                                      // padding: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),
                                      child:
                                      addressShip.keys.elementAt(index) == 'postcode'
                                          ?TextField(


                                        controller: _controllerShipping,

                                        onSubmitted: (value) {
                                          _controllerShipping.text = value!;
                                          address[key] = value!;
                                        },
                                        onChanged: (value){
                                          // _controller.text = value!;
                                          address[key] = value!;
                                        },
                                        keyboardType:TextInputType.number ,
                                        decoration:  Styles.PharmaFieldDecoration(radius: 23.r,
                                          hint: _formatName(address.keys.elementAt(index)),

                                          // style: TextStyle(fontSize: 20),
                                        ),)
                                          :

                                      address.keys.elementAt(index) == 'country'?

                                      DropdownButtonFormField<String>(
                                        value: _controllerShipping.text,
                                        items: <DropdownMenuItem<String>>[
                                          ..._getMenuCountryItems(_controllerShipping.text)
                                        ],
                                        onChanged: (value) =>
                                        _controllerShipping.text = value!,
                                        decoration:Styles.PharmaFieldDecoration(radius: 23.r,
                                            hint: _formatName(address.keys.elementAt(index))
                                        ),
                                        // border: OutlineInputBorder(
                                        //     borderSide:
                                        //     BorderSide(color: Colors.blue)),
                                        // contentPadding: EdgeInsets.symmetric(
                                        //     horizontal: 6, vertical: 2),
                                        // ),
                                        dropdownColor: Colors.white,
                                        style: Styles.lightTextStyle.copyWith(
                                            fontSize: Styles.fontSize18
                                        ),
                                      )
                                          : TextField(


                                        controller: _controllerShipping,

                                        onSubmitted: (value) {
                                          _controllerShipping.text = value!;
                                          address[key] = value!;
                                        },
                                        onChanged: (value){
                                          // _controller.text = value!;
                                          // address[key] = value!;
                                          addressShip[key]=value;
                                        },
                                        decoration:  Styles.PharmaFieldDecoration(radius: 23.r,
                                          hint: _formatName(address.keys.elementAt(index)),

                                          // style: TextStyle(fontSize: 20),
                                        ),)



                                  );
                                },
                              )),

                          if(_withshipping)
                            _isLoading
                              ? Container(
                              color: Colors.white,
                              child: Center(child: CircularProgressIndicator(color: Styles.colorPrimary,)))
                              : SizedBox(height: 0, width: 0),

                          if(_withshipping)
                            SizedBox(height: 29.h,),
                          InkWell(
                            child: Container(
                                width: 280.w,
                                height: 54.h,
                                color: Colors.transparent,

                                child:
                                Center(child:
                                Row(children: [


                                  if(!_withshipping)
                                    Icon(Icons.add,color: Styles.colorPrimary,),
                                  Text(
        !_withshipping? S.of(context).addAnotherBillingAddress:S.of(context).removeThisBillingAddress,
                                    style:  Styles.regularTextStyle.copyWith(

                                        fontSize: Styles.fontSize18,
                                        color: _withshipping?Styles.colorDeleteBackground:Styles.colorPrimary),
                                  )
                                ],))),
                            onTap: () =>
                              setState(() {
                                _withshipping=!_withshipping;
                              }),
                          ),

                  Container(

           // padding: EdgeInsets.all(20),
          // height: 150.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 32.h,),
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
        child:
        Center(child: Text(
                    S.of(context).update,
            style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize24,color: Colors.white)

        ))),
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

                    _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content: Text(msg ?? S.of(context).errorOccured)));
                    if (msg == "Updated") {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              SizedBox(height: 15.h,),
              InkWell(
                child: Container(
                    width: 280.w,
                    height: 54.h,
color: Colors.transparent,

                    child:
                    Center(child: Text(
                      S.of(context).cancel,
                      style:Styles.meduimTextStyle,
                    ))),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 32.h,),
            ],
          ),
        )
                        ]
                    ),


                ),
          )

          // bottomNavigationBar: Builder(builder: (context) {
          //   return
          // }),
        );
      },
    );
    return Consumer<UserManager>(
      builder: (context, user, child) {
        Map<String, dynamic> address = {};
        Map<String, dynamic> addressShip = {};
        if (address == null || address.length == 0)
          address = user.wcUserInfo![widget.type];
        if(addressShip == null || addressShip.length == 0){
          address.addAll(
            user.wcUserInfo!["shipping"]);
        }
        // print(address);
        if (address == null || address.length == 0) {
          return Scaffold(

            body:

            SafeArea(child:
            SingleChildScrollView(
                child:
                Container(

                  alignment: Alignment.center,

                  child: Column(
                    // scrollDirection: Axis.vertical,
                      children: [
                        MajalAppBar(
                          withBack: true,

                        ),

                        SizedBox(child:
                        Center(
                          child: Text(widget.title,
                            style: Styles.boldTextStyle,),
                        )),
                        SizedBox(
                          height: 100.h,
                        ),
                        Text(
                          S.of(context).somethingWentWrong,
                          style:Styles.boldTextStyle,
                          textAlign: TextAlign.center,
                        ),

                      ]
                  ),
                )
            )
            )

          );
        }
        return Scaffold(
          backgroundColor: Styles.colorBackGround,

          body:SafeArea(child:

          SingleChildScrollView  (child:

                  Column(
                        mainAxisSize: MainAxisSize.min,
                      // scrollDirection: Axis.vertical,
                        children: [
                          MajalAppBar(
                            withBack: true,

                          ),

                          SizedBox(child:
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),

                            child: Text(widget.title,
                              style: Styles.boldTextStyle,),
                          )
                          ),
                          Container(
                              // height: 500,
                              child:

                          ListView.separated(

                             separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 21.h,
                              );
                            },
                              shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics() ,
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
                                margin: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),

                                decoration: Styles.textFieldDecoration,

                                // padding: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),
                                child:
                                  address.keys.elementAt(index) == 'postcode' &&
                                          widget.type == 'shipping'
                                          ? DropdownButtonFormField<String>(
                                        value: _controller.text,
                                        items: <DropdownMenuItem<String>>[
                                          ..._getMenuItems(_controller.text)
                                        ],
                                        onChanged: (value) =>
                                        _controller.text = value!,
                                        decoration:Styles.PharmaFieldDecoration(radius: 23.r,
                                          hint: _formatName(address.keys.elementAt(index))
                                        ),
                                          // border: OutlineInputBorder(
                                          //     borderSide:
                                          //     BorderSide(color: Colors.blue)),
                                          // contentPadding: EdgeInsets.symmetric(
                                          //     horizontal: 6, vertical: 2),
                                        // ),
                                    dropdownColor: Colors.white,
                                        style: Styles.lightTextStyle.copyWith(
                                          fontSize: Styles.fontSize18
                                        ),
                                      )
                                          : TextField(


                                        controller: _controller,

                                        onSubmitted: (value) {
                                          _controller.text = value!;
                                          address[key] = value!;
                                        },
                                        onChanged: (value){
                                          // _controller.text = value!;
                                           address[key] = value!;
                                        },
                                      decoration:  Styles.PharmaFieldDecoration(radius: 23.r,
                                        hint: _formatName(address.keys.elementAt(index)),

                                        // style: TextStyle(fontSize: 20),
                                      ),)



                              );
                            },
                          )),
                          _isLoading
                              ? Container(
                              color: Colors.white,
                              child: Center(child: CircularProgressIndicator(color: Styles.colorPrimary,)))
                              : SizedBox(height: 0, width: 0),

                          SizedBox(height: 29.h,),
                          // if(!_withshipping)
                          //   InkWell(
                          //   child: Container(
                          //       width: 280.w,
                          //       height: 54.h,
                          //       color: Colors.transparent,
                          //
                          //       child:
                          //       Center(child:
                          //       Row(children: [
                          //
                          //
                          //       Icon(Icons.add,color: Styles.colorPrimary,),
                          //       Text(
                          //         S.of(context).addAnotherBillingAddress,
                          //         style:  Styles.regularTextStyle.copyWith(fontSize: Styles.fontSize18,color: Styles.colorPrimary),
                          //       )
                          //       ],))),
                          //   onTap: () =>
                          //       Navigator.pop(context),
                          // ),
if(_withshipping)
  SizedBox(child:
  Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),

    child: Text(widget.title,
      style: Styles.boldTextStyle,),
  )
  ),
                          if(_withshipping)

                            Container(
                            // height: 500,
                              child:

                              ListView.separated(

                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 21.h,
                                  );
                                },
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics() ,
                                itemCount: addressShip.keys.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final key = addressShip.keys.elementAt(index);

                                  final text = addressShip[key];

                                  TextEditingController _controllerShipping;
                                  _controllerShipping = TextEditingController(text: text);
                                  this._textControllersShipping[key] = _controllerShipping;

                                  return Container(
                                      height: 60.h,
                                      margin: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),

                                      decoration: Styles.textFieldDecoration,

                                      // padding: EdgeInsets.symmetric(vertical: 0, horizontal:37.w),
                                      child:
                                      address.keys.elementAt(index) == 'postcode'
                                          ? DropdownButtonFormField<String>(
                                        value: _controllerShipping.text,
                                        items: <DropdownMenuItem<String>>[
                                          ..._getMenuItems(_controllerShipping.text)
                                        ],
                                        onChanged: (value) =>
                                        _controllerShipping.text = value!,
                                        decoration:Styles.PharmaFieldDecoration(radius: 23.r,
                                            hint: _formatName(address.keys.elementAt(index))
                                        ),
                                        // border: OutlineInputBorder(
                                        //     borderSide:
                                        //     BorderSide(color: Colors.blue)),
                                        // contentPadding: EdgeInsets.symmetric(
                                        //     horizontal: 6, vertical: 2),
                                        // ),
                                        dropdownColor: Colors.white,
                                        style: Styles.lightTextStyle.copyWith(
                                            fontSize: Styles.fontSize18
                                        ),
                                      )
                                          : TextField(


                                        controller: _controllerShipping,

                                        onSubmitted: (value) {
                                          _controllerShipping.text = value!;
                                          address[key] = value!;
                                        },
                                        onChanged: (value){
                                          // _controller.text = value!;
                                          // address[key] = value!;
                                          addressShip[key]=value;
                                        },
                                        decoration:  Styles.PharmaFieldDecoration(radius: 23.r,
                                          hint: _formatName(address.keys.elementAt(index)),

                                          // style: TextStyle(fontSize: 20),
                                        ),)



                                  );
                                },
                              )),

                          if(_withshipping)
                            _isLoading
                              ? Container(
                              color: Colors.white,
                              child: Center(child: CircularProgressIndicator(color: Styles.colorPrimary,)))
                              : SizedBox(height: 0, width: 0),

                          if(_withshipping)
                            SizedBox(height: 29.h,),
                          InkWell(
                            child: Container(
                                width: 280.w,
                                height: 54.h,
                                color: Colors.transparent,

                                child:
                                Center(child:
                                Row(children: [


                                  if(!_withshipping)
                                    Icon(Icons.add,color: Styles.colorPrimary,),
                                  Text(
        !_withshipping? S.of(context).addAnotherBillingAddress:S.of(context).removeThisBillingAddress,
                                    style:  Styles.regularTextStyle.copyWith(

                                        fontSize: Styles.fontSize18,
                                        color: _withshipping?Styles.colorDeleteBackground:Styles.colorPrimary),
                                  )
                                ],))),
                            onTap: () =>
                              setState(() {
                                _withshipping=!_withshipping;
                              }),
                          ),

                  Container(

           // padding: EdgeInsets.all(20),
          // height: 150.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 32.h,),
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
        child:
        Center(child: Text(
                    S.of(context).update,
            style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize24,color: Colors.white)

        ))),
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

                    _scaffoldKey.currentState!.showSnackBar(SnackBar(
                        content: Text(msg ?? S.of(context).errorOccured)));
                    if (msg == "Updated") {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              SizedBox(height: 15.h,),
              InkWell(
                child: Container(
                    width: 280.w,
                    height: 54.h,
color: Colors.transparent,

                    child:
                    Center(child: Text(
                      S.of(context).cancel,
                      style:Styles.meduimTextStyle,
                    ))),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(height: 32.h,),
            ],
          ),
        )
                        ]
                    ),


                ),
          )

          // bottomNavigationBar: Builder(builder: (context) {
          //   return
          // }),
        );
      },
    );
  }


}
