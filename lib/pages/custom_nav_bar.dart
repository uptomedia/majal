import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../core/configurations/styles.dart';

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final bool isButton;
  final double navBarHeight;
  final List<ValueKey> keys;

  CustomNavBarWidget(
      {Key? key,
        required this.keys,
        required this.selectedIndex,
        required this.items,
        required this.onItemSelected,
        this.isButton: false,
        required this.navBarHeight});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, BuildContext context) {
    return  Container(
      // width: item.navBarHeight,
      // //color:item.isButton? Colors.black: Colors.white,
      // height: item.navBarHeight,
      decoration: item.isButton
          ? BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        gradient: LinearGradient(
//begin: Alignment.center,
          //    end: Alignment.bottomCenter,
          colors: [
            Color(0xFF53BFD7),
            Color(0xFF13A7C8),
            //  Color(0xFF00A78B)
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            //  offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      )
          : BoxDecoration(
        // color: Styles.ColorLiteGray6,
      ),

      alignment: Alignment.center,
      // height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        //  mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            key: key,
            flex: 4,
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0 ,
                  color: isSelected
                      ? (item.activeColorSecondary == null
                      ? item.activeColorPrimary
                      : item.activeColorSecondary)
                      : item.inactiveColorPrimary == null
                      ? item.activeColorPrimary
                      : item.inactiveColorPrimary),
              child: isSelected
                  ? item.icon
                  : item.inactiveIcon ?? item.icon,
            ),
          ),
          Flexible(
            flex: 2,
            child:  FittedBox(
              child: Text(
                item.title!,
                style:
                TextStyle(
                    color: isSelected
                        ? (item.activeColorSecondary == null
                            ? item.activeColorPrimary
                            : item.activeColorSecondary)
                        : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: Styles.fontSize12),
              ),
            )
           )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Styles.colorTertiary,
        boxShadow: [
          BoxShadow(
            // color: Styles.shadowColor,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              key: keys[index],
              onTap: () {
                this.onItemSelected(index);
              },
              child: _buildItem(item, selectedIndex == index, context),
            ),
          );
        }).toList(),
      ),
    );
  }
}
