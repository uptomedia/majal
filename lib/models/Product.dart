class Product {
  Map<String, dynamic> data = {};
  int quantity = 1;
  String? item_key;

  Product(
    Map<String, dynamic> data,
  ) {
    this.data = data;
    quantity = quantity;
  }

  @override
  bool operator ==(other) {
    return other is Product && this.data['id'] == other.data['id'];
  }

  bool isSameAs(Product item) {
    return this.data['id'] == item.data['id'];
  }

  @override
  int get hashCode => this.data['id'].hashCode;
}
