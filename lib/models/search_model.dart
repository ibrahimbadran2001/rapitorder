class SearchModel {
  List<FoodSearch> foods;
  List<RestaurantSearch> restaurants;

  SearchModel({
    required this.foods,
    required this.restaurants,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    List<FoodSearch> foods = (json['foods'] as List)
        .map((foodJson) => FoodSearch.fromJson(foodJson))
        .toList();

    List<RestaurantSearch> restaurants = (json['restaurants'] as List)
        .map((restaurantJson) => RestaurantSearch.fromJson(restaurantJson))
        .toList();

    return SearchModel(
      foods: foods,
      restaurants: restaurants,
    );
  }
}
class FoodSearch {
  int id;
  String name;
  String picture;
  double price;
  int restaurant;
  int category;

  FoodSearch({
    required this.id,
    required this.name,
    required this.picture,
    required this.price,
    required this.restaurant,
    required this.category,
  });

  factory FoodSearch.fromJson(Map<String, dynamic> json) {
    return FoodSearch(
      id: json['id'],
      name: json['name'],
      picture: json['picture'],
      price: double.parse(json['price']),
      restaurant: json['restaurant'],
      category: json['category'],
    );
  }
}

class RestaurantSearch {
  int id;
  String name;
  String address;
  String picture;

  RestaurantSearch({
    required this.id,
    required this.name,
    required this.address,
    required this.picture,
  });

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) {
    return RestaurantSearch(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      picture: json['picture'],
    );
  }
}