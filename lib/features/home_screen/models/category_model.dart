class CategoryModel {
  final List<CategoryData> categories;

  CategoryModel({required this.categories});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        categories: (json['categories'] as List<dynamic>?)
                ?.map((e) => CategoryData.fromJson(e))
                .toList() ??
            []);
  }
}

class CategoryData {
  final String id;
  final String name;
  final String description;
  final String coverPictureUrl;

  CategoryData(
      {required this.id,
      required this.name,
      required this.description,
      required this.coverPictureUrl});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        coverPictureUrl: json['coverPictureUrl'] ?? '');
  }
}
