class FoodModel {
  final int id;
  final String name;
  final String picture;
  final String price;
  final int restaurant;
  final int category;

  FoodModel({required this.id, required this.name,required this.picture,required this.price,required this.restaurant,required this.category, });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      price: json['price'],
      restaurant: json['restaurant'],
      category: json['category'],
    );
  }
}
class FoodByCategoryModel {
  final List<FoodModel> foodByCategory;

  FoodByCategoryModel({required this.foodByCategory});

  factory FoodByCategoryModel.fromJson(List<dynamic> json) {
    List<FoodModel> foodByCategory = json.map((item) => FoodModel.fromJson(item)).toList();
    return FoodByCategoryModel(foodByCategory: foodByCategory);
  }
}