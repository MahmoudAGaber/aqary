

import 'dart:async';
import 'dart:io';

import 'package:aqary/ViewModel/LocationViewModel.dart';
import 'package:aqary/ViewModel/RealStateViewModel.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/Views/base/custom_button.dart';
import 'package:aqary/Views/base/custom_text_field.dart';
import 'package:aqary/helper/file_picker.dart';
import 'package:aqary/helper/payment_helper.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import '../../../../Models/RealStateModel.dart';
import '../../../../ViewModel/PromoViewModel.dart';
import '../../../VideoPlayer.dart';
import '../../MapView.dart';
import 'DistenctionEstate.dart';


class AddEstate extends ConsumerStatefulWidget {
  const AddEstate({super.key});

  @override
  ConsumerState<AddEstate> createState() => _AddEstateState();
}



class _AddEstateState extends ConsumerState<AddEstate> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController estateNameController = TextEditingController();
  TextEditingController estateAddressController = TextEditingController();
  TextEditingController estateDescriptionController = TextEditingController();
  TextEditingController estatePriceController = TextEditingController();


  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.1937, 55.2666),
    zoom: 14.3,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var estateType = ref.watch(estateTypeProvider);
    var bedroomNumbers = ref.watch(bedRoomNumbersProvider);
    var bathroomNumbers = ref.watch(bathroomNumbersProvider);
    var paymentSystem = ref.watch(paymentsSystemProvider);
    var estateFiles  = ref.watch(RealStateFilesProvider);
    var estateLocation = ref.watch(estatelocationProvider);
    if(estateLocation!.placemark != null){
      var estateAddress = "${estateLocation.placemark!.country}, ${estateLocation.placemark!.locality}, ${estateLocation.placemark!.administrativeArea}, ${estateLocation.placemark!.street}";
      estateAddressController.text = estateAddress;

    }


    return Scaffold(
      appBar: CustomAppBar(
        title: "إضافه عقار",
        isCenter: true,
        isBackButtonExist: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("مرحبًا،",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 19),),
                  Text("املأ التفاصيل الخاصة بعقارك",style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 19),),
                  SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("اسم العقار",style: Theme.of(context).textTheme.titleLarge!),
                      ),
                      SizedBox(height: Dimensions.paddingSizeSmall,),
                      TextFormField(
                        controller: estateNameController,
                        textDirection: TextDirection.rtl,
                        cursorColor: Colors.grey,
                        style: TextStyle(color: Colors.black,fontSize: 15),
                        decoration: InputDecoration(
                            fillColor: Color(0xFFF9FAFA),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            hintText: "اسم عقارك",
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFFF9FAFA),
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor
                                )
                            )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'قم بادخال اسم العقار';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("عنوان العقار",style: Theme.of(context).textTheme.titleLarge!),
                      ),
                      SizedBox(height: Dimensions.paddingSizeSmall,),
                      TextFormField(
                          controller: estateAddressController,
                        textDirection: TextDirection.rtl,
                        cursorColor: Colors.grey,
                        style: TextStyle(color: Colors.black,fontSize: 15),
                        decoration: InputDecoration(
                            fillColor: Color(0xFFF9FAFA),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            hintText: "عنوان عقارك",
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFFF9FAFA),
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor
                                )
                            )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'قم بادخال عنوان العقار';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MapView(lat: LatLng(estateLocation.latitude!,estateLocation.longtude!),title: 'حدد موقع العقار',isSelected: true, isUserLocation: false,)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: GoogleMap(
                                onTap: (v){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MapView(lat:LatLng(estateLocation.latitude!,estateLocation.longtude!),title: 'حدد موقع العقار',isSelected: true,isUserLocation: false,)));
                                },
                                initialCameraPosition: _kGooglePlex ,
                                mapType: MapType.terrain,
                                indoorViewEnabled: false,
                                mapToolbarEnabled: false,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xffF9FAFA)
                                  //borderRadius: BorderRadius.circular(12)
                                ),
                                child: Center(child: Text("حدد موقع عقارك علي الخريطه",style: Theme.of(context).textTheme.bodySmall!.copyWith(color:  Color(0xff677294)))),
                              ),
                            )
                          ],
                        ))
                  ),
                  SizedBox(height: Dimensions.paddingSizeLarge,),
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("نوع العقار",style: Theme.of(context).textTheme.titleLarge!),
                      ),
                      SizedBox(height: Dimensions.paddingSizeSmall,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*.9,
                        child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title:  Text('شقه',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xff677294))),
                      leading: Radio<EstateType>(
                        value: EstateType.department,
                        groupValue: estateType,
                        onChanged: (EstateType? value) {
                          if (value != null) {
                            ref.read(estateTypeProvider.notifier).state = value;
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title:  Text('فيلا',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xff677294))),
                      leading: Radio<EstateType>(
                        value: EstateType.villa,
                        groupValue: estateType,
                        onChanged: (EstateType? value) {
                          if (value != null) {
                            ref.read(estateTypeProvider.notifier).state = value;
                          }
          
                        },
                      ),
                    ),
                  ),
                ],
              ),
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeLarge,),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffF9FAFA)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('غرفه نوم',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16,color:  Color(0xff677294)),),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      ref.read(bedRoomNumbersProvider.notifier).state ++;
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.add,color: Colors.white,),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(bedroomNumbers.toString(),
                                      style: Theme.of(context).textTheme.bodyLarge,),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(bedroomNumbers > 1){
                                        ref.read(bedRoomNumbersProvider.notifier).state --;
          
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.grey,
                                      child: Container(
                                        width: 14,
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.paddingSizeDefault,),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffF9FAFA)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('حمام',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16,color:  Color(0xff677294)),),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      ref.read(bathroomNumbersProvider.notifier).state ++;
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.add,color: Colors.white,),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(bathroomNumbers.toString(),
                                      style: Theme.of(context).textTheme.bodyLarge,),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(bathroomNumbers > 1){
                                        ref.read(bathroomNumbersProvider.notifier).state --;
          
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.grey,
                                      child: Container(
                                        width: 14,
                                        height: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeLarge,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("مواصفات العقار",style: Theme.of(context).textTheme.titleLarge!),
                      ),
                      SizedBox(height: Dimensions.paddingSizeSmall,),
                      TextFormField(
                          controller: estateDescriptionController,
                        textDirection: TextDirection.rtl,
                        cursorColor: Colors.grey,
                        maxLines: 5,
                        style: TextStyle(color: Colors.black,fontSize: 15),
                        decoration: InputDecoration(
                            fillColor: Color(0xFFF9FAFA),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 6 ),
                            hintText: "مواصفات عقارك",
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFFF9FAFA),
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor
                                )
                            )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'قم بادخال مواصفات العقار';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeLarge,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("إضافه مرفقات للعقار",style: Theme.of(context).textTheme.titleLarge!),
                      ),
                      SizedBox(height: Dimensions.paddingSizeSmall,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // number of items in each row
                              mainAxisSpacing: 7.0, // spacing between rows
                              crossAxisSpacing: 14.0, // spacing between columns
                              mainAxisExtent: 180,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: estateFiles.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return InkWell(
                                  onTap: () {
                                    ref.read(RealStateFilesProvider.notifier).getEstateFiles();
                                  },
                                  child: Container(
                                    width: 135,
                                    height: 100,
                                    padding: const EdgeInsets.all(15),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFF9FAFA),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(42.0),
                                      child: SvgPicture.asset("assets/images/ph_camera-thin.svg", width: 32, height: 28,),
                                    ),
                                  ),
                                );
                              } else {
                                final estateIndex = index - 1;
                                return SizedBox(
                                  height: 180,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SizedBox(
                                          height: 172,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: estateFiles[estateIndex].path.contains("mp4")
                                                ? VideoApp(path: estateFiles[estateIndex].path,)
                                                :Image.file(File(estateFiles[estateIndex].path),fit: BoxFit.cover,width: 200,height: 180,),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: InkWell(
                                              onTap: (){
                                                ref.read(RealStateFilesProvider.notifier).removeEstate(estateIndex);
                                              },
                                                child: Icon(Icons.close, size: 16, color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeLarge,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("السعر السنوي",style: Theme.of(context).textTheme.titleLarge!),
                      ),
                      SizedBox(height: Dimensions.paddingSizeSmall,),
                      TextFormField(
                         controller: estatePriceController,
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.rtl,
                        cursorColor: Colors.grey,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            fillColor: Color(0xFFF9FAFA),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            hintText: "ادخل السعر السنوي للعقار الخاص بك",
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color(0xFFF9FAFA),
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor
                                )
                            )
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'قم بادخال السعر السنوي للعقار';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.paddingSizeSmall,),
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("نظام الدفعات",style: Theme.of(context).textTheme.titleLarge!),
                      ),
                      SizedBox(height: Dimensions.paddingSizeSmall,),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        alignment: WrapAlignment.center,
                        children: List.generate(paymentsSystemTxt.length, (index) => paymentWidget(index,paymentSystem))
                      ),
          
                      SizedBox(height: Dimensions.paddingSizeDefault,),
                      CustomButton(
                          buttonText: "إضافه",
                          textColor: Colors.white,
                          height: 50,
                          borderRadius: 12,
                          onPressed: (){
                            //print({"Hello${estateFiles[0]}"});
                            if(_formKey.currentState!.validate()){
                              if(estateFiles.isNotEmpty){
                                if(estateLocation.latitude !=null || estateLocation.longtude != null || estateLocation.placemark !=null){
                                  var realStateModel = RealStateModel(
                                      title: estateNameController.text,
                                      images: estateFiles.cast<File>(),
                                      bathroomsCount: bathroomNumbers,
                                      bedroomsCount: bedroomNumbers,
                                      country: estateLocation.placemark!.country!,
                                      city:  estateLocation.placemark!.locality!,
                                      yearPrice: estatePriceController.text,
                                      type: estateType.name,
                                      location: estateAddressController.text,
                                      long: estateLocation.longtude!,
                                      lat: estateLocation.latitude!,
                                      description: estateDescriptionController.text,
                                      paymentDuration:PaymentHelper.getArabicPaymentStyle(paymentSystem),
                                      videos: [],
                                      isAvailable: true,
                                      isFavorite: false
                                  );
                                  Distinction().distinctionEstate(context,realStateModel,);
                                }
          
                              }
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("قم بادخال مرفقات العقار",style: TextStyle(color: Colors.black),) ));
          
                            }
          
          
                          }
                      ),
                      SizedBox(height: Dimensions.paddingSizeDefault,),
          
                    ],
                  ),
                ]),
            )
          ),
        ),
      )
    );
  }

  List<String> paymentsSystemTxt = [
    "سنوي",
    "نصف سنوي",
    "شهري",
    "ربع سنوي",
  ];

  Widget paymentWidget(index,paymentSystem){
    return  Consumer(
      builder: (context,consumerRef,child){
        return SizedBox(
          width: MediaQuery.of(context).size.width*.45,
          child: ListTile(
            title:  Text(paymentsSystemTxt[index],style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xff677294))),
            leading: Radio<PaymentsSystem>(
              value: PaymentsSystem.values[index],
              groupValue: paymentSystem,
              onChanged: (PaymentsSystem? value) {
                if(value != null){
                  consumerRef.read(paymentsSystemProvider.notifier).state = value;
                }

              },
            ),
          ),
        );
      },
    );
  }
  List<String> searchImage =[
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",


  ];
}
