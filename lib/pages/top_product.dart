import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/core/constants.dart';
import 'package:grodudes/generated/l10n.dart';
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
import '../components/top_product_card.dart';
import '../core/utils.dart';
import '../routing/route_paths.dart';
import '../state/products_state.dart';

class TopProductTab extends StatefulWidget {
  // final Function pageChangeCb;
  TopProductTab(
      // this.pageChangeCb
      );

  @override
  _TopProductTabState createState() => _TopProductTabState();
}

class _TopProductTabState extends State<TopProductTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;



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

  Future<List<Widget>> _getCarouselImages() async {
    try {
      var response =
          await http.get(Uri.parse('https://grodudes.com/json/url.json'));
      var resJson = json.decode(response.body);
      List<dynamic> imgUrls = resJson['url'].map((e) => e.toString()).toList();
      List<Widget> images = [];
      imgUrls.forEach(
        (url) => images.add(Image.network(
          url.toString(),
          fit: BoxFit.fitHeight,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.344,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Text('Failed to get images'),
          ),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator(color: Styles.colorPrimary,));
          },
        )),
      );
      return images;
    } catch (err) {
      print(err);
      throw err;
    }
  }

  List<Widget> _getDefaultCarouselImages() {
    List<String> defaultPaths = ['Banner1.jpg', 'Banner2.jpg'];
    return defaultPaths
        .map((path) => Image.asset(
              'assets/images/$path',
              errorBuilder: (context, error, stackTrace) => Center(
                child: Text('Failed to get images'),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.344,
            ))
        .toList();
  }

  CarouselOptions _defaultCarouselOptions = CarouselOptions(
    aspectRatio: 2.912,
    viewportFraction: 1,
    enableInfiniteScroll: false,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 5),
  );
  _openLatestProductsPage(productIds) {


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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<ProductsManager>(
      builder: (context, productsManager, child) {
        double carouselHeight = MediaQuery.of(context).size.width * 0.344;
        return

          Column(
          // cacheExtent: 2000,
          // shrinkWrap: true,
          children: <Widget>[

         SizedBox(height:10.h),

            SizedBox(height:18.h),

           Expanded(child:  FutureBuilder(
              future: productsManager.fetchLatestProducts(),
              builder: (context, snapshot) =>

                  Container(
                    // height: _screenHeight * 0.25,
                    // height: 250.h,
                    child: snapshot.connectionState != ConnectionState.done
                        ? Center(child: CircularProgressIndicator(color: Styles.colorPrimary,))
                        : snapshot.hasData
                            ? _HorizontalProductRow(
                                productIds: productsManager.latestProductIds,
                                products: productsManager.products,
                      isFeature: false,
                              )
                            : snapshot.hasError
                                ? _SpecialProductsLoadError()
                                : Center(child: CircularProgressIndicator(color: Styles.colorPrimary,)),
                  ),

            )),

            SizedBox(height: 16.h),
          ],

        );
      },
      // child: ,
    );
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
        // height: 239.h ,
        child:
        ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 28.h,),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: productIds.length  ,
      itemBuilder: (context, index) =>



          TopProductCard(products[productIds.elementAt(index)]!),

    )
      );
  }
}
