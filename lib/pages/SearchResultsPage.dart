import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/ProductListTile.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/core/constants.dart';
import 'package:grodudes/core/widget/dropDownFilter.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/models/Category.dart';
import 'package:grodudes/models/Product.dart';
import 'package:grodudes/models/filter_parameter.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../components/ProductCardAumet.dart';
import '../components/ProductFilterListTile.dart';
import '../core/configurations/assets.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;
  SearchResultsPage(this.searchQuery);
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  TextEditingController? _searchController;
  // List<String> brands = const ["test","dfdsf"];
  //     List<String> categories = const ["test","asdas"];
  // late SfRangeValues _selectedRangeValue;

  late int selectedBrand;
  late int selectedCategory;
  late bool showFilter = false;

  late double currMinPrice = Constants.minPrice;
  late double currMaxPrice = Constants.maxPrice;
  String currCategoryIds = "";
  SfRangeValues _values = SfRangeValues(0.0, 80.0);
  late FilterParams filter;
  int _selectedBrand = 0, _selectedCategory = 0;
  @override
  void initState() {
    this._searchController = TextEditingController(text: widget.searchQuery);
    if (Constants.categoryList.length == 0) {
      Provider.of<ProductsManager>(context, listen: false)
          .fetchAllParentCategories();
    }
    _values = SfRangeValues(currMinPrice, currMaxPrice);
    filter = new FilterParams(
        body: new FilterParamsBody(
            withCategoryIds: false,
            withMaxPrice: true,
            withminPrice: true,
            max_price: currMaxPrice,
            min_price: currMinPrice,
            categroyIds: currCategoryIds));
    super.initState();
  }

  void loadSearch() {
    setState(() {
      WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.colorBackGround,

        // appBar: AppBar(
        //   // backgroundColor: Colors.black,
        //   centerTitle: true,
        //   title: Container(
        //     padding: EdgeInsets.symmetric(
        //         horizontal:25.w),
        //     decoration: Styles.textFieldDecoration,
        //
        //     child: Row(
        //       children: <Widget>[
        //         Expanded(
        //           child: TextField(
        //             controller: this._searchController,
        //             style: TextStyle(fontSize: 18),
        //             decoration:  Styles.PharmaFieldDecoration(radius: 23.r,
        //                 hint: S.of(context).search),
        //             // cursorColor: GrodudesPrimaryColor.primaryColor[600],
        //             onSubmitted: (value) => loadSearch(),
        //           ),
        //         ),
        //         GestureDetector(
        //           onTap: loadSearch,
        //           child: Icon(Icons.search,
        //               size: 24,
        //               // color: GrodudesPrimaryColor.primaryColor[100]
        //           ),
        //         ),
        //         SizedBox(width: 6),
        //       ],
        //     ),
        //   ),
        //   leading: IconButton(
        //       icon: Icon(Icons.arrow_back, color: Colors.black),
        //       onPressed: () => Navigator.of(context).pop()),
        //   actions: <Widget>[
        //     IconButton(
        //         icon: Icon(
        //             showFilter ? Icons.filter_alt : Icons.filter_alt_outlined),
        //         color: Colors.black,
        //         constraints: BoxConstraints(maxHeight: 38, minWidth: 40),
        //         onPressed: () => {
        //               setState(() {
        //                 showFilter = !showFilter;
        //               })
        //             }
        //         //   Navigator.push(
        //         // context,
        //         // CupertinoPageRoute(builder: (context) => CartItems()),
        //         ),
        //   ],
        // ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 43.h,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  // decoration: Styles.textFieldDecoration,

                  child: Row(
                    children: <Widget>[
                      Container(
                        // decoration: Styles.tilesDecoration,
                        child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.arrow_back,
                              size: 24,
                              // color: GrodudesPrimaryColor.primaryColor[700],
                            )),
                      ),
                      SizedBox(
                        width: 9.w,
                      ),
                      Expanded(
                          child: Container(
                        width: 271.w,
                        height: 56.h,
                        decoration: Styles.tilesDecoration.copyWith(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.r),
                          ),
                        ),
                        child: TextField(
                          controller: this._searchController,
                          style: TextStyle(fontSize: 18),
                          decoration: Styles.PharmaFieldDecoration(
                              radius: 23.r, hint: S.of(context).search),
                          onSubmitted: (value) => loadSearch(),
                        ),
                      )),
                      SizedBox(
                        width: 9.w,
                      ),
                      Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: Styles.tilesDecoration.copyWith(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.r))),
                          width: 56.h,
                          height: 56.h,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showFilter = !showFilter;
                                });
                              },
                              child:
                                  // SizedBox(width: 26.w,height: 26.w,child:
                                  SvgPicture.asset(Assets.SVG_filter))
                          // Icon(
                          //   Icons.search,
                          //   size: 24,
                          //   color: GrodudesPrimaryColor.primaryColor[700],
                          // ),
                          // )
                          ),
                    ],
                  )),

              showFilter
                  ? _buildMultySelect()
                  : SizedBox(
                      height: 0,
                    ),
              showFilter
                  ? _buildRangeSelect()
                  : SizedBox(
                      height: 0,
                    ),

              // showFilter?

              Container(
                  //   height: //!showFilter
                  //    ?
                  //     MediaQuery.of(context).size.height,
                  //     : MediaQuery.of(context).size.height * 0.6,
                  child: FutureBuilder(
                future: Provider.of<ProductsManager>(context, listen: false)
                    .filterProducts(filter),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Center(
                        child: CircularProgressIndicator(
                      color: Styles.colorPrimary,
                    ));
                  if (snapshot.hasError) {
                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          S.of(context).anErrorOccuredPleaseTryAgain,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    List<Product> items = snapshot.data as List<Product>;
                    print(MediaQuery.of(context).size.aspectRatio.toString());
                    return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 28.h,
                                ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount:
                                items.length, // > 4 ? 4 : productIds.length,
                            itemBuilder: (context, index) =>
                                ProductCardAumet(items[index])));
                    // GridView.builder(
                    //   shrinkWrap:true,
                    //   physics: BouncingScrollPhysics(),
                    //
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisCount: 2,
                    //     childAspectRatio:  0.85,
                    //
                    //  crossAxisSpacing: 10.h,
                    // mainAxisSpacing: 20.h,
                    // ),
                    // // padding: EdgeInsets.all(16),
                    // itemCount: items.length,
                    // itemBuilder: (context, index)  =>
                    //                       // ListView.separated(
                    //                       // padding: EdgeInsets.all(8),
                    //                       // itemCount: items.length,
                    //                       // itemBuilder: (context, index) =>
                    // ProductFilterListTile(items[index]),
                    //                       // separatorBuilder: (BuildContext context, int index) {
                    //                       //   return SizedBox(height: 45.h,);
                    //                       // },
                    //                     )
                    //                     );

                  }
                  return Center(
                      child: CircularProgressIndicator(
                    color: Styles.colorPrimary,
                  ));
                },
              )
                  // :
                  //  FutureBuilder(
                  //   future:
                  //  Provider.of<ProductsManager>(context, listen: false)
                  //     .searchProducts(this._searchController!.text.toString()),
                  //   builder: (context, snapshot) {
                  //
                  //     if (snapshot.connectionState != ConnectionState.done)
                  //       return Center(child: CircularProgressIndicator(color: Styles.colorPrimary,));
                  //     if (snapshot.hasError) {
                  //       return Center(
                  //         child: Container(
                  //           padding: EdgeInsets.all(16),
                  //           child: Text(
                  //             'An Error Occured. Please Try Again',
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(fontSize: 18),
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //     if (snapshot.hasData) {
                  //       List<Product> items = snapshot.data as List<Product>;
                  //       return ListView.builder(
                  //         padding: EdgeInsets.all(8),
                  //         itemCount: items.length,
                  //         itemBuilder: (context, index) => ProductListTile(items[index]),
                  //       );
                  //     }
                  //     return Center(child: CircularProgressIndicator(color: Styles.colorPrimary,));
                  //   },
                  // ),
                  )
            ],
          ),
        )));
  }

  Widget _buildMultySelect() {
    final _items = Provider.of<ProductsManager>(context, listen: false)
        .categories
        .values
        .toList()
        .map((Category) => MultiSelectItem(Category, Category.data["name"]))
        .toList();
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.w,
        ),
        child: MultiSelectChipField<Category>(
          items: _items,
          initialValue: [],
          decoration: Styles.multySelectDecoration,
          title: Text(
            "   " + S.of(context).categoryFilters,
            style: Styles.meduimTextStyle.copyWith(fontSize: Styles.fontSize25),
          ),
          headerColor: Colors.transparent,

          // decoration: BoxDecoration(
          //   border: Border.all(color: GrodudesPrimaryColor.primaryColor[700]!, width: 1.8),
          // ),

          itemBuilder: (item, state) {
            return InkWell(
              onTap: () {
                // filter.body!.categroyIds.contains(item.value.data["id"].toString()??"0");
                // currCategoryIds = "";
                // filter.body!.withCategoryIds = true;
                // for (int i = 0; i < item.values.length; i++) {
                //   currCategoryIds =
                //       currCategoryIds + values[i].data["id"].toString() + ",";
                // }
                // filter.body!.categroyIds = currCategoryIds;
                print(item.value.data["name"]);
                if (!item.selected) {
                  filter.body!.categroyIds = filter.body!.categroyIds! +
                      item.value.data["id"].toString() +
                      ",";
                } else {
                  var ids = filter.body!.categroyIds!.split(",");
                  currCategoryIds = "";
                  for (int i = 0; i < ids.length; i++) {
                    if (item.value.data["id"] != ids[i]) {
                      currCategoryIds =
                          currCategoryIds + ids[i].toString() + ",";
                    } else {
                      currCategoryIds = currCategoryIds;
                    }
                  }
                }

                item.selected = !item.selected;
                setState(() {});
              },
              child: Container(
                width: 170.w,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
                // height: 70.h,
                decoration: !item.selected
                    ? Styles.tilesDecoration.copyWith(
                        boxShadow: [
                          BoxShadow(
                            color: Styles.shadowColor.withOpacity(0.14),
                            blurRadius: 6,
                            offset: Offset(3, 3), // changes position of shadow
                          )
                        ],
                      )
                    : Styles.tilesDecoration.copyWith(
                        color: Styles.colorPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Styles.shadowColor.withOpacity(0.14),
                            blurRadius: 6,
                            offset: Offset(3, 3), // changes position of shadow
                          )
                        ],
                      ),
                child: Center(
                    child: Text(
                  item.value.data["name"] ?? "",
                  style: !item.selected
                      ? Styles.regularTextStyle
                          .copyWith(fontSize: Styles.fontSize15)
                      : Styles.regularTextStyle.copyWith(
                          fontSize: Styles.fontSize15, color: Colors.white),
                )),
              ),
            );
          },
          // selectedChipColor: ,
          selectedTextStyle:
              Styles.regularTextStyle.copyWith(fontSize: Styles.fontSize20),
          onTap: (values) {
            currCategoryIds = "";
            filter.body!.withCategoryIds = true;
            for (int i = 0; i < values.length; i++) {
              currCategoryIds =
                  currCategoryIds + values[i].data["id"].toString() + ",";
            }
            filter.body!.categroyIds = currCategoryIds;
            //_selectedCategoryFilters4 = values;
          },
        ));
  }

  Widget _buildRangeSelect() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // CommonSizes.vSmallestSpace,

        Row(
          children: [
            CommonSizes.hBiggerSpace,
            Text(
              S.of(context).priceRange,
              style: TextStyle(
                color: GrodudesPrimaryColor.primaryColor[700],
                fontWeight: FontWeight.bold,
              ),
              // style: CommonTextStyle.semiBoldText,
            ),
            CommonSizes.hSmallestSpace,
            Expanded(
              child: SfRangeSlider(
                min: Constants.minPrice,
                max: Constants.maxPrice,
                values: _values,
                // interval: 1.0,
                //
                activeColor: Colors.black,
                inactiveColor: Colors.black.withOpacity(0.2),

                numberFormat: NumberFormat(" \JD"),

                enableTooltip: true,
                // minorTicksPerInterval: 1,

                onChanged: (SfRangeValues newValues) {
                  setState(() {
                    _values = newValues;
                    currMinPrice = newValues.start;
                    currMaxPrice = newValues.end;
                    filter.body!.min_price = currMinPrice;
                    filter.body!.max_price = currMaxPrice;
                    filter.body!.withMaxPrice = true;
                    filter.body!.withminPrice = true;
                  });
                },
                // },
              ),
            )
          ],
        ),

        CommonSizes.vSmallSpace,
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(15),
        //     ),
        //     // primary: CoreStyle.primaryTheme,
        //   ),
        //   onPressed: () {
        //     loadSearch();
        //     // Provider.of<ProductsManager>(context, listen: false).filterProducts(filter);
        //   },
        //   child: Text(
        //      "applyFilter",
        //     style: TextStyle(
        //       // fontSize: ScreenUtil().setSp(CommonTextStyle.sp18),
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        // CommonSizes.vSmallSpace,
      ],
    );
  }
}
