import 'Product.dart';

class DataFull  {
  List<Product> localWishItems;
  List<Product> localCartItems;
  Map<String, dynamic> wpUserInfo;
  Map<String, dynamic> success;
  Map<String, dynamic> wcUserInfo;

  DataFull({
    required this.localWishItems,required this.localCartItems,
    required this.wpUserInfo,
    required this.success,
    required this.wcUserInfo
});
}