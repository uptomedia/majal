import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grodudes/core/configurations/styles.dart';
import 'package:grodudes/generated/l10n.dart';
import 'package:grodudes/helper/Constants.dart';
import 'package:grodudes/pages/account/OrderDetails.dart';
import 'package:grodudes/state/user_state.dart';
import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';

import '../../core/configurations/assets.dart';
import '../../core/utils.dart';
import '../../core/widget/majl/majal_app_bar.dart';
import '../../routing/route_paths.dart';
import '../../state/cart_state.dart';
import '../SearchResultsPage.dart';
import 'LogInPage.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  int _page = 0;
  bool? _isLoadingData;
  Map<int, dynamic>? _orders;
  bool? _allFetched;
  bool? _dataInitialized;
  bool? _errorAfterFetch;
  TextEditingController? _searchController;

  @override
  initState() {
    this._page = 1;
    this._isLoadingData = false;
    this._orders = {};
    this._allFetched = false;
    this._dataInitialized = false;
    this._errorAfterFetch = false;
    this._searchController = TextEditingController();

    super.initState();
  }

  reload() {
    setState(() {
      this._page = 1;
      this._isLoadingData = false;
      this._orders = {};
      this._allFetched = false;
      this._dataInitialized = false;
      this._errorAfterFetch = false;
      this._orders!.clear();
    });
  }

  showOrderCancelStatusDialog(bool success) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(success
            ? S.of(context).successfullyRequestedOrderCancellation
            : S.of(context).failedToCancelOrder),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(S.of(context).ok,
                style:
                    TextStyle(color: GrodudesPrimaryColor.primaryColor[600])),
          ),
        ],
      ),
    );
  }

  Future _cancelOrder(Map<String, dynamic> order) async {
    try {
      var response = await Provider.of<UserManager>(context, listen: false)
          .cancelOrder(order['id']);
      Navigator.pop(context);
      if (response is Map && response['id'] == order['id']) {
        showOrderCancelStatusDialog(true);
        reload();
      } else {
        throw Exception(S.of(context).cancellationFailed);
      }
    } catch (err) {
      print(err);
      Navigator.pop(context);
      showOrderCancelStatusDialog(false);
      return;
    }
  }

  Future _cancelOrderConfirmation(Map<String, dynamic> order) async {
    bool isSure = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0),
        content: Container(
            width: 356.w,
            height: 218.h,
            decoration: Styles.tilesDecoration,
            padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox(height: 39.h,),
                Expanded(child: Container()),
                Container(
                  // width: 206.w,
                  // height: 56.h,
                  child: Text(
                    S.of(context).areyouSureYouWant,
                    style: Styles.boldTextStyle
                        .copyWith(fontSize: Styles.fontSize21),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 18.h,
                  child: Text(S.of(context).thisWillDelete,
                      style: Styles.regularTextStyle
                          .copyWith(fontSize: Styles.fontSize13)),
                ),
                SizedBox(
                  height: 10.h,
                ),

                Expanded(
                    child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          isSure = false;
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 43.h,
                          width: 142.w,
                          child: Center(
                            child: Text(
                              S.of(context).goback,
                              style: Styles.boldTextStyle.copyWith(
                                  fontSize: Styles.fontSize18,
                                  color: Styles.colorFontTitle),
                            ),
                          ),
                        )),
                    InkWell(
                        onTap: () async {
                          isSure = true;
                          _cancelOrder(order);
                        },
                        child: Container(
                            height: 43.h,
                            width: 142.w,
                            decoration: Styles.roundedDecoration
                                .copyWith(color: Styles.ColorLogout),
                            child: Center(
                              child: Text(S.of(context).delete,
                                  style: Styles.boldTextStyle.copyWith(
                                      fontSize: Styles.fontSize18,
                                      color: Colors.white)),
                            ))),
                  ],
                )),
                Expanded(child: Container()),
              ],
            )),
      ),
    ).catchError((err) {
      isSure = false;
    });
    if (!isSure) {
      print('User is not sure');
      return;
    }
  }

  Future getMoreOrders() async {
    if (this._isLoadingData! || this._allFetched!) return;
    setState(() {
      this._isLoadingData = true;
    });
    try {
      var fetchedOrders = await Provider.of<UserManager>(context, listen: false)
          .getOrders(this._page!);
      if (fetchedOrders != null) {
        this._dataInitialized = true;
        if (!(fetchedOrders is List) && fetchedOrders == false) {
          setState(() {
            this._isLoadingData = false;
            this._errorAfterFetch = true;
          });
          return;
        }
        if (fetchedOrders.length == 0) {
          setState(() {
            this._errorAfterFetch = false;
            this._isLoadingData = false;
            this._allFetched = true;
          });
        } else {
          setState(() {
            fetchedOrders
                .forEach((order) => this._orders![order['id']!] = order);
            this._errorAfterFetch = false;
            this._isLoadingData = false;
            this._page++;
          });
        }
      } else {
        throw Exception(S.of(context).recievedNullResponse);
      }
    } catch (err) {
      print(err);
      setState(() {
        this._errorAfterFetch = true;
        this._isLoadingData = false;
      });
    }
  }

  bool _scrollNotificationHandler(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;

      if (before == max) {
        getMoreOrders();
      }
    }
    return false;
  }

  openSearchPage(String searchQuery) {
    WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
    this._searchController!.clear();
    Utils.pushNewScreenWithRouteSettings(context,
        settings: RouteSettings(name: RoutePaths.SearchResultsPage),
        withNavBar: false,
        screen: SearchResultsPage(searchQuery));
  }

  @override
  Widget build(BuildContext context) {
    if (!this._dataInitialized! &&
        !this._isLoadingData! &&
        !this._errorAfterFetch!) {
      getMoreOrders();
    }
    return Scaffold(
      backgroundColor: Styles.colorBackGround,
      // appBar: AppBar(
      //     iconTheme: IconThemeData(color: Colors.black87, size: 36),
      //     backgroundColor: Styles.colorBackGround,
      //     title: Text(
      //       S.of(context).yourOrders,
      //       style: Styles.appBarTextStyle,
      //     )),
      body: Container(
          // height:MediaQuery.of(context).size.height ,
          child: Consumer<UserManager>(builder: (context, user, child) {
        var logInStatus = user.getLogInStatus();
        return logInStatus == logInStates.pending
            ? Center(
                child: CircularProgressIndicator(
                color: Styles.colorPrimary,
              ))
            : logInStatus != logInStates.loggedIn
                ? LoginPage()
                : Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Container(
                      // height: 25.h,
                      // width: 360.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.h, vertical: 16.h),
                      // decoration: Styles.textFieldDecoration,

                      child: Row(
                        children: <Widget>[
                          // SizedBox(width: 16.w,),
                          SizedBox(
                              width: 26.w,
                              child: GestureDetector(
                                  onTap: () => openSearchPage(
                                      this._searchController!.text),
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
                                  onTap: () => openSearchPage(
                                      this._searchController!.text),
                                  child: Consumer<CartManager>(
                                      builder: (context, userManager, child) {
                                    return Badge(
                                        badgeColor: Styles.colorPrimary,
                                        shape: BadgeShape.circle,
                                        showBadge: Provider.of<CartManager>(
                                                    context,
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
                        child: this._dataInitialized!
                            ? this._orders!.length == 0 && this._allFetched!
                                ? Center(
                                    child: Text(
                                      S.of(context).youHaveNoOrders,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                : Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 21.h,
                                        ),
                                        SizedBox(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                S.of(context).orders +
                                                    "(${this._orders!.length})",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily:
                                                        Styles.FontFamily),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.filter_alt),
                                                  Center(
                                                    child: Text(
                                                      S.of(context).filters +
                                                          "(${this._orders!.length})",
                                                      style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: Styles
                                                              .FontFamily),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                        SizedBox(
                                          height: 11.h,
                                        ),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              child: Text(
                                                S.of(context).totalValue +
                                                    " ${this._orders!.length} JD",
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily:
                                                        Styles.FontFamily),
                                              ),
                                            )),
                                        Expanded(
                                            // height: 500,
                                            child: NotificationListener(
                                          onNotification:
                                              _scrollNotificationHandler,
                                          child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                height: 30.h,
                                              );
                                            },
                                            // padding: EdgeInsets.symmetric(horizontal: 8),
                                            scrollDirection: Axis.vertical,
                                            itemCount: this._orders!.length + 1,
                                            itemBuilder: (context, index) {
                                              if (index ==
                                                  this._orders!.length) {
                                                if (this._errorAfterFetch!) {
                                                  if (this._isLoadingData!) {
                                                    return Container(
                                                      margin: EdgeInsets.all(8),
                                                      alignment:
                                                          Alignment.center,
                                                      child:
                                                          // _buildWailtin()
                                                          CircularProgressIndicator(
                                                        color:
                                                            Styles.colorPrimary,
                                                      ),
                                                    );
                                                  }
                                                  return Container(
                                                    margin: this
                                                                ._orders!
                                                                .length ==
                                                            0
                                                        ? EdgeInsets.only(
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.3)
                                                        : EdgeInsets.all(8),
                                                    child: _FetchErrorWidget(),
                                                  );
                                                }

                                                if (this._allFetched! ||
                                                    !this._isLoadingData!)
                                                  return SizedBox(height: 0);
                                                return Center(
                                                    child:
                                                        // _buildWailtin()
                                                        CircularProgressIndicator(
                                                  color: Styles.colorPrimary,
                                                ));
                                              }
                                              return _OrderCard(
                                                order: this
                                                    ._orders!
                                                    .values
                                                    .elementAt(index),
                                                cancelOrderCb:
                                                    _cancelOrderConfirmation,
                                              );
                                            },
                                          ),
                                        ))
                                      ],
                                    ),
                                  )
                            : this._errorAfterFetch!
                                ? Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(8),
                                    child: _FetchErrorWidget(),
                                  )
                                : Center(
                                    child:
                                        // _buildWailtin()
                                        CircularProgressIndicator(
                                    color: Styles.colorPrimary,
                                  )))
                  ]);
      })),
    );
  }

