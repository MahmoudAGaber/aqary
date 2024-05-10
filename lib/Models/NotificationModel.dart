
class NotificationModel {
  final String id;
  final String type;
  LocalizedText title;
  LocalizedText body;
  bool isRead;
  final String user;
  final String contract;
  final String createdAt;
  final String updatedAt;
  final int v;

  NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.user,
    required this.contract,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      type: json['type'],
      title: LocalizedText.fromJson(json['title']),
      body: LocalizedText.fromJson(json['body']),
      isRead: json['is_read'],
      user: json['user'],
      contract: json['contract'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'type': type,
      'title': title.toJson(),
      'body': body.toJson(),
      'is_read': isRead,
      'user': user,
      'contract': contract,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }

  static List<NotificationModel> listFromJson(List jsonData){
    return jsonData.map((e) => NotificationModel.fromJson(e)).toList();
  }
}

class LocalizedText {
  String ar;
  String en;

  LocalizedText({
    required this.ar,
    required this.en,
  });

  factory LocalizedText.fromJson(Map<String, dynamic> json) => LocalizedText(
    ar: json['ar'],
    en: json['en'],
  );

  Map<String, dynamic> toJson() => {
    'ar': ar,
    'en': en,
  };
}