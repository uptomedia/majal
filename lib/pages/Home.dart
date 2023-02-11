import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grodudes/core/configurations/assets.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/core/constants.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/models/filter_parameter.dart';
import 'package:grodudes/pages/SearchResultsPage.dart';
import 'package:grodudes/state/cart_state.dart';
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

class Home extends StatefulWidget {
  // final Function pageChangeCb;
  Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  FilterParams filterParams = FilterParams();
  int? selectedCat;
  int? selectedTag;

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
            return Center(
                child: CircularProgressIndicator(
              color: Styles.colorPrimary,
            ));
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ProductsManager>(
      builder: (context, productsManager, child) {
        double carouselHeight = MediaQuery.of(context).size.width * 0.344;
        return Column(
          // cacheExtent: 2000,
          // shrinkWrap: true,
          children: <Widget>[
            // FutureBuilder(
            //     future: productsManager.fetchAllParentCategories(),
            //     builder: ((context, snapshot) {
            //       return Container(
            //         height: 125.h,
            //         child: snapshot.connectionState != ConnectionState.done
            //             ? Center(
            //                 child: CircularProgressIndicator(
            //                 color: Styles.colorPrimary,
            //               ))
            //             : snapshot.hasData
            //                 ? Container(
            //                     padding: EdgeInsets.all(10),
            //                     child: Column(
            //                       children: [
            //                         Row(
            //                           children: [
            //                             Expanded(child: Text("Categories : ")),
            //                             TextButton(
            //                                 onPressed: () {
            //                                   filterParams.body = null;
            //                                   setState(() {
            //                                     selectedCat = null;
            //                                     selectedTag = null;
            //                                   });
            //                                 },
            //                                 child: Text("Reset Filter"))
            //                           ],
            //                         ),
            //                         Expanded(
            //                           child: ListView.separated(
            //                               scrollDirection: Axis.horizontal,
            //                               itemBuilder: (context, index) {
            //                                 print((productsManager
            //                                         .categories.values
            //                                         .toList())[index]
            //                                     .data);
            //                                 return Container(
            //                                   height: 20,
            //                                   decoration: BoxDecoration(
            //                                       color: selectedCat ==
            //                                               (productsManager
            //                                                           .categories
            //                                                           .values
            //                                                           .toList())[
            //                                                       index]
            //                                                   .data["id"]
            //                                           ? Colors.blue
            //                                           : Styles.colorPrimary,
            //                                       border: Border.all(
            //                                           color: Colors.black,
            //                                           width: 1),
            //                                       borderRadius:
            //                                           BorderRadius.circular(
            //                                               15)),
            //                                   child: GestureDetector(
            //                                     onTap: () {
            //                                       selectedCat = (productsManager
            //                                               .categories.values
            //                                               .toList())[index]
            //                                           .data["id"];
            //                                       filterParams
            //                                           .body = selectedTag !=
            //                                               null
            //                                           ? FilterParamsBody(
            //                                               categroyIds:
            //                                                   selectedCat
            //                                                       .toString(),
            //                                               tagIds: selectedTag
            //                                                   .toString())
            //                                           : FilterParamsBody(
            //                                               categroyIds:
            //                                                   selectedCat
            //                                                       .toString(),
            //                                             );
            //                                       setState(() {});
            //                                     },
            //                                     child: Center(
            //                                       child: Padding(
            //                                         padding:
            //                                             const EdgeInsets.all(
            //                                                 8.0),
            //                                         child: Text(
            //                                           (productsManager
            //                                                   .categories.values
            //                                                   .toList())[index]
            //                                               .data["name"],
            //                                           style: TextStyle(
            //                                               fontSize: 10),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 );
            //                               },
            //                               separatorBuilder: (context, index) =>
            //                                   SizedBox(
            //                                     width: 10.h,
            //                                   ),
            //                               itemCount: productsManager
            //                                   .categories.length),
            //                         ),
            //                       ],
            //                     ),
            //                   )
            //                 : Container(),
            //       );
            //     })),
            FutureBuilder(
                future: productsManager.fetchAllProductTags(),
                builder: ((context, snapshot) {
                  return Container(
                    height: 120.h,
                    child: snapshot.connectionState != ConnectionState.done
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Styles.colorPrimary,
                          ))
                        : snapshot.hasData
                            ? Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                S.of(context).categories +
                                                    " : ")),
                                        TextButton(
                                            onPressed: () {
                                              filterParams.body = null;
                                              setState(() {
                                                selectedCat = null;
                                                selectedTag = null;
                                              });
                                            },
                                            child: Text("Reset Filter"))
                                      ],
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            print((productsManager.tags.values
                                                    .toList())[index]
                                                .data);
                                            return Container(
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: selectedTag ==
                                                          (productsManager
                                                                      .tags.values
                                                                      .toList())[
                                                                  index]
                                                              .data["id"]
                                                      ? Colors.blue
                                                      : Styles.colorPrimary,
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  selectedTag = (productsManager
                                                          .tags.values
                                                          .toList())[index]
                                                      .data["id"];
                                                  filterParams.body =
                                                      selectedCat != null
                                                          ? FilterParamsBody(
                                                              categroyIds:
                                                                  selectedCat
                                                                      .toString(),
                                                              tagIds: selectedTag
                                                                  .toString())
                                                          : FilterParamsBody(
                                                              tagIds: selectedTag
                                                                  .toString());
                                                  setState(() {});
                                                },
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        (productsManager
                                                                    .tags.values
                                                                    .toList())[
                                                                index]
                                                            .data["name"],
                                                        style: TextStyle(
                                                            fontSize: 10)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                          itemCount:
                                              productsManager.tags.length),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                  );
                })),
            Expanded(
                // height: 500.h,
                child: FutureBuilder(
              future: productsManager.fetchFilteredProducts(filterParams),
              builder: (context, snapshot) => Column(
                children: <Widget>[
                  // _HeaderRow(
                  //   S.of(context).specialOffers,
                  //   snapshot.connectionState == ConnectionState.done
                  //       ? () => _openPopularProductsPage(
                  //           productsManager.popularProductIds)
                  //       : () {},
                  // ),

                  Expanded(
                    child: Container(
                      // height:400.h,
                      child: snapshot.connectionState != ConnectionState.done
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Styles.colorPrimary,
                            ))
                          : snapshot.hasData
                              ? _HorizontalProductRow(
                                  productIds: productsManager.popularProductIds,
                                  products: productsManager.products,
                                  isFeature: true,
                                )
                              : snapshot.hasError
                                  ? _SpecialProductsLoadError()
                                  : Center(
                                      child: CircularProgressIndicator(
                                      color: Styles.colorPrimary,
                                    )),
                    ),
                  )
                ],
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
  TextEditingController? _searchController;

  openSearchPage(String searchQuery) {
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
    this._searchController!.clear();
    Utils.pushNewScreenWithRouteSettings(context,
        settings: RouteSettings(name: RoutePaths.SearchResultsPage),
        withNavBar: false,
        screen: SearchResultsPage(searchQuery));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              // height: 25.h,
              // width: 360.w,
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
              // decoration: Styles.textFieldDecoration,

              child: Row(
                children: <Widget>[
                  // SizedBox(width: 16.w,),
                  SizedBox(
                      width: 26.w,
                      child: GestureDetector(
                          onTap: () =>
                              openSearchPage(this._searchController!.text),
                          child: SvgPicture.asset(
                            Assets.SVGDrawerIcon,
                            width: 26.w,
                          ))),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                      child: Center(
                    child: Text(
                      "Pharma logo",
                      style: Styles.boldTextStyle.copyWith(
                          color: Styles.colorPrimary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
                  // Center(child:
                  // ),
                  SizedBox(
                    width: 13.w,
                  ),
                  SizedBox(
                      width: 26.w,
                      child: GestureDetector(
                          onTap: () =>
                              openSearchPage(this._searchController!.text),
                          child: Consumer<CartManager>(
                              builder: (context, userManager, child) {
                            return Badge(
                                badgeColor: Styles.colorPrimary,
                                shape: BadgeShape.circle,
                                showBadge: Provider.of<CartManager>(context,
                                            listen: false)
                                        .cartItems
                                        .length >
                                    0,
                                badgeContent: Text(
                                    Provider.of<CartManager>(context,
                                            listen: false)
                                        .cartItems
                                        .length
                                        .toString(),
                                    style: Styles.boldTextStyle.copyWith(
                                        color: Styles.colorSecondary,
                                        fontSize: Styles.fontSize10)),
                                child: GestureDetector(
                                    onTap: () => openSearchPage(
                                        this._searchController!.text),
                                    child: SvgPicture.asset(
                                      Assets.SVG_cart,
                                      width: 26.w,
                                    )));
                          }))),
                  // SizedBox(width: 16.w,),
                ],
              ),
            ),
            SizedBox(
              width: 257.w,
              child: TextField(
                controller: this._searchController,
                style: TextStyle(fontSize: 18),
                decoration: Styles.PharmaFieldSearchDecoration(
                    radius: 0.r,
                    color: Styles.ColorText,
                    hint: S.of(context).search),
                onSubmitted: (value) => openSearchPage(value),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: widget.productsManager.fetchAllParentCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Center(
                          child: CircularProgressIndicator(
                        color: Styles.colorPrimary,
                      ));
                    if (snapshot.hasData) {
                      List<Category> categories =
                          widget.productsManager.categories.values.toList();
                      Constants.categoryList = categories;
                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount:
                            categories.length > 6 ? 6 : categories.length,
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
                            ElevatedButton(
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
                    return Center(
                        child: CircularProgressIndicator(
                      color: Styles.colorPrimary,
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
              textAlign: TextAlign.center, style: Styles.boldTextStyle),
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
    return Container(
      height: 24.h,
      // color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style:
                  Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize20)),
          Expanded(child: Container()),
          InkWell(
            child: Container(
                height: 30.h,
                padding: EdgeInsets.all(0),
                child: Text(S.of(context).seeAll,
                    style: Styles.regularTextStyle.copyWith(
                        color: Styles.colorFontTitle.withOpacity(0.59),
                        fontSize: Styles.fontSize15))),
            onTap: () {
              cb();
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
  _HorizontalProductRow(
      {required this.productIds,
      required this.products,
      this.isFeature: false});

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
          child: Center(
        child: Text(
          S.of(context).emptyData,
          textAlign: TextAlign.center,
        ),
      ));
    }
    return isFeature
        ? Container(
            height: 510.h,
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      height: 28.h,
                    ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: productIds.length, // > 4 ? 4 : productIds.length,
                itemBuilder: (context, index) =>
                    ProductCardAumet(products[productIds.elementAt(index)]!)))
        : Container(
            height: 239.h,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: 28.w,
              ),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: productIds.length > 4 ? 4 : productIds.length,
              itemBuilder: (context, index) =>
                  ProductCard(products[productIds.elementAt(index)]!),
            ));
  }
}