//         _buildWailtin(){
//     return  Shimmer.fromColors(
//       baseColor: Colors.grey.shade400 ,
//       highlightColor: Colors.grey.shade100,
//       enabled: true,
//
//
//
//
//
//
//               child:
//
//
//               Column(children: [
//
//                 SizedBox(height: 50.h,),
//
//
//                 ListView.separated(
// shrinkWrap: true,
//                 separatorBuilder: (context, index) {
//                   return SizedBox(
//                     height: 30.h,
//                   );
//                 },
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 scrollDirection: Axis.vertical,
//                 itemCount:3 ,
//                 itemBuilder: (context, index) {
//
//
//
//                   return
//                   Center(child:
// Container(
//     width: 280.w,
//
//     child:
//
//                     Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//
//                       Row(children: [
//
//
//                         Text(
//                             S.of(context).orderID ,
//                             style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize29)
//                         ),
//                         Expanded(child: Container()),
//                         SizedBox(
//                             height: 24.8.h,
//                             width: 39.h,
//
//                             child:
//                             SvgPicture.asset(
//                               Assets.SVG_order,
// // color: Styles.colorprimary,
//                               // allowDrawingOutsideViewBox: true,
//
//                               // height: 24.8.h,
//                               // width: 39.h,
//
//                             ))
//
//                       ],),            SizedBox(height: 5),
//
//                       Text(S.of(context).status,
//                           style: Styles.regularTextStyle.copyWith(fontSize: Styles.fontSize17)
//                       ),
//                       SizedBox(height: 5),
//
//                       Text(
//                           S.of(context).placedOn ,
//                           style:Styles.regularTextStyle.copyWith(fontSize: Styles.fontSize17)
//                       ),
//                       SizedBox(height: 5),
//
//                       Text(
//                           S.of(context).items ,
//                           style: Styles.regularTextStyle.copyWith(fontSize: Styles.fontSize17)
//                       ),
//
//
//                       SizedBox(height: 8),
//                       // order['coupon_lines'].length > 0
//                       //     ? Text(
//                       //   S.of(context).currencyLogo+'${double.parse(order['total']) * double.parse(order['coupon_lines'][0]["discount"]) / 100}',
//                       //   style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize29)
//                       // )
//                       //     : Text(
//                       //   '₹${order['total']}',
//                       //   style: TextStyle(
//                       //     fontSize: 16,
//                       //     color: Styles.colorprimary[600],
//                       //     fontWeight: FontWeight.bold,
//                       //   ),
//                       // ),
//
//
//
//                           Container(
//                               width: 280.w,
//                               height: 54.h,
//                               decoration: Styles.roundedDecoration.copyWith(
//                                 color: Styles.colorPrimary,
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(27.r),
//                                 ),
//                               ),
//                               child:
//                               Center(child:
//                               Text(
//                                   S.of(context).details,
//                                   style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize24,color: Colors.white)
//                               ),)),
//
//
//                       Container(
//                           width: 280.w,
//                           height: 54.h,
//                           child:
//                             Container(
//                               width: 280.w,
//                               height: 54.h,
//                               child: Center(child:
//
//                               Text(
//                                   S.of(context).cancelOrder,
//                                   style:  Styles.meduimTextStyle
//                               ),
//                               ),
//                             ),)
//
//                     ],
//                     )  )  );
//                 },
//               ),
//
//
//
//           ])
//     );
//         }
}

