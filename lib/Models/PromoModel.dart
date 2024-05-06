
class PromoResponseModel {
   List<PromoModel> data;

   PromoResponseModel({required this.data});

   factory PromoResponseModel.fromJson(Map<String, dynamic> json) {
     return PromoResponseModel(
         data: PromoModel.listfromJson(json['data']),);
   }
}



class PromoModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int duration;

  PromoModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.duration,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      duration: json['duration'],
    );
  }

  static List<PromoModel> listfromJson(List jsonData){
    return jsonData.map((e) => PromoModel.fromJson(e)).toList();
  }
}