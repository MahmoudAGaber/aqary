import 'dart:io';

import 'package:aqary/Models/ManagedEstateModel.dart';
import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/Models/UserModel.dart';
import 'package:aqary/data/RequestHandler.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


enum UserProp {available , notAvailable, all}

final UserProvider = StateNotifierProvider<UserNotifier, StateModel<UserModel>>((ref) => UserNotifier(ref));

final UserPropProvider = StateNotifierProvider<UserPropritiesNotifier, StateModel<List<RealStateModel>>>((ref) => UserPropritiesNotifier(ref));

final ManagedEstatesProvider = StateNotifierProvider<ManagedEstatesNotifier, StateModel<ManagedEstateModel>>((ref) => ManagedEstatesNotifier(ref));

final EstateManagerProvider = StateNotifierProvider<EstateManagerNotifier, List<RealStateModel>>((ref) => EstateManagerNotifier(ref));

final estateSelectionProvider = StateProvider.family<bool, int>((ref, index) => false);

final contractEstateSelectionProvider = StateProvider<int>((ref) => -1);


final updateUserLoadingProvider = StateProvider<bool>((ref) => false);

final userPropSelectionProvider = StateProvider<UserProp>((ref) => UserProp.all);

final deleteEstateLoadingProvider = StateProvider<bool>((ref) => false);



class UserNotifier extends StateNotifier<StateModel<UserModel>> {
  Ref ref;
  UserNotifier(this.ref) : super(StateModel.loading());
  RequestHandler requestHandler = RequestHandler();

  Future<UserModel?> getUserInfo() async {
    UserModel userModel;
    try {
      state = StateModel.loading();
      userModel = await requestHandler.getData(
          endPoint: "/users/profile",
          auth: true,
          fromJson: (json) => UserModel.fromJson(json));

      state = StateModel.success(userModel);

      return state.data!;
    } catch (e) {
      state = StateModel.fail("SHIT");
    }
    return null;
  }

  Future<void> updateUser(Map<String, dynamic> user) async {

    UserModel userModel;
    Map<String ,String> anotherFields = {};

    if(user['name']!=null){
      anotherFields = {
        'name': user['name'],
    };

    }else{
      anotherFields = {
        'notification':user['notification']
      };
    }


     // state = StateModel.loading();
        await requestHandler.patch(
          endPoint: "/users/profile",
          requestBody: anotherFields,
         fromJson: (json) => Map,
          auth: true,
         file: user['pic']??File(""),
      );


     // state = StateModel.success(userModel);




  }

  Future<void> addFavorite(String id,String type)async {
    RequestHandler requestHandler = RequestHandler();
    List<RealStateModel> realEstateTemp = [];
    UserModel? userModel;

    try {
      requestHandler.getData(
        endPoint: '/properties/$id/favorite',
        auth: true,
        fromJson: (json) => Map(),
      );

      realEstateTemp.clear();
      if(type == 'recent'){
        realEstateTemp = state.data!.recentlySeen;

      }else if(type == 'prop'){
        realEstateTemp = state.data!.properties;

      }

      for(var item in realEstateTemp){
        if(item.id == id){
          item.isFavorite = !item.isFavorite;
          print("WELLDONE");
        }


      }
      UserModel? userModel = state.data;
      userModel!.recentlySeen = realEstateTemp;
      state = StateModel.success(userModel);


    } catch (e) {
      print("ErrorToAddToFavorites$e");
    }
  }
}

class ManagedEstatesNotifier extends StateNotifier<StateModel<ManagedEstateModel>> {
  Ref ref;
  ManagedEstatesNotifier(this.ref) : super(StateModel.loading());
  RequestHandler requestHandler = RequestHandler();

  Future<void> getManagedEstate() async {
    ManagedEstateModel managedEstate;
    try {
      state = StateModel.loading();
      managedEstate = await requestHandler.getData(
          endPoint: "/properties/manage",
          auth: true,
          fromJson: (json) => ManagedEstateModel.fromJson(json));

      state = StateModel.success(managedEstate);
    } catch (e) {
      state = StateModel.fail("SHIT");
    }
  }

