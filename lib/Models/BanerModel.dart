
class BannerModel {
  final String id;
  final String title;
  final String image;
  final String createdAt;
  final String updatedAt;
  final int v;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }

  static List<BannerModel> listFromJson(List jsonData){
    return jsonData.map((e) => BannerModel.fromJson(e)).toList();
  }
}