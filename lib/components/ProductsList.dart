import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grodudes/components/ProductCardAumet.dart';
import 'package:grodudes/components/ProductListTile.dart';
import 'package:grodudes/models/Product.dart';

class ProductsList extends StatelessWidget {
  final List<Product> items;
  ProductsList(this.items);
  @override
  Widget build(BuildContext context) {
    if (this.items == null || this.items.length == 0) {
      return SizedBox(height: 0);
    }
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: 20.h,
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductCardAumet(items[index]),
      ),
    );
  }
}
