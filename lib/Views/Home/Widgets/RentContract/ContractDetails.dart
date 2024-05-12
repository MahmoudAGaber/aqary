

import 'dart:collection';

import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/ViewModel/ContractViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../ViewModel/RealStateViewModel.dart';
import '../../../../utill/dimensions.dart';
import '../../../HomePage.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_dialog.dart';
import '../AddEstate/AddEstate.dart';

class ContractDetails extends ConsumerStatefulWidget {
  RealStateModel realStateModel;
  String ownerName;
  String ownerPhone;
  ContractDetails({super.key,required this.ownerName,required this.ownerPhone,required this.realStateModel});

  @override
  ConsumerState<ContractDetails> createState() => _ContractDetailsState();
}

class _ContractDetailsState extends ConsumerState<ContractDetails> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController ownerEditingController = TextEditingController();
  TextEditingController renterEditingController = TextEditingController();
  TextEditingController ownerPhoneEditingController = TextEditingController();
  TextEditingController renterPhoneEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  TextEditingController monthlyPriceEditingController = TextEditingController();



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ownerEditingController.text = widget.ownerName;
      ownerPhoneEditingController.text = widget.ownerPhone;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var paymentSystem = ref.watch(paymentsSystemProvider);

    return  Scaffold(
      appBar: CustomAppBar(
        title: "تفاصيل إنشاء العقد",
        isCenter: true,
        isBackButtonExist: true,
      ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child:Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text("المأجر",style: Theme.of(context).textTheme.titleLarge!),
                            ),
                            SizedBox(height: Dimensions.paddingSizeSmall,),
                            TextFormField(
                              enabled: false,
                                controller: ownerEditingController,
                              textDirection: TextDirection.rtl,
                              cursorColor: Colors.grey,
                              style: TextStyle(color: Colors.black,fontSize: 15),
                              decoration: InputDecoration(
                                  fillColor: Color(0xFFF9FAFA),
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                  hintText: "اسم مأجر العقار",
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
                              child: Text("رقم هاتف المأجر",style: Theme.of(context).textTheme.titleLarge!),
                            ),
                            SizedBox(height: Dimensions.paddingSizeSmall,),
                            TextFormField(
                              enabled: false,
                              controller: ownerPhoneEditingController,
                              textDirection: TextDirection.rtl,
                              cursorColor: Colors.grey,
                              style: TextStyle(color: Colors.black,fontSize: 15),
                              decoration: InputDecoration(
                                  fillColor: Color(0xFFF9FAFA),
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                  hintText: "رقم هاتف المؤجر",
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
                              child: Text("المستأجر",style: Theme.of(context).textTheme.titleLarge!),
                            ),
                            SizedBox(height: Dimensions.paddingSizeSmall,),
                            TextFormField(
                              controller: renterEditingController,
                              textDirection: TextDirection.rtl,
                              cursorColor: Colors.grey,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Color(0xFFF9FAFA),
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                  hintText: "اسم المستأجر للعقار",
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
                                  return 'قم بادخال اسم المستأجر';
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
                              child: Text("رقم هاتف المستأجر",style: Theme.of(context).textTheme.titleLarge!),
                            ),
                            SizedBox(height: Dimensions.paddingSizeSmall,),
                            TextFormField(
                              controller: renterPhoneEditingController,
                              textDirection: TextDirection.rtl,
                              cursorColor: Colors.grey,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Color(0xFFF9FAFA),
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                                  hintText: "رقم هاتف المستأجر",
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
                                  return 'قم بادخال رقم هاتف المستأجر';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        // SizedBox(height: Dimensions.paddingSizeLarge,),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(horizontal: 6),
                        //       child: Text("نظام الدفعات",style: Theme.of(context).textTheme.titleLarge!),
                        //     ),
                        //     SizedBox(height: Dimensions.paddingSizeSmall,),
                        //     Wrap(
                        //         crossAxisAlignment: WrapCrossAlignment.end,
                        //         alignment: WrapAlignment.center,
                        //         children: List.generate(paymentsSystemTxt.length, (index) => paymentWidget(ref,index,paymentSystem))
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: Dimensions.paddingSizeLarge,),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     TextFormField(
                        //       //  controller: searchController,
                        //       textDirection: TextDirection.rtl,
                        //       cursorColor: Colors.grey,
                        //       style: TextStyle(color: Colors.black),
                        //       decoration: InputDecoration(
                        //           fillColor: Color(0xFFF9FAFA),
                        //           filled: true,
                        //           contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        //           hintText: "حدد عدد الدفعات المراد دفعها بالشهر",
                        //           hintStyle: TextStyle(color: Colors.grey,fontSize: 14),
                        //           enabledBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(10),
                        //               borderSide: BorderSide(
                        //                 color: Color(0xFFF9FAFA),
                        //               )
                        //           ),
                        //           focusedBorder: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(10),
                        //               borderSide: BorderSide(
                        //                   color: Theme.of(context).primaryColor
                        //               )
                        //           )
                        //       ),
                        //       onTap: (){
                        //
                        //       },
                        //       onChanged: (value){
                        //
                        //       },
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: Dimensions.paddingSizeLarge,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text("ملاحظات",style: Theme.of(context).textTheme.titleLarge!),
                            ),
                            SizedBox(height: Dimensions.paddingSizeSmall,),
                            TextFormField(
                              controller: noteEditingController,
                              textDirection: TextDirection.rtl,
                              cursorColor: Colors.grey,
                              maxLines: 4,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Color(0xFFF9FAFA),
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12,vertical: 6 ),
                                  hintText: "اكتب ملاحظاتك هنا",
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

                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.paddingSizeLarge,),
                        CustomButton(
                            buttonText: "إنشاء",
                            textColor: Colors.white,
                            height: 50,
                            borderRadius: 12,
                            onPressed: (){
                              Map<String,String> data = {
                                "payment_duration":"",
                                "note": noteEditingController.text ?? "",
                                "renter_name":renterEditingController.text,
                                "renter_phone":renterPhoneEditingController.text,
                                "monthly_price":""
                              };
                              print(widget.realStateModel.id);
                              if(_formKey.currentState!.validate()){
                                ref.read(ContractMineProvider.notifier).inviteContract(widget.realStateModel.id!, data);
                                showAnimatedDialog(
                                    context, dismissible: false,
                                    contractInvitation()
                                );
                              }
                            }
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

  Widget paymentWidget(ref,index,paymentSystem){
    return  SizedBox(
      width: MediaQuery.of(context).size.width*.45,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title:  Text(paymentsSystemTxt[index],style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Color(0xff677294))),
        leading: Radio<PaymentsSystem>(
          value: PaymentsSystem.values[index],
          fillColor: MaterialStateColor.resolveWith((states){
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).primaryColor;
            }
            // inactive
            return Colors.grey;
          }),
          groupValue: paymentSystem,
          onChanged: (PaymentsSystem? value) {
            if(value != null){
              ref.read(paymentsSystemProvider.notifier).state = value;
            }
          },
        ),
      ),
    );
  }

  Widget contractInvitation(){
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      insetPadding: EdgeInsets.zero,
      child: Builder(
        builder: (BuildContext dialogContext){
          return  Container(
            height: MediaQuery.of(dialogContext).size.height*.38,
            width: MediaQuery.of(dialogContext).size.width*.9,
            child: Column(
              children: [
                SizedBox(
                  height: 185,
                  width: 185,
                  child: Stack(
                    children: [
                      SvgPicture.asset("assets/images/Ellipse2.svg",colorFilter: ColorFilter.linearToSrgbGamma(),),
                      Center(child: SvgPicture.asset("assets/images/Ellipse2.svg",height: 150,width: 150,)),
                      Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Theme.of(dialogContext).primaryColor,borderRadius: BorderRadius.circular(50)),)),
                      Center(child: Text("✓",style: Theme.of(dialogContext).textTheme.titleLarge!.copyWith(fontSize: 22,color: Colors.white),)),

                    ],
                  ),),
                Text('تم ارسال دعوه إنشاء عقد',
                  textAlign: TextAlign.center,
                  style: Theme.of(dialogContext).textTheme.titleLarge!.copyWith(fontSize: 20),),
                SizedBox(height: Dimensions.paddingSizeLarge,),
                CustomButton(
                    buttonText: "تم",
                    height: 50,
                    width: 200,
                    textColor: Colors.white,
                    borderRadius: 12,
                    onPressed: (){
                      Navigator.push(dialogContext, MaterialPageRoute(builder: (BuildContext? context) {
                        if (context != null) {
                          return Homepage(page: 0,);
                        } else {
                          // Handle the case where context is null
                          return Container(); // or any other fallback UI
                        }
                      }));
                    }
                ),
              ],
            ),);
        },
      ),
    );
  }
}