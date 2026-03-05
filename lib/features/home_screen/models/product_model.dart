class ProductsModel {
  final List<ProductData> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  ProductsModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ProductData.fromJson(e))
              .toList() ??
          [],
      page: json['page'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
    );
  }
}

class ProductData {
  final String id;
  final String productCode;
  final String name;
  final String description;
  final String? coverPictureUrl;
  final String arabicName;
  final double price;
  final num rating;
  final num reviewsCount;
  final int stock;
  final String color;
  final List<String> categories;
  final List<String>? productPictures;

  ProductData({
    required this.id,
    required this.productCode,
    required this.name,
    required this.description,
    this.coverPictureUrl,
    required this.arabicName,
    required this.price,
    required this.stock,
    required this.color,
    required this.categories,
    this.productPictures,
    required this.rating,
    required this.reviewsCount,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      productCode: json['productCode'],
      coverPictureUrl: json['coverPictureUrl'] ?? '',
      name: json['name'],
      description: json['description'],
      arabicName: json['arabicName'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      color: json['color'],
      categories: List<String>.from(json['categories'] ?? []),
      productPictures: json['productPictures'] != null
          ? List<String>.from(json['productPictures'])
          : null,
      rating: json['rating'],
      reviewsCount: json['reviewsCount'],
    );
  }
}
