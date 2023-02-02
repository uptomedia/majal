import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/core/shared_preferences_items.dart';
import 'package:grodudes/core/widget/custom/custom_drop_down.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/l10n/locale_provider.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../core/configurations/assets.dart';
import '../../core/utils.dart';
import '../../routing/route_paths.dart';
import '../navigation.dart';

final InputDecoration defaultTextFieldDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.grey[600]),
  alignLabelWithHint: true,
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
    color: GrodudesPrimaryColor.primaryColor[600]!,
    width: 2,
  )),
  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late String action;
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  List<String> Languages = [
    "English",
    "العربية",
  ];
  List<String> selectedLanguges = [];
  String _chosenValue = "English";
  int _selectedIndex = 0;
  late SharedPreferences _spf;
  _initfAsync() async {
    _spf = await SharedPreferences.getInstance();

    setState(() {
      _selectedIndex = _spf.getInt(SharedPreferencesKeys.LanguageIndex) ?? 0;
      _chosenValue = getStringValue(_selectedIndex + 1);
    });
  }

  @override
  void initState() {
    this._usernameController = new TextEditingController();
    this._passwordController = new TextEditingController();
    this._emailController = new TextEditingController();
    _usernameController.text = "yousef";
    _passwordController.text = "yousef123";
    this.action = 'login';
    _initfAsync();
    super.initState();
  }

  @override
  void dispose() {
    this._usernameController.dispose();
    this._passwordController.dispose();
    this._emailController.dispose();
    super.dispose();
  }

  Widget getFormInputField(
      String title, TextEditingController inputController) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 60.h,
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
      decoration: Styles.textFieldDecoration,
      child: TextField(
        decoration: Styles.LoginFieldDecoration(
          radius: 22.r,
          // labelText: title,
          hint: title,
          // color: Styles.colorPrimary          // prefixIcon: title == S.of(context).username
          //     ? Icon(Icons.account_circle, color: Colors.grey[700])
          //     : title == S.of(context).email
          //         ? Icon(Icons.email, color: Colors.grey[700])
          //         : Icon(Icons.security, color: Colors.grey[700]),
        ),
        controller: inputController,

        // style: TextStyle(fontSize: 20),

        style: Styles.lightTextStyle.copyWith(
            fontSize: Styles.fontSize14,
            fontWeight: FontWeight.w400,
            color: Styles.FontColorBlackDark),
      ),
    );
  }

  _handleFormSubmit() {
    bool valuesAvailable = true;
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
    if (this._usernameController.text.length == 0 ||
        this._passwordController.text.length == 0) {
      valuesAvailable = false;
    }
    if (this.action == 'register' && this._emailController.text.length == 0) {
      valuesAvailable = false;
    }
    if (valuesAvailable == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).pleaseFillAllTheFields),
        ),
      );
      return;
    }
    if (this.action == 'login') {
      Provider.of<UserManager>(context, listen: false)
          .logInToWordpress(
              this._usernameController.text, this._passwordController.text)
          .then((value) {
        if (value) {
          Utils.pushReplacementNavigateTo(
            context,
            //false,
            RoutePaths.NavigationScreen,
            // arguments: 0
          );

          // Navigator.pushReplacementNamed(context, '/NavigationScreen');

        }
      }).catchError((err) {
        print(err);
      });
      {}
    } else if (this.action == 'register') {
      Provider.of<UserManager>(context, listen: false)
          .registerNewUser(
        this._usernameController.text,
        this._emailController.text,
        this._passwordController.text,
      )
          .catchError((err) {
        print(err);
      });
    } else if (this.action == 'forget password') {
      // Provider.of<UserManager>(context, listen: false)
      //     .resetPassword(
      //   this._usernameController.text,
      //  )
      //     .catchError((err) {
      //   print(err);
      // });
    }
  }

  Widget _getErrorPrompt() {
    Map<String, dynamic>? wpUserInfo =
        Provider.of<UserManager>(context, listen: false).wpUserInfo;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0x39ff0000),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[300]!, width: 2),
      ),
      child: Text(
          wpUserInfo!['errMsg'] ?? S.of(context).loginFailedPleaseTryAgain),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.colorBackGround,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 137.h,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 37.w),
                  // height: 40.h,
                  // width: 420.w,
                  child: Center(
                    child: Text("Pharma Logo",
                        textAlign: TextAlign.center,
                        style: Styles.boldTextStyle.copyWith(
                            fontSize: Styles.fontSize31,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff96C43D))),
                  ),
                ),
                SizedBox(
                  height: 57.h,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 37.w),
                  // height: 40.h,
                  // width: 420.w,
                  child: Text(
                    this.action == 'login'
                        ? "welcome" //S.of(context).welcomeback
                        : this.action == 'forget password'
                            ? S.of(context).forgetPassword
                            : "welcome", //S.of(context).welcome,
                    style: Styles.boldTextStyle.copyWith(
                        fontSize: Styles.fontSize24,
                        fontWeight: FontWeight.w700,
                        color: Styles.FontColorBlackDark),
                  ),
                ),
                // SizedBox(height: 5.h),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 37.w),
                  // height: 40.h,
                  // width: 420.w,
                  child: Text(
                    this.action == 'login'
                        ? "login" //S.of(context).signInToYourAccount
                        : this.action == 'forget password'
                            ? S.of(context).forgetPassword
                            : "create account", //S.of(context).signInOrCreateNewAccount,
                    style: Styles.regularTextStyle.copyWith(
                        fontSize: Styles.fontSize20,
                        fontWeight: FontWeight.w600,
                        color: Styles.FontColorBlackDark),
                  ),
                ),
                SizedBox(height: 31.h),
                if (this.action != 'forget password')
                  getFormInputField(
                      S.of(context).username, this._usernameController),
                SizedBox(height: 35.h),
                if (this.action != 'forget password')
                  _PasswordFromInputRow(this._passwordController),
                this.action == 'login'
                    ? SizedBox(height: 0)
                    : this.action == 'forget Password'
                        ? SizedBox(height: 0)
                        : SizedBox(height: 35.h),
                this.action == 'login'
                    ? SizedBox(height: 0)
                    : this.action == 'forget Password'
                        ? SizedBox(height: 0)
                        : getFormInputField(
                            S.of(context).email, this._emailController),
                SizedBox(height: 33.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
// SizedBox(width:44.w,),
//                 if (this.action == 'login')
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //
                    //     InkWell(
                    //         onTap: (){
                    //           setState(() {
                    //             this.action = 'login';
                    //             _launchInBrowser(Uri(
                    //                 scheme: 'https',
                    //                 host: 'majalpharma.com',
                    //                 path: "/my-account/lost-password/"));
                    //           });
                    //         },
                    //         child:
                    //     Container(
                    //       width: 170.w,
                    //         child:
                    //     Text(
                    //       S.of(context).forgetPassword,
                    //       style: Styles.regularTextStyle.copyWith(
                    //         fontSize: Styles.fontSize17,
                    //         color: Styles.loginFontColor
                    //       ),
                    //     ))),
                    //
                    //      SizedBox(width:24.w,),
                    //   ],
                    // ),

                    Expanded(
                        child: InkWell(
                            onTap: _handleFormSubmit,
                            child: Container(
                                height: 60.h,
                                margin: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 37.w),

                                // height: 60.h,
                                decoration: Styles.roundedDecoration.copyWith(
                                  color: Styles.colorPrimary,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(23.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    this.action == 'login'
                                        ? 'Login' //S.of(context).signIn
                                        : this.action == 'forget password'
                                            ? S.of(context).resetPassword
                                            : S.of(context).signUp,
                                    style: Styles.meduimTextStyle.copyWith(
                                        fontSize: Styles.fontSize20,
                                        fontWeight: FontWeight.w700,
                                        color: Styles.ColorWhite),
                                  ),
                                ))))
                    // SizedBox(width:37.w,),
                  ],
                ),
                //
                Provider.of<UserManager>(context).getLogInStatus() ==
                        logInStates.logInFailed
                    ? SizedBox(height: 20.h)
                    : SizedBox(height: 0),
                Provider.of<UserManager>(context).getLogInStatus() ==
                        logInStates.logInFailed
                    ? Center(child: _getErrorPrompt())
                    : SizedBox(height: 0.h),
                SizedBox(
                  height: 21.h,
                ),
