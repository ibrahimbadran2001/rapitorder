
class DataModel {
  String ? id;
  String ? favoriteDish;
  String ?imageUrl;
  int ? price;
  int ? platesAvailable;
  bool ? isFav;

  DataModel({
    this.id,
    this.favoriteDish,
    this.imageUrl,
    this.price,
    this.platesAvailable,
    this.isFav
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['_id'],
      favoriteDish: json['favoriteDish'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      platesAvailable: json['platesAvailable'],
      isFav: json['isFav'],
    );
  }
   Map<String, dynamic>toMap() {
    return {
      //"id": id,
      "favoriteDish": favoriteDish,
      "imageUrl": imageUrl,
      "price": price,
      "platesAvailable": platesAvailable,
      "isFav": isFav,
    };
  }
}