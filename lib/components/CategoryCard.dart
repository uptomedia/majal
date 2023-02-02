import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grodudes/components/ProductsList.dart';
import 'package:grodudes/core/configurations/assets.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/ImageFetcher.dart';
import 'package:grodudes/models/Category.dart';
import 'package:grodudes/state/products_state.dart';
import 'package:provider/provider.dart';

import '../core/configurations/styles.dart';
import '../core/utils.dart';
import '../routing/route_paths.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  CategoryCard(this.category);

  String _formatName(String name) {
    return name.replaceAll('&amp;', '&');
  }

  @override
  Widget build(BuildContext context) {
    if (this.category == null || this.category.data['id'] == null) {
      return SizedBox(width: 0, height: 0);
    }
    return GestureDetector(
      onTap: () {
        Utils.pushNewScreenWithRouteSettings(context,
            settings: RouteSettings(name: RoutePaths.CategoryContents),
            withNavBar: false,
            screen: CategoryContents(
              category: category,
            ));
        // Navigator.push(
        //   context,
        //   CupertinoPageRoute(
        //     builder: (context) {
        //       return CategoryContents(category: category);
        //     },
        //   ),
        // );
      },
      child: Container(
        // margin: EdgeInsets.only(top: 16, bottom: 6, left: 8, right: 8),
        width: 154.w,
        // height: 205.h,
        decoration: Styles.tilesDecoration.copyWith(
          borderRadius: BorderRadius.all(
            Radius.circular(22.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 110.w,
                height: 111.h,
                margin: EdgeInsets.symmetric(horizontal: 21.w, vertical: 22.h),
                child: Center(
                    child: Container(
                  decoration: Styles.transParentDecoration.copyWith(
                      borderRadius: BorderRadius.all(
                    Radius.circular(111.r),
                  )),
                  child: ClipRRect(
                    // color: Colors.black,

                    borderRadius: BorderRadius.circular(111.r),
                    child: category.data['image'] != null
                        ? ImageFetcher.getImage(category.data['image']['src'])
                        : Image.asset(Assets.PNG_SplashImage),
                  ),
                ))),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Center(
                    child: Text(
                      _formatName(category.data['name']),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: Styles.meduimTextStyle
                          .copyWith(fontSize: Styles.fontSize16),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryContents extends StatefulWidget {
  const CategoryContents({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  _CategoryContentsState createState() => _CategoryContentsState();
}

class _CategoryContentsState extends State<CategoryContents> {
  String _formatName(String name) {
    return name.replaceAll('&amp;', '&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _formatName(this.widget.category.data['name']),

          // style: Styles.appBarTextStyle,
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Styles.colorBackGround,
      ),
      body: FutureBuilder(
        future: Provider.of<ProductsManager>(context)
            .fetchCategoryDetails(widget.category),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red[600]),
                  Text(
                    S.of(context).anErrorOccuredWhileLoading,
                    style: TextStyle(fontSize: 16),
                  ),
                  ElevatedButton(
                    child: Text(S.of(context).retry,
                        style: TextStyle(color: Colors.white)),
                    onPressed: () => setState(() {}),
                  )
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data['products'] != null) {
              return ProductsList(snapshot.data['products'] ?? []);
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data['categories'].length,
              itemBuilder: (context, index) =>
                  CategoryCard(snapshot.data['categories'][index]),
            );
          }
          return Center(
              child: CircularProgressIndicator(
            color: Styles.colorPrimary,
          ));
        },
      ),
    );
  }
}
