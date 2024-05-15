class RestaurantItemDetailModel{
  final int id ;
  final String name;
  final String address;
  final String picture;
  final String desc;

  RestaurantItemDetailModel({required this.id,required this.name,required this.address,required this.picture,required this.desc});
  factory RestaurantItemDetailModel.fromJson(Map<String,dynamic> json){
    return RestaurantItemDetailModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      picture: json['picture'],
      desc: json['desc'],
    );
  }
}