import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/core/constants.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/pages/top_order.dart';
import 'package:grodudes/pages/top_product.dart';
import 'package:http/http.dart' as http;

import 'package:grodudes/components/CategoryCard.dart';
import 'package:grodudes/components/ProductCard.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/models/Category.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/pages/HomeSpecialProductsPage.dart';
import 'package:provider/provider.dart';

import '../components/ProductCardAumet.dart';
import '../components/ProductCardN.dart';
import '../core/utils.dart';
import '../routing/route_paths.dart';
import '../state/products_state.dart';

class MessageContent extends StatefulWidget {
  // final Function pageChangeCb;
  MessageContent(
      // this.pageChangeCb
      );

  @override
  _MessageContentState createState() => _MessageContentState();
}

class _MessageContentState extends State<MessageContent>    with SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  TabController? _tabController;


  _openLatestProductsPage(productIds) {

    // Utils.pushNewScreenWithRouteSettings(context,
    //   settings:
    //   RouteSettings(name: RoutePaths.HomeSpecialProductsPage),
    //   withNavBar: false,
    //   screen: HomeSpecialProductsPage(
    //     S.of(context).latestProducts,
    //            productIds,
    //            () => Provider.of<ProductsManager>(context, listen: false)
    //                .fetchLatestProducts(shouldNotify: true),
    //   ));
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => HomeSpecialProductsPage(
          S.of(context).latestProducts,
          productIds,
          () => Provider.of<ProductsManager>(context, listen: false)
              .fetchLatestProducts(shouldNotify: true),
        ),
      ),
    );
  }

  _openTopRatedProductsPage(productIds) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => HomeSpecialProductsPage(
          S.of(context).topRatedProducts,
          productIds,
          () => Provider.of<ProductsManager>(context, listen: false)
              .fetchRatedProducts(shouldNotify: true),
        ),
      ),
    );
  }

  _openPopularProductsPage(productIds) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => HomeSpecialProductsPage(
          S.of(context).popularProducts,

          productIds,
          () => Provider.of<ProductsManager>(context, listen: false)
              .fetchPopularProducts(shouldNotify: true),
        ),
      ),
    );
  }


  @override
  initState() {

    this._tabController =
    TabController(initialIndex: 0, length: 2, vsync: this);
     super.initState();
  }

  @override
  void dispose() {

    this._tabController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return
      Container(child:
      Consumer<ProductsManager>(
      builder: (context, productsManager, child) {
        double carouselHeight = MediaQuery.of(context).size.width * 0.344;
        return

          Column(
          // cacheExtent: 2000,
          // shrinkWrap: true,
            mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[





                    Container(
                      height: 47.h,
                       color: Colors.white,
                      child:
                      Align(
                          alignment: Alignment.centerLeft,
                          child:

                          TabBar(

                            controller: this._tabController,
                            // isScrollable: true,
                            indicatorColor: Styles.colorPrimary,
                            indicatorWeight: 4,
// automaticIndicatorColorAdjustment: true,
                            // indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Styles.colorPrimary,
                            labelStyle: TextStyle(fontSize: Styles.fontSize22,

                                fontFamily: Styles.FontFamilyRobotoMedium,
                                fontWeight: FontWeight.w500),

                            unselectedLabelColor: Styles.colorUnselectTabFontTitle.withOpacity(0.62),
                            unselectedLabelStyle: TextStyle(fontSize: Styles.fontSize22,
                                fontFamily: Styles.FontFamilyRobotoMedium,
                                fontWeight: FontWeight.w500),

                            tabs: [
                              Tab(
                                  child:Text(S.of(context).home)),
                              Tab(
                                  child: Text(S.of(context).products)),

                            ],
                          )
                      ),),
                 Expanded(
                    child:
                    Column(children: [
                        Expanded(child:
                      TabBarView(
                        controller: this._tabController,
                        children: [
                          TopProductTab( ),
                          TopOrderTab(),
                         ],
                      )),







           ],
        )
                )
        ]
          )
        ;
      },
      // child: ,
      ));
  }
}

class HomeCategory extends StatefulWidget {
  final ProductsManager productsManager;
  HomeCategory(this.productsManager);
  @override
  _HomeCategoryState createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.productsManager.fetchAllParentCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(child: CircularProgressIndicator(color: Styles.colorPrimary,));
        if (snapshot.hasData) {
          List<Category> categories =
              widget.productsManager.categories.values.toList();
          Constants.categoryList = categories;
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: categories.length > 6 ? 6 : categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(categories[index]);
            },
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Column(
              children: [
                Text(S.of(context).failedToFetchCategories),
                RaisedButton(
                  child: Text(
                    S.of(context).retry,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => setState(() {}),
                )
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator(color: Styles.colorPrimary,));
      },
    );
  }
}

class _SpecialProductsLoadError extends StatelessWidget {
  const _SpecialProductsLoadError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(S.of(context).errorMessage,
              textAlign: TextAlign.center, style:Styles.boldTextStyle),
        ),
      ],
    );
  }
}

class _HeaderRow extends StatelessWidget {
  final Function cb;
  final String title;
  _HeaderRow(this.title, this.cb);
  @override
  Widget build(BuildContext context) {
    return Container(height: 24.h,
      // color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: Styles.boldTextStyle.copyWith(

                fontSize: Styles.fontSize20
            )
          ),
          Expanded(child: Container()),
          InkWell(
            child:Container(
              height: 30.h,
            padding: EdgeInsets.all(0),
            child: Text(
              S.of(context).seeAll,
              style: Styles.regularTextStyle.copyWith(
                color: Styles.colorFontTitle.withOpacity(0.59),
                fontSize: Styles.fontSize15
              )
            )),
            onTap: () {
             cb( );

            },
          ),
        ],
      ),
    );
  }
}

class _HorizontalProductRow extends StatelessWidget {
  final Set<int> productIds;
  final Map<int, Product> products;
  final bool isFeature;
  _HorizontalProductRow({required this.productIds, required this.products,this.isFeature:false});

  @override
  Widget build(BuildContext context) {
    if (productIds == null || products == null) {
      return Center(
        child: Text(
          S.of(context).thereWasAnErrorYouCanTryPressingTheSeeAllButtonToRetry,
          textAlign: TextAlign.center,
        ),
      );
    }
    if (productIds.length == 0) {
      return Center(
        child:CircularProgressIndicator(color: Styles.colorPrimary,)
      );
    }
    return
      isFeature? Container(
          height: 510.h,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child:
      ListView.separated(

        separatorBuilder: (context, index) => SizedBox(height: 28.h,),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,

      itemCount: productIds.length,// > 4 ? 4 : productIds.length,
      itemBuilder: (context, index) =>


          ProductCardAumet(products[productIds.elementAt(index)]!))
      ):


      Container(
        height: 239.h ,
        child:
        ListView.separated(
        separatorBuilder: (context, index) => SizedBox(width: 28.w,),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: productIds.length > 4 ? 4 : productIds.length,
      itemBuilder: (context, index) =>



        ProductCard(products[productIds.elementAt(index)]!),

    )
      );
  }
}
