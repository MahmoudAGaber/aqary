
import 'package:aqary/data/RequestHandler.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/BanerModel.dart';


final bannerProvider = StateNotifierProvider<BannerNotifier, StateModel<List<BannerModel>>>((ref) => BannerNotifier(ref));



class BannerNotifier extends StateNotifier<StateModel<List<BannerModel>>>{
  Ref ref;
  BannerNotifier(this.ref): super(StateModel.loading());

  Future<void> getBanners()async {
    RequestHandler requestHandler = RequestHandler();
    List<BannerModel> banners;

    try {
      state = StateModel.loading();

      banners = await requestHandler.getData(
        endPoint: '/banners',
        auth: true,
        fromJson: (json) => BannerModel.listFromJson(json),
      );
      if(banners.isEmpty){
        state = StateModel.empty();
      }else{
        state = StateModel.success(banners);

      }
    } catch (e) {
      state = StateModel.fail("Error in data");
    }
  }
}