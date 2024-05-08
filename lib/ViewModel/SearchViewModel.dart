




import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/ViewModel/LocationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/CategoryModel.dart';
import '../data/RequestHandler.dart';
import '../data/StateModel.dart';

enum FilterType { all, appartment, villa}

enum SortBy {recently, desc, asc}

final SearchProvider = StateNotifierProvider<SearchNotifier, StateModel<List<RealStateModel>>>((ref) => SearchNotifier(ref));

final filterProvider = StateProvider<FilterType>((ref) => FilterType.all);

final SortByProvider = StateProvider<SortBy>((ref) => SortBy.recently);

final bathroomSeProvider = StateProvider<int>((ref) => 1);

final bedRoomSeProvider = StateProvider<int>((ref) => 2);

final favoriteSearchRecentlyProvider = StateProvider.family<bool, int>((ref, id) => false);


final rangeValuesProvider = StateNotifierProvider<RangeValuesNotifier,RangeValues>((ref) => RangeValuesNotifier(ref));

class RangeValuesNotifier extends StateNotifier<RangeValues> {
  Ref ref;
  RangeValuesNotifier(this.ref) : super(RangeValues(100000, 1000000));

  void updateRangeValues(RangeValues newValues) {
    state = newValues;
  }
}


class SearchNotifier extends StateNotifier<StateModel<List<RealStateModel>>>{
  Ref ref;
  SearchNotifier(this.ref): super(StateModel.loading());

  Future<void> getSearch(searchKey)async {
    RequestHandler requestHandler = RequestHandler();
    List<RealStateModel> properties;

    try {
      state = StateModel.loading();

      properties = await requestHandler.getData(
        endPoint: '/properties?search=$searchKey&lat=${ref.watch(userLocationProvider)!.latitude}&long=${ref.watch(userLocationProvider)!.latitude}&page=1&limit=20',
        auth: true,
        fromJson: (json) => RealStateModel.listFromJson(json),
      );

      if(properties.isEmpty){
        state = StateModel.empty();
      }

      state = StateModel.success(properties);

    } catch (e) {
      state = StateModel.fail("Error in data");
    }
  }

  Future<void> searchFilter(String type, double fromPrice, double toPrice,int bedrooms,int bathroom,String sort_type, sort_by) async {
    RequestHandler requestHandler = RequestHandler();
    List<RealStateModel> properties;

    try {
      state = StateModel.loading();
      print("hello");

      Map<String, dynamic> queryParams = {
        'type': type,
        'from_price': fromPrice,
        'to_price': toPrice,
        'bedrooms_count': bedrooms,
        'bathrooms_count': bathroom,
        'sort_type': sort_type,
        'sort_by' : sort_by
      };
      queryParams.removeWhere((key, value) => value == null || value == '');

      String queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
      print(queryString);
      String endPoint = '/properties?$queryString';

      properties = await requestHandler.getData(
        endPoint: endPoint,
        auth: true,
        fromJson: (json) => RealStateModel.listFromJson(json),
      );

      print("Lenghttt${properties.length}");
      if (properties.isEmpty) {
        state = StateModel.empty();
      } else {
        state = StateModel.success(properties);
      }
    } catch (e) {
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

  Future<void> clearSearch()async {
    state = StateModel.loading();
  }
}