class _FetchErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error, color: Colors.red[600], size: 36),
        Text(
          S.of(context).thereWasAnErrorInFetchingTheOrders,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({Key? key, required this.order, required this.cancelOrderCb})
      : super(key: key);

  final Map<String, dynamic> order;
  final Future Function(Map<String, dynamic>) cancelOrderCb;

  @override
  Widget build(BuildContext context) {
    final String date = order['date_created'].toString().substring(0, 10);
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 37.w),
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 19.h),
      // height: 54.h,
      width: 280.w,
      decoration: Styles.speicialOfferDecoration.copyWith(
          borderRadius: BorderRadius.all(
        Radius.circular(0.r),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.w),
                        color: Colors.amberAccent,

                        // width: 46.r,
                        child: Container(
                            height: 46.r,
                            width: 46.r,
                            // margin:
                            // Provider
                            //     .of<LocaleProvider>(context, listen: false)
                            //     .locale
                            //     .languageCode != "ar" ?
                            // EdgeInsets.only(left: 22.w, right: 68.w, top: 21.h) :
                            // EdgeInsets.only(right: 22.w, left: 68.w, top: 21.h),
                            child: Container(
                                decoration:
                                    Styles.shadowPrimaryDecoration.copyWith(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(34.r),
                                        ),
                                        boxShadow: []),
                                child: ClipRRect(
                                    // color: Colors.black,

                                    borderRadius: BorderRadius.circular(34.r),
                                    child: Image.asset(Assets.PNG_profile)
                                    // item.data['images'].length != 0
                                    //     ? ImageFetcher.getImage(
                                    //     item.data['images'][0]['src'])
                                    //     : ImageFetcher.getImage(""),
                                    ))))
                  ],
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("${order['line_items'][0]["name"]}" ?? "",
                            style: Styles.boldTextStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: Styles.fontSize11)),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                          width: 70.w,
                          height: 20.h,
                          decoration: Styles.roundedDecoration.copyWith(
                            color: Styles.ColorStatusOrder.withOpacity(0.33),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.r),
                            ),
                          ),
                          child: Center(
                            child: Text(order['status'].split('-').join(' '),
                                style: Styles.regularTextStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff1D8F78),
                                    fontSize: Styles.fontSize10)),
                          )),
                      SizedBox(height: 8.h),
                      Container(
                        child: Text(S.of(context).orderID + "${order['id']}",
                            style: Styles.boldTextStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: Styles.fontSize11)),
                      ),
                      SizedBox(height: 8),
                      Text(
                          S.of(context).placedOn +
                              date.split('-').reversed.join('//'),
                          style: Styles.regularTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: Styles.fontSize11)),
                      SizedBox(height: 8),
                      Text(
                          S.of(context).items +
                              '${order['line_items'].length} ${order['line_items'].length > 1 ? 'items' : 'item'}',
                          style: Styles.regularTextStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: Styles.fontSize11)),
                      SizedBox(height: 8),
                    ],
                  ),
                ))
              ]),
          InkWell(
              onTap: () => Utils.pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: RoutePaths.OrderDetails),
                    withNavBar: false,
                    screen: OrderDetails(order),
                  ),
              child: Center(
                  child: Container(
                      width: 300.w,
                      // height: 30.h,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                          border: Border.all(color: Styles.colorPrimary)),
                      child: Center(
                        child: Text(S.of(context).markAsReceived,
                            style: Styles.boldTextStyle.copyWith(
                                fontSize: Styles.fontSize11,
                                color: Styles.colorPrimary)),
                      )))),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}
