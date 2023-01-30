import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:intl/intl.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';

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
    return
      // !item.isButton?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 11.h,),
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
                         ?Styles.colorPrimary:Styles.colorSecondary,
                    fontWeight: FontWeight.w400,
                    fontSize: Styles.fontSize12),
              ),
            )
        ),
          SizedBox(height: 10.h,),
          Container(width: 40.w,
          height: 2.h,
          color: isSelected?Styles.colorPrimary:Colors.transparent,)

      ],);
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,


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
