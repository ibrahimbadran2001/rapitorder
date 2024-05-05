class CategoryItemModel {
  final int id;
  final String name;
  final String icon;

  CategoryItemModel({required this.id, required this.name,required this.icon});

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) {
    return CategoryItemModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}
class CategoriesModel {
  final List<CategoryItemModel> categories;

  CategoriesModel({required this.categories});

  factory CategoriesModel.fromJson(List<dynamic> json) {
    List<CategoryItemModel> categories = json.map((item) => CategoryItemModel.fromJson(item)).toList();
    return CategoriesModel(categories: categories);
  }
}