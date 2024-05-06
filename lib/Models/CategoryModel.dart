
import 'package:aqary/Models/RealStateModel.dart';

class CategoryModel {
  final String id;
  final String title;
  final List<RealStateModel> properties;
  final String createdAt;
  final String updatedAt;
  final int v;

  CategoryModel({
    required this.id,
    required this.title,
    required this.properties,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      properties: RealStateModel.listFromJson(json['properties'] ?? []),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  static List<CategoryModel> listFromJson(List dataJson){
    return dataJson.map((e) => CategoryModel.fromJson(e)).toList();
  }
}

// class Property {
//   final String id;
//   final List<String> images;
//   final String title;
//   final Country country;
//   final City city;
//   final int bathroomsCount;
//   final int bedroomsCount;
//   final int yearPrice;
//   final String createdAt;
//   final String updatedAt;
//   final int v;
//   final bool isFavorite;
//
//   Property({
//     required this.id,
//     required this.images,
//     required this.title,
//     required this.country,
//     required this.city,
//     required this.bathroomsCount,
//     required this.bedroomsCount,
//     required this.yearPrice,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.isFavorite,
//   });
//
//   factory Property.fromJson(Map<String, dynamic> json) {
//     return Property(
//       id: json['_id'] ?? '',
//       images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
//       title: json['title'] ?? '',
//       country: Country.fromJson(json['country'] ?? {}),
//       city: City.fromJson(json['city'] ?? {}),
//       bathroomsCount: json['bathrooms_count'] ?? 0,
//       bedroomsCount: json['bedrooms_count'] ?? 0,
//       yearPrice: json['year_price'] ?? 0,
//       createdAt: json['createdAt'] ?? '',
//       updatedAt: json['updatedAt'] ?? '',
//       v: json['__v'] ?? 0,
//       isFavorite: json['isFavorite'] ?? false,
//     );
//   }
//
//   static List<Property> listFromJson(List jsonData){
//     return jsonData.map((e) => Property.fromJson(e)).toList();
//   }
// }

class Country {
  final String id;
  final String name;

  Country({
    required this.id,
    required this.name,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class City {
  final String id;
  final String name;

  City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}