import 'package:aqary/Models/ManagedEstateModel.dart';
import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/Models/UserModel.dart';
import 'package:aqary/data/RequestHandler.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


enum UserProp {available , notAvailable, all}

final UserProvider = StateNotifierProvider<UserNotifier, StateModel<UserModel>>((ref) => UserNotifier(ref));

final UserPropProvider = StateNotifierProvider<UserPropritiesNotifier, StateModel<List<RealStateModel>>>((ref) => UserPropritiesNotifier(ref));

final ManagedEstatesProvider = StateNotifierProvider<ManagedEstatesNotifier, StateModel<List<ManagedEstateModel>>>((ref) => ManagedEstatesNotifier(ref));

final EstateManagerProvider = StateNotifierProvider<EstateManagerNotifier, List<RealStateModel>>((ref) => EstateManagerNotifier(ref));

final estateSelectionProvider = StateProvider.family<bool, int>((ref, index) => false);

final updateUserLoadingProvider = StateProvider<bool>((ref) => false);

final userPropSelectionProvider = StateProvider<UserProp>((ref) => UserProp.all);



class UserNotifier extends StateNotifier<StateModel<UserModel>> {
  Ref ref;
  UserNotifier(this.ref) : super(StateModel.loading());
  RequestHandler requestHandler = RequestHandler();

  Future<void> getUserInfo() async {
    UserModel userModel;
    try {
      state = StateModel.loading();
      userModel = await requestHandler.getData(
          endPoint: "/users/profile",
          auth: true,
          fromJson: (json) => UserModel.fromJson(json));

      state = StateModel.success(userModel);
    } catch (e) {
      state = StateModel.fail("SHIT");
    }
  }

  Future<void> updateUser(Map<String, dynamic> user) async {

    UserModel userModel;
      Map<String ,String> anotherFields = {
      'name': user['name'],
    };
    try {
      state = StateModel.loading();
       userModel = await requestHandler.patch(
          endPoint: "/users/profile",
          requestBody: anotherFields,
         fromJson: (json) => UserModel.fromJson(json),
          auth: true,
         file: user['pic'],
      );
      print(userModel);

      state = StateModel.success(userModel);
       print(userModel);

    }catch(e){
      state = StateModel.fail('SHIT');
    }

  }
}

class ManagedEstatesNotifier extends StateNotifier<StateModel<List<ManagedEstateModel>>> {
  Ref ref;
  ManagedEstatesNotifier(this.ref) : super(StateModel.loading());
  RequestHandler requestHandler = RequestHandler();

  Future<void> getManagedEstate() async {
    List<ManagedEstateModel> managedEstate = [];
    try {
      state = StateModel.loading();
      managedEstate = await requestHandler.getData(
          endPoint: "/properties/manage",
          auth: true,
          fromJson: (json) => ManagedEstateModel.listFromJson(json));

      state = StateModel.success(managedEstate);
    } catch (e) {
      state = StateModel.fail("SHIT");
    }
  }

  int rentAmount(List<ManagedEstateModel> managedEstates){
    int total = 0;
    for(var item in managedEstates){
      total += item.rent;
    }
    return total;
  }

  int deservedAmount(List<ManagedEstateModel> managedEstates){
    int total = 0;
    for(var item in managedEstates){
      total += item.monthly;
    }
    return total;
  }

  int paidAmount(List<ManagedEstateModel> managedEstates){
    int total = 0;
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

  Future<void> getUserProp(UserProp userPropSelection) async {
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

