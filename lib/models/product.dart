class Product {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final String stock;
  final int available_stock;
  final int? subscriptionTypeId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.stock,
    required this.available_stock,
    this.subscriptionTypeId,
  });

  factory Product.fromJson(Map<String, dynamic> item) {
    final name = (item['productLangages'] != null && item['productLangages'].isNotEmpty)
        ? item['productLangages'][0]['name'] ?? 'Nom indisponible'
        : 'Nom indisponible';

    final description = (item['productLangages'] != null && item['productLangages'].isNotEmpty)
        ? item['productLangages'][0]['description'] ?? 'Description indisponible'
        : 'Description indisponible';

    final image = (item['productImages'] != null && item['productImages'].isNotEmpty)
        ? item['productImages'][0]['image_link'] ?? ''
        : '';

    String priceRaw = '';
    if (item['subscriptionTypes'] != null && item['subscriptionTypes'].isNotEmpty) {
      priceRaw = item['subscriptionTypes'][0]['price'] ?? '';
    }

    // Enlever le '€' et convertir en double
    String priceString = priceRaw.replaceAll('€', '').trim();
    double price = double.tryParse(priceString) ?? 0.0;

    final subscriptionTypeId = (item['subscriptionTypes'] != null && item['subscriptionTypes'].isNotEmpty)
        ? item['subscriptionTypes'][0]['id']
        : null;

    final availableStock = item['available_stock'] ?? 0;
    final stock = availableStock > 0 ? 'Disponible' : 'Indisponible';

    return Product(
      id: item['id'] ?? 0,
      name: name,
      description: description,
      image: image,
      price: price,
      stock: stock,
      available_stock: availableStock,
      subscriptionTypeId: subscriptionTypeId,
    );
  }
}
