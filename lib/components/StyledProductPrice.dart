import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../core/configurations/styles.dart';
import '../generated/l10n.dart';

class StyledProductPrice extends StatelessWidget {
  final String price;
  final String regularPrice;
  final double priceFontSize;
  final double regularPriceFontSize;
  final TextStyle? style;
  StyledProductPrice(this.price, this.regularPrice,
      {this.priceFontSize = 14, this.regularPriceFontSize = 12,this.style});

  bool shouldDisplayRegularPrice() {
    if (this.regularPrice == null || this.regularPrice.length == 0)
      return false;

    try {
      int regularPrice = double.parse(this.regularPrice).round();
      int currentPrice = double.parse(this.price).round();
      if (regularPrice == currentPrice) return false;
    } catch (err) {
      print(err);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return
      Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Text(
          '${this.price}'+S.of(context).currencyLogo ,
          style: this.style??Styles.boldTextStyle.copyWith(
    fontSize: Styles.fontSize32

          ),
        ),
        SizedBox(width: 4),

      ],
    );
  }
}
