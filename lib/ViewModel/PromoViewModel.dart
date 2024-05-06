




import 'dart:io';

import 'package:aqary/Models/PromoModel.dart';
import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/data/RequestHandler.dart';
import 'package:aqary/helper/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final PromoProvider = StateNotifierProvider<PromoNotifier,List<PromoModel>>((ref) => PromoNotifier(ref));


class PromoNotifier extends StateNotifier<List<PromoModel>>{
  Ref ref;
  PromoNotifier(this.ref):super([]);

  Future<void> getPromo()async{
    RequestHandler requestHandler = RequestHandler();
    PromoResponseModel promoResponseModel;

    promoResponseModel = await requestHandler.getData(
      endPoint: "/promotion-plans",
      auth: true,
      fromJson: (json)=> PromoResponseModel.fromJson(json),
    );

    state = promoResponseModel.data;
  }
}

