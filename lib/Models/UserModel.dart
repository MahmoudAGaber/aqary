
import 'package:aqary/Models/RealStateModel.dart';

class UserModel {
  final String id;
  final String firebaseId;
  final String phone;
  List<RealStateModel> favorites;
  final List<String> recentLocations;
  List<RealStateModel> properties;
  final String deviceToken;
  final List<String> searchHistory;
  List<RealStateModel> recentlySeen;
  final String name;
  final bool notificationEnabled;
  final String pic;
  final String? createdAt;
  final String updatedAt;
  final int? v;
  final List<dynamic> contracts;

  UserModel({
    required this.id,
    required this.firebaseId,
    required this.phone,
    required this.favorites,
    required this.recentLocations,
    required this.properties,
    required this.deviceToken,
    required this.searchHistory,
    required this.recentlySeen,
    required this.name,
    required this.notificationEnabled,
    required this.pic,
    this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.contracts
      });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firebaseId: json['firebase_id'],
      phone: json['phone'] ?? '', // Provide a default value if phone is null
      favorites: RealStateModel.listFromJson(json['favorites'] ?? []),
      recentLocations: List<String>.from(json['recent_locations'] ?? []),
      properties: RealStateModel.listFromJson(json['properties'] ?? []),
      deviceToken: json['device_token'] ?? '',
      searchHistory: List<String>.from(json['search_history'] ?? []),
      recentlySeen: RealStateModel.listFromJson(json['recently_seen'] ?? []),
      name: json['name'] ?? '',
      notificationEnabled: json['notification_enabled'] ?? false,
      pic: json['pic'] ?? '',
      createdAt: json['createdAt']??"",
      updatedAt: json['updatedAt']??"",
      v: json['__v'] ??0,
      contracts: json['contracts'] ?? []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firebase_id': firebaseId,
      'phone': phone,
      'favorites': favorites,
      'recent_locations': recentLocations,
      'properties': properties,
      'device_token': deviceToken,
      'search_history': searchHistory,
      'recently_seen': recentlySeen,
      'name': name,
      'notification_enabled': notificationEnabled,
      'pic': pic,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }

  UserModel copyWith({
    String? id,
    String? firebaseId,
    String? phone,
    List<RealStateModel>? favorites,
    List<String>? recentLocations,
    List<RealStateModel>? properties,
    int? v,
    String? updatedAt,
    String? deviceToken,
    List<String>? searchHistory,
    List<RealStateModel>? recentlySeen,
    bool? notificationEnabled,
    String? name,
    String? pic,
    List<dynamic>? contracts
  }) => UserModel(
      id:id ?? this.id,
      firebaseId:firebaseId ?? this.firebaseId,
      phone:phone ?? this.phone,
      favorites: favorites?? this.favorites,
      recentLocations:recentLocations ?? this.recentLocations,
      properties:properties ?? this.properties,
      deviceToken: deviceToken ?? this.deviceToken,
      searchHistory: searchHistory ?? this.searchHistory,
      recentlySeen: recentlySeen?? this.recentlySeen,
      notificationEnabled:notificationEnabled ?? this.notificationEnabled,
      name: name?? this.name,
      pic: pic ?? this.pic,
      v:v ?? this.v,
    updatedAt: updatedAt ?? this.updatedAt,
    contracts: contracts ?? this.contracts

  );


}

class ManagerModel {
  final String phone;
  final String name;
  List<String> properties;

  ManagerModel({
    required this.phone,
    required this.name,
    required this.properties,
  });

  factory ManagerModel.fromJson(Map<String, dynamic> json) {
    return ManagerModel(
      phone: json['phone'],
      name: json['name'],
      properties: List<String>.from(json['properties']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'name': name,
      'properties': properties,
    };
  }
}