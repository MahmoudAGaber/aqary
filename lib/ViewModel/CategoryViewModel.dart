
import 'package:aqary/Models/CategoryModel.dart';
import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/data/RequestHandler.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/BanerModel.dart';
import 'LocationViewModel.dart';


final categoryProvider = StateNotifierProvider<CategoryNotifier, StateModel<List<CategoryModel>>>((ref) => CategoryNotifier(ref));

final nearByProvider = StateNotifierProvider<nearByNotifier, StateModel<List<RealStateModel>>>((ref) => nearByNotifier(ref));

final categorySelected = StateProvider<int>((ref) => 0);


class CategoryNotifier extends StateNotifier<StateModel<List<CategoryModel>>>{
  Ref ref;
  CategoryNotifier(this.ref): super(StateModel.loading());

  Future<void> getCategories()async {
    RequestHandler requestHandler = RequestHandler();
    List<CategoryModel> categories;

    try {
      state = StateModel.loading();

      categories = await requestHandler.getData(
        endPoint: '/tags',
        auth: true,
        fromJson: (json) => CategoryModel.listFromJson(json),
      );
      state = StateModel.success(categories);
    } catch (e) {
      state = StateModel.fail("Error in data");
    }
  }

  Future<void> addFavorite(String id,int index)async {
    RequestHandler requestHandler = RequestHandler();
    Map<String, dynamic> message;
    List<CategoryModel> categoryTemp = [];

    try {
      message = await requestHandler.getData(
        endPoint: '/properties/$id/favorite',
        auth: true,
        fromJson: (json) => Map(),
      );

      if(message['messages'] == "Updated!"){
        print(message['message']);
      }
      categoryTemp.clear();
      categoryTemp = state.data!;

      for(var item in categoryTemp){
        for(var pro in item.properties){
          if(pro.id == id){
            pro.isFavorite = !pro.isFavorite;
            print("WELLDONE");
          }
        }

      }
      state = StateModel.success(categoryTemp);


    } catch (e) {
      print("ErrorToAddToFavorites$e");
    }
  }
}


class nearByNotifier extends StateNotifier<StateModel<List<RealStateModel>>>{
  Ref ref;
  nearByNotifier(this.ref): super(StateModel.loading());

  Future<void> nearByEstate() async {
    RequestHandler requestHandler = RequestHandler();
    List<RealStateModel> properties;
    double? lat =  ref.watch(userLocationProvider)!.latitude;
    double? long =  (ref.watch(userLocationProvider)!.longtude);

    if (!mounted) return;
    try {
      state = StateModel.loading();
      Map<String, dynamic> queryParams = {
        'sort_by' : "distance",
        'sort_type':'asc',
        'lat': lat,
        'long': long,
        'page':1,
        'limit':20
      };
      queryParams.removeWhere((key, value) => value == null || value == '');
      print("SHITTT");
      String queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
      print("SHITTT1111");
      String endPoint = '/properties?$queryString';
      print("SHITTT2222");
      properties = await requestHandler.getData(
        endPoint: endPoint,
        auth: true,
        fromJson: (json) => RealStateModel.listFromJson(json),
      );
      print("SHITTT333");
      if (properties.isEmpty) {
        state = StateModel.empty();
      } else {
        if (!mounted) return;
        state = StateModel.success(properties);
      }
    } catch (e) {
      if (!mounted) return;
      state = StateModel.fail("Error in data");
    }

  }

  Future<void> addFavorite(String id)async {
    RequestHandler requestHandler = RequestHandler();
    List<RealStateModel> realEstateTemp = [];

    try {
       requestHandler.getData(
        endPoint: '/properties/$id/favorite',
        auth: true,
        fromJson: (json) => Map(),
      );

      realEstateTemp.clear();
       realEstateTemp = state.data!;

      for(var item in realEstateTemp){
          if(item.id == id){
            item.isFavorite = !item.isFavorite;
            print("WELLDONE");
          }


      }
      state = StateModel.success(realEstateTemp);


    } catch (e) {
      print("ErrorToAddToFavorites$e");
    }
  }

}
