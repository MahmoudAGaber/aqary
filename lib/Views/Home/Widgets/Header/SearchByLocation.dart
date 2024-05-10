

import 'package:aqary/Models/CountryCitiesModel.dart';
import 'package:aqary/Views/Home/Widgets/MoreEstates.dart';
import 'package:aqary/Views/HomePage.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pay/pay.dart';
import '../../../../ViewModel/LocationViewModel.dart';
import '../../../../ViewModel/RealStateViewModel.dart';
import '../../../../ViewModel/UserViewModel.dart';
import '../../../../utill/dimensions.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_dialog.dart';
import 'package:aqary/payment_configurations.dart' as payment_configurations;

import '../../../base/custom_text_field.dart';


enum DistinctionEstateEnum { day, week, month }

class SearchByLocation {
  TextEditingController searchEditController = TextEditingController();
  void searchByLocation(BuildContext context) {
    DistinctionEstateEnum? distinction = DistinctionEstateEnum.day;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height * .85;
    showModalBottomSheet<void>(
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      context: context,
      builder: (BuildContext context) {
        return Consumer(
            builder: (context, ref, child) {
              var currentLocation = ref.watch(userLocationProvider);
              var countries = ref.watch(CountryCityProvider);
              var contriesByRegions = ref.watch(CountryByRegionsProvider);

              return WillPopScope(
                onWillPop: () async {
                  return true;
                },
                child: Container(
                    height: screenHeight,
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .cardTheme
                            .color,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.paddingSizeDefault,
                           // right: Dimensions.paddingSizeDefault,
                           // left: Dimensions.paddingSizeDefault),
                        ),
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20,left: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault),
                                    child: Center(
                                      child: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              4),
                                          border: Border.all(
                                            width: 3,
                                            strokeAlign: BorderSide
                                                .strokeAlignCenter,
                                            color: Colors.black12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4,horizontal: Dimensions.paddingSizeDefault),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'اختر موقعا',
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontSize: 20),),
                                        InkWell(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                            child: Icon(Icons.clear))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.paddingSizeDefault,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeDefault),
                                    child: CustomTextField(
                                      controller:searchEditController,
                                      hintText: 'ابحث عم الموقع الذي تريده',
                                      isIcon: true,
                                      prefixIconUrl: CupertinoIcons.search,
                                      isShowSuffixIcon: true,
                                      isShowPrefixIcon: true,
                                      inputAction: TextInputAction.search,
                                      isSearch: true,
                                      isShowBorder: true,
                                      onChanged: (value){
                                        ref.read(CountryCityProvider.notifier).getCountries(value);
                                      },
                                      suffixIconUrl: CupertinoIcons.clear,
                                      onSuffixTap: (){
                                        ref.read(CountryCityProvider.notifier).state = StateModel.loading();
                                        searchEditController.clear();
                                      },
                                    ),
                                  ),
                                  SizedBox(height: Dimensions.paddingSizeDefault,),
                                  countries.handelState<List<Countries>>(
                                    onLoading: (state)=> Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: ()async{
                                              await ref.read(userLocationProvider.notifier).getCurrentUserLocation();
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage(page: 0)));
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.my_location,color: Theme.of(context).primaryColor,),
                                                SizedBox(width: 10,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("استخدام الموقع الحالي...",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16,color: Theme.of(context).primaryColor)),
                                                    currentLocation != null ?
                                                    Text(
                                                      "${currentLocation.placemark!.administrativeArea}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(fontSize: 15),
                                                      overflow: TextOverflow.clip,
                                                    ):SizedBox(),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.paddingSizeDefault,),
                                          Divider(height: 5,),
                                          SizedBox(height: Dimensions
                                              .paddingSizeDefault,),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreEstates(city: "${ref.watch(UserProvider).data!.recentLocations.first.split(" ")[0]}",)));
                                            },
                                            child:ref.watch(UserProvider).data!.recentLocations.isNotEmpty || ref.watch(UserProvider).data!.recentLocations == []
                                    ?Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("مؤخرا",style: Theme.of(context).textTheme.bodyLarge!.copyWith()),
                                                SizedBox(height: 10,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.location_on_rounded,color: Theme.of(context).primaryColor, size: 18,),
                                                    SizedBox(width: 10,),
                                                    currentLocation != null ?
                                                    Text(
                                                      "${ref.watch(UserProvider).data!.recentLocations[0]}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(fontSize: 15),
                                                      overflow: TextOverflow.clip,
                                                    ):SizedBox(),
                                                  ],
                                                ),
                                                SizedBox(height: Dimensions.paddingSizeDefault,),
                                                Divider(height: 5,),
                                              ],
                                            ):SizedBox(),
                                          ),

                                          SizedBox(height: Dimensions
                                              .paddingSizeDefault,),

                                          SizedBox(height: Dimensions.paddingSizeDefault,),
                                          countries.handelState(
                                            onLoading: (state)=> Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("المنطقة",style: Theme.of(context).textTheme.bodyLarge!.copyWith()),
                                                SizedBox(height: 10,),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(Icons.location_on_rounded,color: Theme.of(context).primaryColor, size: 18,),
                                                    SizedBox(width: 10,),
                                                    currentLocation != null ?
                                                    Text(
                                                      "جميع مدن  ${currentLocation.placemark!.country}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(fontSize: 15,color: Theme.of(context).primaryColor),
                                                      overflow: TextOverflow.clip,
                                                    ):SizedBox(),
                                                  ],
                                                ),
                                                contriesByRegions.handelState(
                                                  onLoading:  (state)=> Padding(
                                                    padding: const EdgeInsets.only(top: 20),
                                                    child: Center(child: SizedBox(height: 25,width: 25,
                                                        child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)),),
                                                  ),
                                                  onSuccess: (state)=> ListView.builder(
                                                      itemCount: contriesByRegions.data![0].citiesAndAreas.length,
                                                      shrinkWrap: true,
                                                      itemBuilder: (context,index){
                                                        print("${contriesByRegions.data!.length}");
                                                        return Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(contriesByRegions.data![0].citiesAndAreas[index],style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16)),
                                                              InkWell(
                                                                onTap: (){
                                                                  ref.read(RealStateProvider.notifier).state.clear();
                                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreEstates(city: contriesByRegions.data![0].citiesAndAreas[index],)));

                                                                },
                                                                child: Icon(Icons.arrow_forward_ios,size: 15,),
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },),
                                                  onFailure: (state)=> Text("SHIT")

                                                )

                                              ],
                                            ),

                                          )

                                        ],
                                      ),
                                    ),
                                    onSuccess: (state)=> Container(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: countries.data!.length,
                                        itemBuilder: (context,index){
                                          var item = countries.data![index];
                                         return Container(
                                           decoration: BoxDecoration(
                                             border: Border(bottom: BorderSide(color: Colors.grey))
                                           ),
                                           child: Column(
                                             children: [
                                               InkWell(
                                                 onTap:(){
                                                   ref.read(RealStateProvider.notifier).state.clear();
                                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreEstates(city: item.countryName,)));
                                                   },
                                                 child: Container(
                                                   color: Colors.grey[100],
                                                   child: Padding(
                                                     padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                                     child: Row(
                                                       children: [
                                                         Text(item.countryName,style: Theme.of(context).textTheme.titleLarge,),
                                                       ],
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                               Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: List.generate(item.citiesAndAreas.length, (index){
                                                    return InkWell(
                                                      onTap: (){
                                                        ref.read(RealStateProvider.notifier).state.clear();
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreEstates(city: item.citiesAndAreas[index],)));

                                                      },
                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            item.citiesAndAreas[index] == "" ||  item.citiesAndAreas[index] == null
                                                                ?SizedBox()
                                                                :Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                                                              child: Text(item.citiesAndAreas[index],style: Theme.of(context).textTheme.bodyMedium,),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  })
                                                ),
                                             ],
                                           ),
                                         );
                                        },
                                      ),
                                    )
                                  )

                                ])
                        )
                    )
                ),
              );
            }
        );
      },
    );

  }
  List<String> distinctionEstateTxt = [
    "يوم واحد ( 10 \$ )",
    "أسبوع ( 10 \$ )",
    "شهر ( 10 \$ )"
  ];

  Widget distinctionWidget(index,context,distinction){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xFFF4F6F9)
        ),
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          title:  Text(distinctionEstateTxt[index],style: Theme.of(context).textTheme.bodyMedium),
          trailing: Radio<DistinctionEstateEnum>(
            activeColor: Theme.of(context).primaryColor,
            fillColor: MaterialStateColor.resolveWith((states){
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).primaryColor;
              }
              // inactive
              return Colors.grey;
            }),
            value: DistinctionEstateEnum.values[index],
            groupValue: distinction,
            onChanged: (DistinctionEstateEnum? value) {
              distinction = value;
            },
          ),
        ),
      ),
    );
  }

  Widget estateAdded(){
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
                Text('سيتم نشر الإعلان قريبا',
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
                          return Homepage(page: 0);
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

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

class PaySampleApp extends StatefulWidget {
  const PaySampleApp({super.key});

  @override
  State<PaySampleApp> createState() => _PaySampleAppState();
}

class _PaySampleAppState extends State<PaySampleApp> {
  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('default_google_pay_config.json');
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T-shirt Shop'),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 350,
            ),
          ),
          const Text(
            'Amanda\'s Polo Shirt',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xff333333),
              fontWeight: FontWeight.bold,
            ),
          ),

          // Example pay button configured using an asset
          FutureBuilder<PaymentConfiguration>(
              future: _googlePayConfigFuture,
              builder: (context, snapshot) => snapshot.hasData
                  ? GooglePayButton(
                paymentConfiguration: snapshot.data!,
                paymentItems: _paymentItems,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : const SizedBox.shrink()),
          // Example pay button configured using a string
          ApplePayButton(
            paymentConfiguration: PaymentConfiguration.fromJsonString(
                payment_configurations.defaultApplePay),
            paymentItems: _paymentItems,
            style: ApplePayButtonStyle.black,
            type: ApplePayButtonType.buy,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onApplePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}