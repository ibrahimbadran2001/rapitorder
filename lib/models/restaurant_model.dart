class RestaurantItemModel {
  final int id;
  final String name;
  final String address;
  final String picture;

  RestaurantItemModel(
      {required this.id,
        required this.name,
        required this.address,
        required this.picture});
  factory RestaurantItemModel.fromJson(Map<String, dynamic> json) {
    return RestaurantItemModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      picture: json['picture'],
    );
  }
}

class RestaurantList {
  final List<RestaurantItemModel> restaurent;

  RestaurantList({required this.restaurent});

  factory RestaurantList.fromJson(List<dynamic> json) {
    List<RestaurantItemModel> restaurents =
    json.map((item) => RestaurantItemModel.fromJson(item)).toList();
    return RestaurantList(restaurent: restaurents);
  }
}