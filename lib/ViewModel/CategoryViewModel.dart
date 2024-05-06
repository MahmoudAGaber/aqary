
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
}


class nearByNotifier extends StateNotifier<StateModel<List<RealStateModel>>>{
  Ref ref;
  nearByNotifier(this.ref): super(StateModel.loading());

  Future<void> nearByEstate() async {
    RequestHandler requestHandler = RequestHandler();
    List<RealStateModel> properties;
    double? lat =  ref.watch(userLocationProvider)!.latitude;
    double? long =  (ref.watch(userLocationProvider)!.longtude)!+1;

    if (!mounted) return;
    try {
      state = StateModel.loading();
      Map<String, dynamic> queryParams = {
        'sort_by' : "distance",
        'sort_type':'asc',
        'lat': lat,
        'long': long
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

}
