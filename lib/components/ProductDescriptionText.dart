import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grodudes/core/configurations/styles.dart';

class ProductDescriptionText extends StatelessWidget {
  final String title;
  final String htmlText;
  final double sizeFont;
  ProductDescriptionText(this.title, this.htmlText,{this.sizeFont:9});
  @override
  Widget build(BuildContext context) {
    return

      // Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // children: <Widget>[
        // Text(
        //   title,
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        // ),
        Container(
           // width: 211.w,
          padding: EdgeInsets.all(0),
          // height: 22.h,
          child:      Align(
            alignment:Alignment.topLeft ,
            child:     Html(
              shrinkWrap:true,
          data: htmlText,
          style: {
            'p':
             Style(
               fontSize:  FontSize(this.sizeFont.sp),
               padding: EdgeInsets.all(0),
               margin: EdgeInsets.all(0),
            lineHeight:LineHeight.number(0.75),
               verticalAlign:VerticalAlign.SUB,
                 textAlign:TextAlign.start,
               color: Styles.loginFontColor.withOpacity(0.59),
                   )
          },
        ))
        // )
      // ],
    );
  }
}
