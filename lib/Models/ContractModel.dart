import 'dart:io';

import 'package:aqary/Models/RealStateModel.dart';

class ContractModel {
  File file;
  String from;
  String to;
  String paymentDuration;
  String monthlyPrice;
  String paymentType;
  String note;
  File renter_signature;

  ContractModel(this.file, this.from, this.to, this.paymentDuration,
      this.monthlyPrice, this.paymentType, this.note,this.renter_signature);

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
      File(json['file']),
      json['from'] as String,
      json['to'] as String,
      json['payment_duration'] as String,
      json['monthly_price'] as String,
      json['payment_type'] as String,
      json['note'] as String,
      File(json['renter_signature']),
    );
  }

  Map<String, String> toJson() {
    return {
      // 'file': file.path,
      'from': from,
      'to': to,
      'payment_duration': paymentDuration,
      'monthly_price': monthlyPrice,
      'payment_type': paymentType,
      'note': note,
    };
  }
}

class ContractMineResponse {
  List<ContractMine> contractMine;
  ContractMineResponse({required this.contractMine});

  factory ContractMineResponse.fromJson(Map json) {
    return ContractMineResponse(
        contractMine: ContractMine.listFromJson(json['data']));
  }
}

class ContractMine {
  String id;
  RealStateModel property;
  String renter;
  String owner;
  String from;
  String to;
  String paymentDuration;
  double monthlyPrice;
  String paymentType;
  String note;
  String renter_signature;
  String owner_signature;
  String contract;
  String status;
  List<dynamic> payments;
  String createdAt;
  String updatedAt;
  int v;
  bool isOwner;

  ContractMine({
    required this.id,
    required this.property,
    required this.renter,
    required this.owner,
    required this.from,
    required this.to,
    required this.paymentDuration,
    required this.monthlyPrice,
    required this.paymentType,
    required this.note,
    required this.contract,
    required this.renter_signature,
    required this.owner_signature,
    required this.status,
    required this.payments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isOwner,
  });

  factory ContractMine.fromJson(Map<String, dynamic> json) {
    return ContractMine(
      id: json['_id'] ?? "",
      property: RealStateModel.fromJson(json['property']),
      renter: json['renter']??"",
      owner: json['owner']??"",
      from: json['from']??"",
      to: json['to']??"",
      paymentDuration: json['payment_duration'] ??"",
      monthlyPrice: json['monthly_price'].toDouble() ??0,
      paymentType: json['payment_type']??"",
      note: json['note']??"",
      contract: json['contract']??"",
      renter_signature: json['renter_signature']??"",
      owner_signature: json['owner_signature']??"",
      status: json['status']??"",
      payments: json['payments']??"",
      createdAt: json['createdAt'] ??"",
      updatedAt: json['updatedAt'] ??"",
      v: json['__v']??"",
      isOwner: json['is_owner']??false,
    );
  }

  static List<ContractMine> listFromJson(List jsonData){
    return jsonData.map((e) => ContractMine.fromJson(e)).toList();
  }
}