// if(this.action == 'register')SizedBox(height: 40.h,),
                Center(
                    child: Container(
                  // padding: EdgeInsets.symmetric(horizontal:20.w ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(width:62.w,),
                      Text(
                        this.action == 'login'
                            ? S.of(context).youDontHaveAccount
                            : this.action == 'forget password'
                                ? ""
                                : S.of(context).alreadyHaveAccountSignin,
                        style: Styles.regularTextStyle.copyWith(
                            fontSize: Styles.fontSize16,
                            fontWeight: FontWeight.w500,
                            color: Styles.colorFontColorDark),
                      ),
                      MaterialButton(
                        child: Text(
                          this.action == 'login'
                              ? "Create account" //S.of(context).signUp
                              : this.action == 'forget password'
                                  ? ""
                                  : S.of(context).signIn,
                          style: Styles.meduimTextStyle.copyWith(
                              fontSize: Styles.fontSize16,
                              fontWeight: FontWeight.w500,
                              // color: Styles.colorFontColorDark
                              color: Color(0xff1948EF)),
                        ),
                        onPressed: () => setState(() {
                          this.action = this.action == 'login'
                              ? 'register'
                              : this.action == "forget password"
                                  ? 'register'
                                  : 'login';
                        }),
                      )
                    ],
                  ),
                )),
                SizedBox(
                  height: 52.h,
                )
                // SizedBox(height: 10.h),
                // _buidLanguage()
              ],
            ),
          )),
        ));
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
          return S.of(context).german;
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
}

