import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/core/configurations/styles.dart';

import '../../constants.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String title;
  final Color titleColor;
  final Color hintColor;
  final FontWeight titleWeight;
  final double titleSize;
  final Color borderColor;
  final double cornerRadius;
  final Function valueChanged;
  final String initValue;
  final double width;
  final Color menuBackground;
  final bool enabled;
  final bool hasBorder;

  final bool withIcon;

  const CustomDropDown(
      {Key? key,
      this.enabled: true,
      required this.items,
      this.withIcon = false,
      required this.title,
      required this.borderColor,
      required this.titleColor,
      this.cornerRadius = 25,
      required this.initValue,
      required this.valueChanged,
      required this.width,
      required this.menuBackground,
      this.hasBorder = false,
      required this.titleWeight,
      required this.titleSize,
      required this.hintColor})
      : super(key: key);

  @override
  _CustomDropDownState createState() {
    return _CustomDropDownState();
  }
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String code = Constants.currentLocale ?? "en";
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.cornerRadius),
        ),
        border: Border.all(
            color: widget.hasBorder ? Styles.colorPrimary : widget.borderColor),
        color: widget.borderColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   width: CommonSizes.BIG_LAYOUT_W_GAP.w,
          // ),
          Expanded(
            child: DropdownButton<String>(
              value: widget.initValue,
              hint: Text(
                widget.title,
                style: TextStyle(
                  color: widget.hintColor ?? Colors.black,
                  fontWeight: widget.titleWeight ?? FontWeight.w300,
                  fontSize: widget.titleSize ?? Styles.fontSize11,
                ),
              ),
              style: TextStyle(
                  fontFamily: Styles.FontFamily,
                  color: widget.titleColor,
                  fontWeight: widget.titleWeight ?? FontWeight.w500,
                  fontSize: widget.titleSize ?? Styles.fontSize11),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
                widget.valueChanged.call(widget.items.indexOf(dropdownValue));
              },
              underline: Container(),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down,
                  color: Styles.ColorWhite //widget.titleColor,
                  ),
              items: widget.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  key: ValueKey<String>(value),
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: Styles.FontFamily,
                      color: widget.titleColor,
                      fontWeight: widget.titleWeight,
                      fontSize: widget.titleSize,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  int getIndex(String value, String code) {
    if (code == 'en') {
      switch (value) {
        case 'OnHold':
          return 1;
        case 'Upcoming':
          return 2;
        case 'Canceled':
          return 3;
        case 'Finished':
          return 4;
        case 'Inprogress':
          return 5;
        case 'Waiting':
          return 6;
        case 'Confirmed':
          return 7;
        default:
          {
            return 1;
          }
      }
    } else if (code == 'de') {
      switch (value) {
        case 'in Wartestellung':
          return 1;
        case 'bevorstehende':
          return 2;
        case 'Abgesagt':
          return 3;
        case 'Fertig':
          return 4;
        case 'Im Gange':
          return 5;
        case 'Warten':
          return 6;
        case 'Bestätigt':
          return 7;
        default:
          {
            return 1;
          }
      }
    } else {
      switch (value) {
        case 'في الانتظار':
          return 1;
        case 'قادم':
          return 2;
        case 'ملغى':
          return 3;
        case 'منتهي':
          return 4;
        case 'قيد العمل':
          return 5;
        case 'انتظار':
          return 6;
        case 'مؤكد':
          return 7;
        default:
          {
            return 1;
          }
      }
    }
  }
}
