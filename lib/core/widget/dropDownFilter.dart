import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownFilter extends StatefulWidget {
  final List<String> items;
  final String? title;
  final Color titleColor;
  final Color borderColor;
  final double cornerRadius;
  final Function valueChanged;
  final String initValue;

  const DropDownFilter({
    Key? key,
    required this.items,
    this.title,
    this.borderColor: Colors.black12,
    this.titleColor: Colors.black12,
    this.cornerRadius = 25,
    this.initValue: "",
    required this.valueChanged,
  }) : super(key: key);

  @override
  _MozzaikDropDownState createState() {
    return _MozzaikDropDownState();
  }
}

class _MozzaikDropDownState extends State<DropDownFilter> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(30),
          ),
          Expanded(
            child: DropdownButton(
              value: widget.initValue,
              hint: Text(
                dropdownValue != null ? dropdownValue : widget.title!,
                style: TextStyle(
                  color: widget.titleColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
                widget.valueChanged.call(widget.items.indexOf(dropdownValue));
              },
              underline: Container(),
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
              ),
              items: widget.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      // cornerRadius: widget.cornerRadius ?? 50.h,
    );
  }
}