class _PasswordFromInputRow extends StatefulWidget {
  final TextEditingController inputController;
  _PasswordFromInputRow(this.inputController);
  @override
  __PasswordFromInputRowState createState() => __PasswordFromInputRowState();
}

class __PasswordFromInputRowState extends State<_PasswordFromInputRow> {
  final String title = "password";
  late bool isObscured;
  @override
  void initState() {
    this.isObscured = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: 353.w,
      height: 60.h,
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 37.w),
      decoration: Styles.textFieldDecoration,
      child: TextField(
          obscureText: isObscured,
          decoration: Styles.LoginFieldDecoration().copyWith(
            hintText: title,
            hintStyle: Styles.lightTextStyle.copyWith(
                color: Styles.FontColorBlackDark,
                fontSize: Styles.fontSize14,
                fontWeight: FontWeight.w400),

            // errorBorder: Styles.roundedOutlineInputBorder(radius: 18.r)
            //     .copyWith(borderSide: BorderSide(color: Colors.red)),
            // focusedErrorBorder: Styles.roundedOutlineInputBorder(radius: 18.r)
            //     .copyWith(borderSide: BorderSide(color: Colors.red)),
            // disabledBorder: Styles.roundedOutlineInputBorder(radius: 18.r),
            // contentPadding: EdgeInsets.symmetric(horizontal: 34.w,vertical: 17.h),
            // filled: true,
            // // fillColor:  Styles.colorBackGround,

            suffixIcon: GestureDetector(
              child: Icon(Icons.remove_red_eye,
                  color: !isObscured
                      ? Styles.FontColorBlackDark
                      : Styles.FontColorBlackDark.withOpacity(0.5)),
              onTap: () => setState(() => this.isObscured = !this.isObscured),
            ),
          ),
          controller: widget.inputController,
          style: Styles.lightTextStyle.copyWith(
              fontSize: Styles.fontSize14,
              fontWeight: FontWeight.w400,
              color: Styles.FontColorBlackDark)),
    );
  }
}
