class MealModel {
  final int id;
  final String name;
  final String picture;
  final String price;
  final int restaurant;
  final int category;
  final String description;

  MealModel({
    required this.id,
    required this.name,
    required this.picture,
    required this.price,
    required this.restaurant,
    required this.category,
    required this.description,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      price: json['price'],
      restaurant: json['restaurant'],
      category: json['category'],
      description: json['desc'],
    );
  }
}