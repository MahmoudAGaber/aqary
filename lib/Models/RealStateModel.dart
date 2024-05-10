
import 'dart:io';

class RealStateResponse{
  RealStateModel data;

  RealStateResponse({required this.data});

  factory RealStateResponse.fromJson(Map json){
    return RealStateResponse(data: RealStateModel.fromJson(json['data']));
  }
}


class RealStateModel {
  final String? id;
  final List<dynamic> images;
  final String title;
  final String country;
  final String city;
  final int bathroomsCount;
  final int bedroomsCount;
  final String location;
  final dynamic yearPrice;
  final String type;
  final double long;
  final double lat;
  final String description;
  final String? paymentDuration;
  final List<dynamic> videos;
  final String? promotion;
  final String? promotion_expire_at;
  final bool isAvailable;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  bool isFavorite;
  final dynamic createdBy;
  final List<dynamic>? managers;
  final dynamic? distance;
  String? deleted_images;
  String? deleted_videos;


  RealStateModel({
    required this.title,
    required this.images,
    required this.bathroomsCount,
    required this.bedroomsCount,
    required this.country,
    required this.city,
    required this.yearPrice,
    required this.type,
    required this.location,
    required this.long,
    required this.lat,
    required this.description,
    this.paymentDuration,
    required this.videos,
    this.promotion,
    this.promotion_expire_at,
    required this.isAvailable,
    this.id,
     this.createdAt,
     this.updatedAt,
     this.v,
    required this.isFavorite,
    this.createdBy,
    this.managers,
    this.distance,
    this.deleted_images,
    this.deleted_videos
  });

  factory RealStateModel.fromJson(Map<String, dynamic> json) {
    return RealStateModel(
      title: json['title'] ??"",
      images: (json['images'] as List<dynamic>?)?.map((image) => File(image)).toList() ?? [],
      bathroomsCount: json['bathrooms_count']??0,
      bedroomsCount: json['bedrooms_count']??0,
      country: json['country'] ?? "",
      city: json['city']??"",
      yearPrice: json['price']?? 0,
      type: json['type']??"",
      location: json['location']??"",
      long: json['long']??0,
      lat: json['lat'] ??0,
      description: json['description']??"",
      paymentDuration: json['payment_duration']??"",
      videos: (json['videos'] as List<dynamic>?)?.map((video) => File(video)).toList() ?? [],
      promotion: json['promotion']??"",
      promotion_expire_at : json['promotion_expire_at'] ?? "",
      isAvailable: json['is_available']??false,
      id: json['_id']??"",
      createdAt: json['createdAt']??"",
      updatedAt: json['updatedAt']??"",
      v: json['__v'] ??0,
      isFavorite: json['isFavorite']??false,
      createdBy: json['created_by'] ?? CreatedBy.fromJson(json['created_by']?? null),
      managers: json['managers'] ?? [],
        distance: json['distance'] ?? 0

    );
  }


  Map<String, String> toJson() {
    return {
      'title': title,
      //'images': images.map((image) => image.path).toList(),
      'bathrooms_count': bathroomsCount.toString(),
      'bedrooms_count': bedroomsCount.toString(),
      'country': country,
      'city': city,
      'price': yearPrice.toString(),
      'type': type,
      'location': location,
      'long': long.toString(),
      'lat': lat.toString(),
      'description': description,
      'payment_duration': paymentDuration.toString(),
      //'videos': videos.map((video) => video.path).toList(),
      //'promotion': promotion.toString(),
      'is_available': isAvailable.toString(),
      'deleted_images': deleted_images.toString(),
      'deleted_videos': deleted_videos.toString(),
     // 'id': id,
     // 'createdAt': createdAt,
      //'updatedAt': updatedAt,
      //'v': v,
      //'isFavorite': isFavorite,
    };
  }


  static List<RealStateModel> listFromJson(List jsonData){
    return jsonData.map((e) => RealStateModel.fromJson(e)).toList();
  }

  RealStateModel copyWith({
    String? title,
    List<dynamic>? images,
    int? bathroomsCount,
    int? bedroomsCount,
    String? country,
    String? city,
    double? yearPrice,
    String? type,
    String? location,
    double? long,
    double? lat,
    String? description,
    String? payment_duration,
    List<dynamic>? videos,
    String? promotion,
    bool? is_available,
    String? id,
    String? createdAt,
    String? updatedAt,
    int? v,
    bool? isFavorite,
  }) => RealStateModel(
    title: title ?? this.title,
    images: images ?? this.images,
    bathroomsCount: bathroomsCount ?? this.bathroomsCount,
    bedroomsCount: bedroomsCount ?? this.bedroomsCount,
    country: country ?? this.country,
    city: city ?? this.city,
    yearPrice: yearPrice ?? this.yearPrice,
    type: type ?? this.type,
    location: location ?? this.location,
    long: long ?? this.long,
    lat: lat ?? this.lat,
    description: description ?? this.description,
    paymentDuration: payment_duration ?? this.paymentDuration,
    videos: videos ?? this.videos,
    promotion: promotion ?? this.promotion,
    isAvailable: is_available ?? this.isAvailable,
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    v: v ?? this.v,
    isFavorite: isFavorite ?? this.isFavorite,
  );

}
class CreatedBy {
  final String? name;
  final String? phone;
  final String? avatar;
  final String? firebase_id;

  CreatedBy({
     this.name,
     this.phone,
    this.avatar,
    this.firebase_id
  });

  // Method to create a CreatedBy instance from JSON
  factory CreatedBy.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return CreatedBy(
          name: json['name'] ?? '',
          phone: json['phone'] ?? '',
          avatar: json['avatar'] ?? '',
          firebase_id: json['firebase_id'] ?? ''
      );
    } else {
      return CreatedBy();
    }
  }
}
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}