  void deleteManagedEstate(contractId)async{
    List<Manage> managedList = [];
    List<Renter> renterList = [];
    ManagedEstateModel? managedEstateModel;

    managedList = state.data!.manage;
    renterList = state.data!.renter;

    managedEstateModel = state.data;
    managedList.removeWhere((estate) => estate.contractId == contractId);
    renterList.removeWhere((estate) => estate.contractId == contractId);

    managedEstateModel!.manage = managedList;

    state = StateModel.success(managedEstateModel);

      await requestHandler.deleteData(
        endPoint: "/contracts/$contractId",
        auth: true,);



  }

  dynamic rentAmount(List<Manage> managedEstates){
    dynamic total = 0;
    for(var item in managedEstates){
      total += item.rent;
    }
    return total;
  }

  dynamic deservedAmount(List<Manage> managedEstates){
    dynamic total = 0;
    if(managedEstates.isNotEmpty){
      for(var item in managedEstates){
        total += item.monthly;
      }
    }
    return total;
  }

  dynamic  paidAmount(List<Manage> managedEstates){
    dynamic total = 0;
    for(var item in managedEstates){
      total += item.paid;
    }
    return total;
  }

}

class UserPropritiesNotifier extends StateNotifier<StateModel<List<RealStateModel>>> {
  Ref ref;
  UserPropritiesNotifier(this.ref) : super(StateModel.loading());
  RequestHandler requestHandler = RequestHandler();

  Future<List<RealStateModel>?> getUserProp(UserProp userPropSelection) async {
    UserModel userModel;
    List<RealStateModel> prop = [];
    try {
      state = StateModel.loading();
      userModel = await requestHandler.getData(
          endPoint: "/users/profile",
          auth: true,
          fromJson: (json) => UserModel.fromJson(json));

       prop.clear();
      if(userPropSelection == UserProp.available){
        userModel.properties.forEach((element) { element.isAvailable == true? prop.add(element):[];});
      }
      if(userPropSelection == UserProp.notAvailable){
        userModel.properties.forEach((element) { element.isAvailable == false? prop.add(element):[];});
      }
      if(userPropSelection == UserProp.all){
        userModel.properties.forEach((element) { prop.add(element);});
      }

      state = StateModel.success(prop);
      return state.data;
    } catch (e) {
      state = StateModel.fail("SHIT");
    }
    return null;
  }

  Future<void> getUserPropSelection(UserProp userPropSelection,List<RealStateModel> realEstate) async {
    UserModel userModel;
    List<RealStateModel> prop = [];
    try {

      prop.clear();
      if(userPropSelection == UserProp.available){
        realEstate.forEach((element) { element.isAvailable == true? prop.add(element):[];});
      }
      if(userPropSelection == UserProp.notAvailable){
        realEstate.forEach((element) { element.isAvailable == false? prop.add(element):[];});
      }
      if(userPropSelection == UserProp.all){
        realEstate.forEach((element) { prop.add(element);});
      }

      state = StateModel.success(prop);
    } catch (e) {
      state = StateModel.fail("SHIT");
    }
  }


}

class EstateManagerNotifier extends StateNotifier<List<RealStateModel>> {
  Ref ref;
  EstateManagerNotifier(this.ref) : super([]);
  RequestHandler requestHandler = RequestHandler();


  Future<void> addEstate(RealStateModel realStateModel,bool isSelected) async {
    List<RealStateModel> properties = [];
    properties = state;
    try {
      if (!isSelected) {
        properties.removeWhere((element) => element.id == realStateModel.id);
      } else {
        if (!properties.any((element) => element.id == realStateModel.id)) {
          properties.add(realStateModel);
        }
      }

      state = List.from(properties);
      print("Current state: $state");
    } catch (e) {
      print("Failed to toggle property: $e");
    }
  }

  Future<void> addEstateToManage(ManagerModel managerModel) async {
    try{
      requestHandler.postData(
          endPoint: "/properties/add-manager",
          auth: true,
          requestBody: managerModel.toJson()).then((value) => print(value));
    }catch(e){
      print("Error to Send Contract$e");
    }
  }

}

