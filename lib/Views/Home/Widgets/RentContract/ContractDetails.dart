

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../ViewModel/RealStateViewModel.dart';
import '../../../../utill/dimensions.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../AddEstate/AddEstate.dart';

class ContractDetails extends ConsumerStatefulWidget {
  const ContractDetails({super.key});

  @override
  ConsumerState<ContractDetails> createState() => _ContractDetailsState();
}

class _ContractDetailsState extends ConsumerState<ContractDetails> {

  @override
  Widget build(BuildContext context) {
    var paymentSystem = ref.watch(paymentsSystemProvider);

    return  Scaffold(
      appBar: CustomAppBar(
        title: "تفاصيل العقد",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text("المأجر",style: Theme.of(context).textTheme.titleLarge!),
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
                          //  controller: searchController,
                          textDirection: TextDirection.rtl,
                          cursorColor: Colors.grey,
                          style: TextStyle(color: Colors.black),
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
                          //  controller: searchController,
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
                          child: Text("رقم هاتف المستأجر",style: Theme.of(context).textTheme.titleLarge!),
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
                          child: Text("نظام الدفعات",style: Theme.of(context).textTheme.titleLarge!),
                        ),
                        SizedBox(height: Dimensions.paddingSizeSmall,),
                        Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            alignment: WrapAlignment.center,
                            children: List.generate(paymentsSystemTxt.length, (index) => paymentWidget(ref,index,paymentSystem))
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.paddingSizeLarge,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          //  controller: searchController,
                          textDirection: TextDirection.rtl,
                          cursorColor: Colors.grey,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Color(0xFFF9FAFA),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              hintText: "حدد عدد الدفعات المراد دفعها بالشهر",
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
                          child: Text("ملاحظات",style: Theme.of(context).textTheme.titleLarge!),
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
                          onTap: (){

                          },
                          onChanged: (value){

                          },
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
                        }
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
}