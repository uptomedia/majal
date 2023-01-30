import 'package:flutter/material.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/pages/account/AccountDetails.dart';
import 'package:grodudes/pages/account/LogInPage.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:provider/provider.dart';

class AccountRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackGround,

      // appBar: AppBar(),
      body: Consumer<UserManager>(
        builder: (context, user, child) {
          var logInStatus = user.getLogInStatus();
          return SafeArea(
              child: Container(
            child: Stack(
              children: <Widget>[

                logInStatus == logInStates.loggedIn
                    ? AccountDetails()
                    : LoginPage(),
                logInStatus == logInStates.pending
                    ? Container(
                        color: Colors.white,
                        child: Center(child: CircularProgressIndicator(color: Styles.colorPrimary,),
                      ))
                    : SizedBox(height: 0, width: 0)
              ],
            ),
          ));
        },
      ),
    );
  }
}
