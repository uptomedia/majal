import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grodudes/components/ProductListTile.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:provider/provider.dart';

import '../core/widget/majl/majal_app_bar.dart';

class HomeSpecialProductsPage extends StatefulWidget {
  final String title;
  final Set<int> productIds;
  final Future Function() cb;
  HomeSpecialProductsPage(this.title, this.productIds, this.cb);
  @override
  _HomeSpecialProductsPageState createState() =>
      _HomeSpecialProductsPageState();
}

class _HomeSpecialProductsPageState extends State<HomeSpecialProductsPage> {
  bool _isLoading = false;
  bool requestedOnce = false;
  @override
  void initState() {
    this._isLoading = false;
    this.requestedOnce = false;
    super.initState();
  }

  Future _getData() async {
    setState(() {
      this._isLoading = true;
    });
    await widget.cb().catchError((err) {
      print('loading error: ' + err.toString());
    });
    setState(() {
      this.requestedOnce = true;
      this._isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.productIds == null || this.widget.productIds.length == 0) &&
        !this.requestedOnce) {
      _getData();
    }
    Map<int, Product> products =
        Provider.of<ProductsManager>(context, listen: false).products;
    return Scaffold(
      backgroundColor: Styles.colorBackGround,
      // appBar: AppBar(
      //     iconTheme: IconThemeData(
      //       color: Colors.black, //change your color here
      //     ),
      //     backgroundColor: Styles.colorBackGround,
      //     title: Text(
      //       widget.title,
      //       style: Styles.appBarTextStyle,
      //     )),
      body:


      SafeArea(child:

    // SingleChildScrollView  (child:

    Column(
    mainAxisSize: MainAxisSize.min,
      // scrollDirection: Axis.vertical,
      children: [
      MajalAppBar(
      withBack: true,

    ),

    SizedBox(child:
    Center(
    child: Text(widget.title,
    style: Styles.boldTextStyle,),
    )
    ),
SizedBox(height: 38.h,),

     Expanded(child:
      _isLoading
          ? Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(color: Styles.colorPrimary,),
              ),
            )
          : this.widget.productIds.length == 0 && this.requestedOnce
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).failedToLoadProducts),
                      RaisedButton(
                        onPressed: _getData,
                        child: Text(
                          S.of(context).retry,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              :


        Expanded(child:   Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child:
      GridView.builder(
        shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.85,
      crossAxisSpacing: 19.w,
      mainAxisSpacing: 20.h,
    ),
    // padding: EdgeInsets.all(16),
    itemCount: widget.productIds.length,
    itemBuilder: (context, index) {
    return  ProductListTile(
          products[widget.productIds.elementAt(index)]!,withAction: false,);
                  },

                ),
    )))
    ]
    )
    )
    // )
    );
  }
}
