class BannerModel {
  final int id;
  final String banner;

  BannerModel({required this.id, required this.banner});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      banner: json['picture'],
    );
  }
}
class ListBannersModel {
  final List<BannerModel> banners;

  ListBannersModel({required this.banners});

  factory ListBannersModel.fromJson(List<dynamic> json) {
    List<BannerModel> banners = json.map((item) => BannerModel.fromJson(item)).toList();
    return ListBannersModel(banners: banners);
  }
}