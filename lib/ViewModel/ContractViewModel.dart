

import 'dart:io';
import 'dart:typed_data';

import 'package:aqary/Models/ContractModel.dart';
import 'package:aqary/ViewModel/RealStateViewModel.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/RequestHandler.dart';
import '../helper/file_picker.dart';


final signatureProvider = StateNotifierProvider<signatureNotifier, StateModel<Uint8List>>((ref) => signatureNotifier(ref));

final ContractProvider = StateNotifierProvider<ContractNotifier, StateModel<ContractModel>>((ref) => ContractNotifier(ref));

final ContractMineProvider = StateNotifierProvider<ContractMineNotifier, StateModel<List<ContractMine>>>((ref) => ContractMineNotifier(ref));

final EstatePaymentProvider = StateNotifierProvider<EstatePaymentNotifier,PaymentType>((ref) => EstatePaymentNotifier(ref));

final BankPaymentImageProvider = StateNotifierProvider<BankPaymentImageNotifier,List<File>>((ref) => BankPaymentImageNotifier(ref));

final PaymentPayProvider = StateNotifierProvider<PaymentPayNotifier,StateModel<List<ContractMine>>>((ref) => PaymentPayNotifier(ref));

class signatureNotifier extends StateNotifier<StateModel<Uint8List>>{
  Ref ref;
  signatureNotifier(this.ref):super(StateModel.loading());
  

  void getSignature(Uint8List signatureData){

    state = StateModel.loading();

    try{
      state = StateModel.success(signatureData);
    }catch(e){
      state = StateModel.fail("Shit");
    }
  }
}

class ContractNotifier extends StateNotifier<StateModel<ContractModel>>{
  Ref ref;
  ContractNotifier(this.ref):super(StateModel.loading());
  
  RequestHandler requestHandler = RequestHandler();

  void sentContract(ContractModel data,propertyId){

    try{
      requestHandler.postContract(
          endPoint: "/contracts/$propertyId",
          auth: true,
          filePath: data.file.path,
          fieldName: 'contract',
          requestBody: data.toJson());
    }catch(e){
      print("Error to Send Contract$e");
    }

  }
}

class ContractMineNotifier extends StateNotifier<StateModel<List<ContractMine>>>{
  Ref ref;
  ContractMineNotifier(this.ref):super(StateModel.loading());

  RequestHandler requestHandler = RequestHandler();

  Future<ContractMine?> getOneContract(String contractId,) async{
    List<ContractMine> contracts = [];
    List<ContractMine> temp = [];
    try{
      state = StateModel.loading();
     ContractMineResponse contractMineResponse = await requestHandler.getData(
          endPoint: "/contracts/mine",
          auth: true,
          fromJson: (json)=>ContractMineResponse.fromJson(json));

          contracts =contractMineResponse.contractMine;

          for (var element in contracts) {
            if(element.id == contractId){
              temp.add(element);
              break;
            }
          }
          print(temp[0]);
          state = StateModel.success(temp);
          return state.data![0];
    }catch(e){
      state = StateModel.fail("Error to Send Contract$e");
    }
    return null;

  }

  void acceptContract(contractId,String filePath){
    try{
      requestHandler.postContract(
          endPoint: "/contracts/$contractId/accept",
          auth: true,
          filePath: filePath,
          fieldName: 'contract',
          requestBody: {});
    }catch(e){
      print("Error to Send Contract$e");
    }

  }
}

class EstatePaymentNotifier extends StateNotifier<PaymentType> {
  Ref ref;
  EstatePaymentNotifier(this.ref):super(PaymentType.cash);

  void changePaymentType(paymentType){
    state = paymentType;
  }
}

class BankPaymentImageNotifier extends StateNotifier<List<File>>{
  Ref ref;
  BankPaymentImageNotifier(this.ref):super([]);

  Future<void >getBankImage()async{
    List<File> temp = [];
    FilePickerHelper filePickerHelper = FilePickerHelper();
    temp.clear();
    state.clear();
    temp = await filePickerHelper.pickFiles(false);
    state = [...state, ...temp];

    print("LENGHT:/${state.length}");

  }

}

class PaymentPayNotifier extends StateNotifier<StateModel<List<ContractMine>>>{
  Ref ref;
  PaymentPayNotifier(this.ref):super(StateModel.loading());

  RequestHandler requestHandler = RequestHandler();

  void estatePay(contractId,String filePath, Map<String,String> data){
    try{
      requestHandler.postContract(

          endPoint: "/contracts/$contractId/pay",
          auth: true,
          fieldName: 'bank_transfer',
          filePath: filePath,
          requestBody: data);
    }catch(e){
      print("Error to Send Contract$e");
    }

  }
}