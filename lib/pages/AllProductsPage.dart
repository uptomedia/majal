import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grodudes/components/ProductListTile.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:provider/provider.dart';

import '../core/configurations/styles.dart';

class AllProductsPage extends StatefulWidget {
  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool? _isLoading;

  ScrollController? _scrollController;
  @override
  void initState() {
    this._isLoading = false;
    this._scrollController = ScrollController();
    this._scrollController!.addListener(_scrollHandler);
    super.initState();
  }

  Future _scrollHandler() async {
    if (_isLoading!) return;

    try {
      setState(() => this._isLoading = true);
      if (this._scrollController!.position.pixels ==
          this._scrollController!.position.maxScrollExtent) {
        await Provider.of<ProductsManager>(context, listen: false)
            .fetchNextProductsPage();
      }
    } catch (err) {
      print(err);
    } finally {
      setState(() => this._isLoading = false);
    }
  }

  @override
  void dispose() {
    this._scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductsManager>(
      builder: (context, productsManager, child) {
        if (productsManager.products.isEmpty) {
          Provider.of<ProductsManager>(context, listen: false)
              .fetchNextProductsPage();
        }

        return

          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 20.h,
            ),
            // padding: EdgeInsets.all(16),
            itemCount: productsManager.products.length + 1,
            itemBuilder: (context, index) {
              // return
          // ListView.separated(
          // padding: EdgeInsets.all(8),
          // controller: this._scrollController,
          // itemCount: productsManager.products.length + 1,
          // itemBuilder: (context, index) {
            if (index == productsManager.products.length &&
                productsManager.allProductPagesFetched == false) {
              if (!this._isLoading!) return SizedBox(height: 0);
              return Center(child: CircularProgressIndicator(color: Styles.colorPrimary,));
            }
            if (index == productsManager.products.length &&
                productsManager.allProductPagesFetched == true) {
              return SizedBox(height: 0);
            }
            return ProductListTile(
              productsManager.products.values.elementAt(index),
            );
          // },
          // separatorBuilder: (BuildContext context, int index) {
          //   return SizedBox(
          //     height: 25,
          //   );
          },
        );
      },
    );
  }
}
