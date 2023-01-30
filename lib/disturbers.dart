import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/components/RootDrawer.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/pages/AllCategoriesPage.dart';
import 'package:grodudes/pages/AllProductsPage.dart';
import 'package:grodudes/pages/CartItems.dart';
import 'package:grodudes/pages/Home.dart';
import 'package:grodudes/pages/SearchResultsPage.dart';
import 'package:grodudes/pages/account/AccountRoot.dart';
import 'package:grodudes/pages/distrubter_home.dart';
import 'package:grodudes/routing/route_paths.dart';
import 'package:grodudes/state/cart_state.dart';
import 'package:provider/provider.dart';

import 'core/configurations/assets.dart';
import 'core/configurations/styles.dart';
import 'core/utils.dart';
import 'generated/l10n.dart';
import 'l10n/locale_provider.dart';

class Disturbers extends StatefulWidget {
  @override
  _DisturbersState createState() => _DisturbersState();
}

class _DisturbersState extends State<Disturbers> with SingleTickerProviderStateMixin {
  var currentPage;
  TabController? _tabController;
  TextEditingController? _searchController;

  @override
  initState() {
    this._tabController =
        TabController(initialIndex: 0, length: 3, vsync: this);
    this._searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    this._tabController!.dispose();
    this._searchController!.dispose();
    super.dispose();
  }

  openSearchPage(String searchQuery) {
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
    this._searchController!.clear();
    Utils.pushNewScreenWithRouteSettings(context,
        settings:
        RouteSettings(name: RoutePaths.SearchResultsPage),
        withNavBar: false,
        screen: SearchResultsPage(
            searchQuery
        )

    );
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldKey,

        backgroundColor: Styles.colorBackGround,
      // appBar: AppBar(
      //
      //   backgroundColor: Styles.colorBackGround,
      //   automaticallyImplyLeading: false,
      //
      //   titleSpacing: 2,
      //   iconTheme: IconThemeData(color: Colors.black87, size: 36),
      //   actionsIconTheme:
      //       IconThemeData(color: GrodudesPrimaryColor.primaryColor[700]),
      //   // title:
      //   // //   backgroundColor: Colors.white,
      //   actions: <Widget>[
      //
      //
      //
      //
      // ),
      drawer: RootDrawer(),
      body:

Container(
   // height:MediaQuery.of(context).size.height ,
  child:             Column(children: [
  SizedBox(height:MediaQuery.of(context).padding.top,),
  Container(
    // height: 25.h,
    // width: 360.w,
    padding: EdgeInsets.symmetric(
        horizontal:16.h,vertical: 16.h),
    // decoration: Styles.textFieldDecoration,

    child:
    Row(
      children: <Widget>[


        // SizedBox(width: 16.w,),
        SizedBox(width: 26.w,
            child:
            GestureDetector(
                onTap: () =>                     _scaffoldKey.currentState!.openDrawer(),

                child:
                SvgPicture.asset(Assets.SVGDrawerIcon,width: 26.w,)

            )),
        SizedBox(width: 16.w,),
Expanded(child: Center(child: Text("Pharma logo",style: Styles.boldTextStyle.copyWith(
  color: Styles.colorPrimary,
  fontSize: 15.sp,fontWeight: FontWeight.w700
),),)),
        // Center(child:
        // ),
        SizedBox(width: 13.w,),
        SizedBox(
            width: 26.w,
            child:
            GestureDetector(
                onTap: () =>
                    _scaffoldKey.currentState!.openDrawer(),
                //openSearchPage(this._searchController!.text),
                child:
                Consumer<CartManager>(
                    builder: (context, userManager, child) {
                      return
                        Badge(
                            badgeColor: Styles.colorPrimary,
                            shape: BadgeShape.circle,

                            showBadge:Provider
                                .of<CartManager>(context, listen: false).cartItems.length>0 ,
                            badgeContent: Text( Provider
                                .of<CartManager>(context, listen: false).cartItems.length.toString(),
                                style:Styles.boldTextStyle.copyWith(
                                    color: Styles.colorSecondary,
                                    fontSize: Styles.fontSize10
                                )),

                            child:
                            GestureDetector(
                                onTap:
                                    () =>
                                        openSearchPage(this._searchController!.text),
                                child:
                                SvgPicture.asset(Assets.SVG_cart,width: 26.w,)

                            )
                        );    }),

            )    ),
        // SizedBox(width: 16.w,),

      ],

    ),
  ),

    SizedBox(
      width: 257.w,
      child: TextField(
        controller: this._searchController,
        style: TextStyle(fontSize: 18),
        decoration:  Styles.PharmaFieldSearchDecoration(radius: 5.r,
            color: Styles.ColorText,
            hint: S.of(context).search),
        onSubmitted: (value) => openSearchPage(value),
      ),
    ),

    Expanded(child:  DisturbersHome()),


],)
  ,)

    );
  }
}
// class TriangleTabIndicator extends Decoration {
//   final BoxPainter _painter;
// double num;
//   TriangleTabIndicator({required Color color, required double radius,required this.num})
//       : _painter = DrawTriangle(color,num);
//
//   @override
//   BoxPainter createBoxPainter(  [VoidCallback? onChanged]) => _painter;
// }
//
// class DrawTriangle extends BoxPainter {
//   Paint? _paint;
//   double num1=5;
//
//   DrawTriangle(Color color, double num) {
//  num1=num;
//     _paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//   }
//
//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
//     final Offset triangleOffset = offset + Offset(cfg.size!.width   / 2 , cfg.size!.height/num1  );
//     var path = Path();
// if(num1==1.2){
//     path.moveTo(triangleOffset.dx , triangleOffset.dy );
//     path.lineTo(triangleOffset.dx -10 , triangleOffset.dy +10   );
//     path.lineTo(triangleOffset.dx  +10 , triangleOffset.dy +10  );
//     path.close();}
// else {
//   path.moveTo(triangleOffset.dx, triangleOffset.dy);
//   path.lineTo(triangleOffset.dx + 10, triangleOffset.dy - 10);
//   path.lineTo(triangleOffset.dx - 10, triangleOffset.dy - 10);
//   path.close();
// }
//     canvas.drawPath(path, _paint!);
//   }
// }