// class _OrderCard extends StatelessWidget {
//   const _OrderCard({Key? key, required this.order, required this.cancelOrderCb})
//       : super(key: key);
//
//   final Map<String, dynamic> order;
//   final Future Function(Map<String, dynamic>) cancelOrderCb;
//
//   @override
//   Widget build(BuildContext context) {
//     final String date = order['date_created'].toString().substring(0, 10);
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 37.w),
//       padding: EdgeInsets.symmetric(horizontal: 37.w,vertical: 19.h),
//       // height: 54.h,
//       width: 280.w,
//       decoration: Styles.tilesDecoration,
//         child:
//           Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//
//
//                     Row(children: [
//
//
//                     Text(
//                       S.of(context).orderID + "${order['id']}",
//                       style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize29)
//                     ),
//     Expanded(child: Container()),
//     SizedBox(
//         height: 24.8.h,
//         width: 39.h,
//
//         child:
//     SvgPicture.asset(
//     Assets.SVG_order,
// // color: Styles.colorprimary,
//     // allowDrawingOutsideViewBox: true,
//
//     // height: 24.8.h,
//     // width: 39.h,
//
//     ))
//
//                     ],),            SizedBox(height: 5),
//
//               Text(S.of(context).status+
//                   order['status'].split('-').join(' '),
//                   style: Styles.regularTextStyle.copyWith(fontSize: Styles.fontSize17)
//               ),
//               SizedBox(height: 5),
//
//               Text(
//                       S.of(context).placedOn +
//                           date.split('-').reversed.join('//'),
//                       style:Styles.regularTextStyle.copyWith(fontSize: Styles.fontSize17)
//                     ),
//               SizedBox(height: 5),
//
//               Text(
//                      S.of(context).items+ '${order['line_items'].length} ${order['line_items'].length > 1 ? 'items' : 'item'}',
//                       style: Styles.regularTextStyle.copyWith(fontSize: Styles.fontSize17)
//                     ),
//
//
//                     SizedBox(height: 8),
//                     // order['coupon_lines'].length > 0
//                     //     ? Text(
//                     //   S.of(context).currencyLogo+'${double.parse(order['total']) * double.parse(order['coupon_lines'][0]["discount"]) / 100}',
//                     //   style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize29)
//                     // )
//                     //     : Text(
//                     //   '₹${order['total']}',
//                     //   style: TextStyle(
//                     //     fontSize: 16,
//                     //     color: Styles.colorprimary[600],
//                     //     fontWeight: FontWeight.bold,
//                     //   ),
//                     // ),
//
//
//               InkWell(
//
//                 onTap: () =>
//
//                     Utils.pushNewScreenWithRouteSettings(context,
//                       settings:
//                       RouteSettings(name: RoutePaths.OrderDetails),
//                       withNavBar: false,
//                       screen:  OrderDetails(order
//
//
//                       ),
//
//                     ),
//
//                 child:
//                 Container(
//                   width: 280.w,
//                   height: 54.h,
//                   decoration: Styles.roundedDecoration.copyWith(
//                     color: Styles.colorPrimary,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(27.r),
//                     ),
//                   ),
//                   child:
//                       Center(child:
//                 Text(
//                   S.of(context).details,
//                   style: Styles.boldTextStyle.copyWith(fontSize: Styles.fontSize24,color: Colors.white)
//                 ),))
//               ),
//
//               Container(
//                 width: 280.w,
//                 height: 54.h,
//                 child: order['status'].toString().contains('cancel')
//                     ? SizedBox(width: 0)
//                     : InkWell(
//                   onTap: () {
//                     if (order['status'] == 'dispatched') {
//                      _scaffoldKey.currentState!.showSnackBar(SnackBar(
//                           content: Text(S
//                               .of(context)
//                               .dispatchedOrdersCannotBeCancelled)));
//                       return;
//                     }
//                     cancelOrderCb(order).catchError((err) => print(err));
//                   },
//
//
//                   child:
//                   Container(
//                     width: 280.w,
//                     height: 54.h,
//                     child: Center(child:
//
//                   Text(
//                     S.of(context).cancelOrder,
//                     style:  Styles.meduimTextStyle
//                   ),
//                 ),
//                       ),)          ),
//               SizedBox(width: 8),
//
//             ],
//           ),
//
//     );
//   }
// }
