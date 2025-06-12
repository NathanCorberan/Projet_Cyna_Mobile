class CartItem {
  final int productId;
  final String name;
  final String image;
  double price;
  int quantity;
  int? subscriptionTypeId;

  CartItem({
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
    this.subscriptionTypeId,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['product_id'],
      name: json['name'],
      image: json['image'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: json['quantity'] ?? 1,
      subscriptionTypeId: json['subscription_type_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'subscription_type_id': subscriptionTypeId ?? 0,
    };
  }
}
