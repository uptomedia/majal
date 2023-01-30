import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grodudes/generated/l10n.dart';

import '../Root.dart';
import 'CartItems.dart';
import 'account/AccountRoot.dart';

class Tabbar extends StatefulWidget {
  int currentIndex;
  Tabbar({this.currentIndex:0});

  static const Tag = "Tabbar";
  @override
  State<StatefulWidget> createState() {
    return _TabbarState();
  }
}

class _TabbarState extends State<Tabbar> {
   late Widget currentScreen;
  List<Widget> _buildScreens() {
    return [
      Root(),
      CartItems(),
      AccountRoot()
      // ProfilePage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: _buildScreens(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: widget.currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(CupertinoIcons.home),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            tooltip: S.of(context).cart,
            icon: new Icon(CupertinoIcons.cart),
            label: S.of(context).cart,
          ),
          BottomNavigationBarItem(
            icon: new Icon(CupertinoIcons.profile_circled),
            label: S.of(context).profile,
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }
}
