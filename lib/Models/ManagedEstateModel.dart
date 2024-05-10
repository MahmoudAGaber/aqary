

class ManagedEstateModel{
  List<Manage> manage;
  List<Renter> renter;

  ManagedEstateModel({required this.manage, required this.renter});

  factory ManagedEstateModel.fromJson(Map<String, dynamic> json) {
    return ManagedEstateModel(
      manage: Manage.listFromJson(json['manage']),
      renter:Renter.listFromJson(json['renter']),
    );
  }

}
class Manage {
  String id;
  dynamic rent;
  dynamic monthly;
  dynamic paid;

  Manage({
    required this.id,
    required this.rent,
    required this.monthly,
    required this.paid,
  });

  factory Manage.fromJson(Map<String, dynamic> json) {
    return Manage(
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

  static List<Manage> listFromJson(List jsonData){
    return jsonData.map((e) => Manage.fromJson(e)).toList();
  }
}


class Renter {
  final String propertyName;
  final String propertyLocation;
  final DateTime from;
  final DateTime to;
  final String paymentType;
  final dynamic paid;
  final dynamic rent;

  Renter({
    required this.propertyName,
    required this.propertyLocation,
    required this.from,
    required this.to,
    required this.paymentType,
    required this.paid,
    required this.rent,
  });

  factory Renter.fromJson(Map<String, dynamic> json) {
    return Renter(
      propertyName: json['property_name'],
      propertyLocation: json['property_location'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      paymentType: json['payment_type'],
      paid: json['paid'],
      rent: json['rent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'property_name': propertyName,
      'property_location': propertyLocation,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'payment_type': paymentType,
      'paid': paid,
      'rent': rent,
    };
  }

  static List<Renter> listFromJson(List jsonData){
    return jsonData.map((e) => Renter.fromJson(e)).toList();
  }
}
