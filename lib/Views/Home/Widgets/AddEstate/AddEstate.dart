

import 'dart:async';

import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/Views/base/custom_button.dart';
import 'package:aqary/Views/base/custom_text_field.dart';
import 'package:aqary/helper/file_picker.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

import '../../MapView.dart';
import 'DistenctionEstate.dart';


class AddEstate extends StatefulWidget {
  const AddEstate({super.key});

  @override
  State<AddEstate> createState() => _AddEstateState();
}

enum SingingCharacter { lafayette, jefferson }
enum PaymentsSystem { monthly, annually, Semi_annually, Quarterly }

class _AddEstateState extends State<AddEstate> {


  SingingCharacter? _character = SingingCharacter.lafayette;
  PaymentsSystem? _payments = PaymentsSystem.annually;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.1937, 55.2666),
    zoom: 14.3,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "إضافه عقار",
        isCenter: true,
        isBackButtonExist: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
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
                  //  controller: searchController,
                    textDirection: TextDirection.rtl,
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.black),
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
                    onTap: (){

                    },
                    onChanged: (value){

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
                    //  controller: searchController,
                    textDirection: TextDirection.rtl,
                    cursorColor: Colors.grey,
                    style: TextStyle(color: Colors.black),
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
                    onTap: (){

                    },
                    onChanged: (value){

                    },
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeDefault,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MapView()));
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> MapView()));
                            },
                            initialCameraPosition: _kGooglePlex ,
                            liteModeEnabled: true,
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
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.lafayette,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title:  Text('فيلا',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xff677294))),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.jefferson,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
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
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.add,color: Colors.white,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text('2',
                                  style: Theme.of(context).textTheme.bodyLarge,),
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                                child: Container(
                                  width: 14,
                                  height: 2,
                                  color: Colors.white,
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
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.add,color: Colors.white,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text('1',
                                  style: Theme.of(context).textTheme.bodyLarge,),
                              ),
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.grey,
                                child: Container(
                                  width: 14,
                                  height: 2,
                                  color: Colors.white,
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
                    //  controller: searchController,
                    textDirection: TextDirection.rtl,
                    cursorColor: Colors.grey,
                    maxLines: 5,
                    style: TextStyle(color: Colors.black),
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
                    onTap: (){

                    },
                    onChanged: (value){

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
                  InkWell(
                    onTap: (){
                      FilePickerHelper.pickFiles();
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
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset("assets/images/ph_camera-thin.svg",width: 32,height: 28,),
                    )),
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
                    //  controller: searchController,
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
                    onTap: (){

                    },
                    onChanged: (value){

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
                    children: List.generate(paymentsSystemTxt.length, (index) => paymentWidget(index))
                  ),

                  SizedBox(height: Dimensions.paddingSizeDefault,),
                  CustomButton(
                      buttonText: "إضافه",
                      textColor: Colors.white,
                      height: 50,
                      borderRadius: 12,
                      onPressed: (){
                        Distinction().distinctionEstate(context);
                      }
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault,),

                ],
              ),
            ])
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

  Widget paymentWidget(index){
    return  SizedBox(
      width: MediaQuery.of(context).size.width*.45,
      child: ListTile(
        title:  Text(paymentsSystemTxt[index],style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xff677294))),
        leading: Radio<PaymentsSystem>(
          value: PaymentsSystem.values[index],
          groupValue: _payments,
          onChanged: (PaymentsSystem? value) {
            setState(() {
              _payments = value;
            });
          },
        ),
      ),
    );
  }
}
