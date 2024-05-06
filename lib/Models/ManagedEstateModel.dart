
class ManagedEstateModel {
  String id;
  int rent;
  int monthly;
  int paid;

  ManagedEstateModel({
    required this.id,
    required this.rent,
    required this.monthly,
    required this.paid,
  });

  factory ManagedEstateModel.fromJson(Map<String, dynamic> json) {
    return ManagedEstateModel(
      id: json['id'],
      rent: json['rent'],
      monthly: json['monthly'],
      paid: json['paid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rent': rent,
      'monthly': monthly,
      'paid': paid,
    };
  }

  static List<ManagedEstateModel> listFromJson(List jsonData){
    return jsonData.map((e) => ManagedEstateModel.fromJson(e)).toList();
  }
}
