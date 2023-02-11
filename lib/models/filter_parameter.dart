class FilterParams {
  FilterParamsBody? body;

  @override
  String get urlParams {
    String result = "";

    if (body!.withminPrice) {
      result = result + "min_price=" + body!.min_price.toString() + "&";
    }
    if (body!.withMaxPrice) {
      result = result + "max_price=" + body!.max_price.toString() + "&";
    }
    if (body!.categroyIds != null) {
      result = result + "category=" + body!.categroyIds.toString() + "&";
    }
    if (body!.tagIds != null) {
      result = result + "tag=" + body!.tagIds.toString();
    }

    return result;
  }

  FilterParams({this.body});

  @override
  List<Object?> get props => [body];
}

class FilterParamsBody {
  double? min_price;
  double? max_price;
  String? categroyIds;
  String? tagIds;
  bool withminPrice;
  bool withMaxPrice;
  bool withCategoryIds;

  Map<String, dynamic> toJson() {
    return {
      'min_price': min_price,
      'max_price': max_price,
      "category": categroyIds,
      "tag": tagIds
    };
  }

  FilterParamsBody({
    this.min_price,
    this.max_price,
    this.categroyIds,
    this.tagIds,
    this.withminPrice: false,
    this.withMaxPrice = false,
    this.withCategoryIds = false,
  });
}
