


import 'dart:convert';
import 'dart:io';

import 'package:aqary/Models/CountryCitiesModel.dart';
import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/data/RequestHandler.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:aqary/helper/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'LocationViewModel.dart';

enum EstateType { department, villa }
enum PaymentType { cash, bank }
enum PaymentsSystem { annually , Semi_annually, monthly, Quarterly}
enum EstateIsAvalible { Avalible, notAvalible }

final bathroomNumbersProvider = StateProvider<int>((ref) => 1);

final bedRoomNumbersProvider = StateProvider<int>((ref) => 2);

final estateTypeProvider = StateProvider<EstateType>((ref) => EstateType.department);

final paymentTypeProvider = StateProvider<PaymentType>((ref) => PaymentType.cash);

final paymentsSystemProvider = StateProvider<PaymentsSystem>((ref) => PaymentsSystem.annually);

final StateIsAvalibleProvider = StateProvider<EstateIsAvalible>((ref) => EstateIsAvalible.Avalible);

final loadingMoreProvider = StateProvider<bool>((ref) => false);




final RealStateProvider = StateNotifierProvider<RealStateNotifier,List<RealStateModel>>((ref) => RealStateNotifier(ref));

final RealStateGetOneProvider = StateNotifierProvider<RealStateGetOneNotifier,StateModel<RealStateResponse>>((ref) => RealStateGetOneNotifier(ref));

final RealStateFilesProvider = StateNotifierProvider<RealStateFilesNotifier,List<File>>((ref) => RealStateFilesNotifier(ref));

final RealStateEditProvider = StateNotifierProvider<RealStateEditNotifier,List<dynamic>>((ref) => RealStateEditNotifier(ref));

final CountryCityProvider = StateNotifierProvider<CountryCityNotifier,StateModel<List<Countries>>>((ref) => CountryCityNotifier(ref));



class RealStateNotifier extends StateNotifier<List<RealStateModel>>{
  Ref ref;
  RealStateNotifier(this.ref):super([]);

  void addRealState( RealStateModel? data){
    Map<String, String> dataToJSon= {
      'title':data!.title,
      'bedrooms_count': data.bedroomsCount.toString(),
      'bathrooms_count':data.bathroomsCount.toString(),
      'price': data.yearPrice,
      'country':data.country,
      'city': data.city,
      'type':data.type,
      'location': data.location,
      'long':data.long.toString(),
      'lat': data.lat.toString(),
      'description':data.description,
      'payment_duration': data.paymentDuration.toString(),
      'promotion':data.promotion.toString(),
      'is_available': data.isAvailable.toString(),

    };
    RequestHandler requestHandler = RequestHandler();
    requestHandler.postAnotherData(
      endPoint: "/properties",
        auth: true,
        requestBody: dataToJSon,
        model: data
    );
  }

  Future<void> getRealStates({
    int? page,
    int? limit,
    String? type,
    double? fromPrice,
    double? toPrice,
    String? sort_type,
    String? city,
    String? search,
    int? bedrooms,
    int? bathroom
  }) async {
    RequestHandler requestHandler = RequestHandler();

    List<RealStateModel> properties = [];
    List<RealStateModel> propertiesTemp= [];
    List<RealStateModel> oldProperties= [];
    double? lat =  ref.watch(userLocationProvider)!.latitude;
    double? long =  (ref.watch(userLocationProvider)!.longtude)!;


      Map<String, dynamic> queryParams = {
        'type': type,
        'city':city,
        'search':search,
        'from_price': fromPrice,
        'to_price': toPrice,
        'bedrooms_count': bedrooms,
        'bathrooms_count': bathroom,
        'sort_by' : "distance",
        'sort_type':sort_type ?? 'asc',
        'lat': lat,
        'long': long,
        'page':"$page",
        'limit':"$limit",
      };
      queryParams.removeWhere((key, value) => value == null || value == '');
      String queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
      String endPoint = '/properties?$queryString';

      propertiesTemp.clear();


      if(page!<=1){
        properties = await requestHandler.getData(
          endPoint: endPoint,
          auth: true,
          fromJson: (json) => RealStateModel.listFromJson(json),
        );
      }else if(page > 1){
        propertiesTemp = await requestHandler.getData(
          endPoint: endPoint,
          auth: true,
          fromJson: (json) => RealStateModel.listFromJson(json),
        );

        properties = [...state, ...propertiesTemp];
      }

        state = [...properties];



  }
}

class RealStateGetOneNotifier extends StateNotifier<StateModel<RealStateResponse>>{
  Ref ref;
  RealStateGetOneNotifier(this.ref):super(StateModel.loading());

  Future<void> getOneEstate(String id) async{
    RequestHandler requestHandler = RequestHandler();
    RealStateResponse realStateResponse;
    try {
      state = StateModel.loading();
      realStateResponse = await requestHandler.getData(
        endPoint: "/properties/$id?lat=${ref.watch(userLocationProvider)!.latitude}&long=${ref.watch(userLocationProvider)!.latitude}",
        auth: true,
        fromJson: (json) => RealStateResponse.fromJson(json),);

     state = StateModel.success(realStateResponse);
     print("HELOOOO$state");

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }
}

class RealStateFilesNotifier extends StateNotifier<List<File>>{
  Ref ref;
  RealStateFilesNotifier(this.ref):super([]);

  Future<void >getEstateFiles()async{
    List<File> temp = [];
    FilePickerHelper filePickerHelper = FilePickerHelper();
    temp.clear();
    temp = await filePickerHelper.pickFiles(false);
    state = [...state, ...temp];

    print("LENGHT:/${state.length}");

  }


  void removeEstate(int index) {
    if (index >= 0 && index < state.length) {
      state = List.from(state)..removeAt(index);
    }
  }
}

class RealStateEditNotifier extends StateNotifier<List<dynamic>>{
  Ref ref;
  RealStateEditNotifier(this.ref):super([]);

  Future<void > addEstateFiles()async{
    List<File> temp = [];
    FilePickerHelper filePickerHelper = FilePickerHelper();
    temp.clear();
    temp = await filePickerHelper.pickFiles(false);
    state = [...state, ...temp];

    print("LENGHT:/${state.length}");

  }


    Future<void >getEstateFiles(List<dynamic> files)async{
    List<dynamic> temp = [];
    temp.clear();
    temp = files;

    state = [...state, ...temp];

    print("LENGHT:/${state.length}");

  }


  void removeEstate(int index) {
    if (index >= 0 && index < state.length) {
      state = List.from(state)..removeAt(index);
    }
  }
}

class CountryCityNotifier extends StateNotifier<StateModel<List<Countries>>>{
  Ref ref;
  CountryCityNotifier(this.ref):super(StateModel.loading());

  Future<void> getCountries(String searchKey) async{
    RequestHandler requestHandler = RequestHandler();
    Map<String, List<String>> data;
    List<Countries> countries = [];
    try {
      state = StateModel.loading();

      countries.clear();

      data = await requestHandler.getData(
        endPoint: "/countries?search=$searchKey",
        auth: true,
        fromJson: (json) {
          Map<String, dynamic> temp = Map<String, dynamic>.from(json);
          return temp.map((key, value) => MapEntry(key, List<String>.from(value)));
        },);

      data.forEach((country, cities) {
        if(country != 'undefined'){
          countries.add(Countries(countryName: country, citiesAndAreas: cities));
        }
      });

      if(countries.isNotEmpty){
        state = StateModel.success(countries);

      }else{
        state = StateModel.loading();
      }

      countries.forEach((element) {print(element.countryName);});

    }catch(e){
      state = StateModel.fail("Faild to get data $e");
    }
  }
}


