class RestaurantFoodModel {
  final int id;
  final String name;
  final String picture;
  final String price;
  final int restaurant;
  final int category;

  RestaurantFoodModel(
      {required this.id,
        required this.name,
        required this.picture,
        required this.price,
        required this.restaurant,
        required this.category});
  factory RestaurantFoodModel.fromJson(Map<String, dynamic> json) {
    return RestaurantFoodModel(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      price: json['price'],
      restaurant: json['restaurant'],
      category: json['category'],
    );
  }
}

class RestaurantFood {
  final List<RestaurantFoodModel> restaurentFood;

  RestaurantFood({required this.restaurentFood});

  factory RestaurantFood.fromJson(List<dynamic> json) {
    List<RestaurantFoodModel> restaurentsFood =
    json.map((item) => RestaurantFoodModel.fromJson(item)).toList();
    return RestaurantFood(restaurentFood: restaurentsFood);
  }
}