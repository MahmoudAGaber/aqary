



import 'package:aqary/Models/RealStateModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/CategoryModel.dart';
import '../data/RequestHandler.dart';
import '../data/StateModel.dart';

enum isFavoriteEnum {favorite ,notFavorite}

enum FavoritesFilter {recently ,desc, asc}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, StateModel<List<RealStateModel>>>((ref) => FavoritesNotifier(ref));
final favoritesSorted = StateProvider<String>((ref) => "recently");
final favoriteProvider = StateProvider.family<bool, int>((ref, id) => false);
final favorite2Provider = StateProvider.family<bool, int>((ref, id) => false);

final favoritesFilterProvider = StateProvider<FavoritesFilter>((ref) => FavoritesFilter.recently);



class FavoritesNotifier extends StateNotifier<StateModel<List<RealStateModel>>>{
  Ref ref;
  FavoritesNotifier(this.ref): super(StateModel.loading());


  Future<void> addFavorite(String id)async {
    RequestHandler requestHandler = RequestHandler();
    Map<String, dynamic> message;

    try {
      message = await requestHandler.getData(
        endPoint: '/properties/$id/favorite',
        auth: true,
        fromJson: (json) => Map(),
      );

      if(message['messages'] == "Updated!"){
        print(message['message']);
      }

    } catch (e) {
      print("ErrorToAddToFavorites$e");
    }
  }

  Future<List<RealStateModel>> getFavorites(sortType, sortby)async {
    RequestHandler requestHandler = RequestHandler();
    List<RealStateModel> properties = [];

    try {
      state = StateModel.loading();

      Map<String, dynamic> queryParams = {
        'sort_by' : sortby,
        'sort_type': sortType,
        'favorites': 'true',

      };
      queryParams.removeWhere((key, value) => value == null || value == '');

      String queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
      String endPoint = '/properties?$queryString';

      properties = await requestHandler.getData(
        endPoint: endPoint,
        auth: true,
        fromJson: (json) => RealStateModel.listFromJson(json),
      );

      if(properties.isEmpty){
        state = StateModel.empty();
      }else{
        state = StateModel.success(properties);

      }

      return state.data!;
    } catch (e) {
      state = StateModel.fail("Error in data");
    }
    return properties;
  }
}