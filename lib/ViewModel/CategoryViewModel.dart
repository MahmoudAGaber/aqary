
import 'package:aqary/Models/CategoryModel.dart';
import 'package:aqary/data/RequestHandler.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/BanerModel.dart';


final categoryProvider = StateNotifierProvider<CategoryNotifier, StateModel<List<CategoryModel>>>((ref) => CategoryNotifier(ref));



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