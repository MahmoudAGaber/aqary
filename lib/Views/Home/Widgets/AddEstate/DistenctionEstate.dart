
import 'package:aqary/Views/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pay/pay.dart';
import '../../../../utill/dimensions.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_dialog.dart';
import 'package:aqary/payment_configurations.dart' as payment_configurations;


enum DistinctionEstateEnum { day, week, month }

class Distinction {
  void distinctionEstate(BuildContext context) {
    DistinctionEstateEnum? distinction = DistinctionEstateEnum.day;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height * .6;
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
                            right: Dimensions.paddingSizeDefault,
                            left: Dimensions.paddingSizeDefault),
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 25),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4),
                                    child: SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * .6,
                                      child: Text(
                                        'هل ترغب في تمييز إعلانك للحصول علي تأجير سريع ؟',
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(fontSize: 20),),
                                    ),
                                  ),
                                  SizedBox(height: Dimensions
                                      .paddingSizeDefault,),
                                  Column(
                                    children: List.generate(
                                        distinctionEstateTxt.length, (index) =>
                                        distinctionWidget(
                                            index, context, distinction)),
                                  ),
                                  SizedBox(height: Dimensions
                                      .paddingSizeDefault,),
                                  CustomButton(
                                      buttonText: "متابعه",
                                      height: 57,
                                      textColor: Colors.white,
                                      borderRadius: 12,
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaySampleApp()));
                                      }
                                  ),
                                  SizedBox(height: Dimensions
                                      .paddingSizeDefault,),
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showAnimatedDialog(
                                            context, dismissible: false,
                                            estateAdded()
                                        );
                                      },
                                      child: Text("تخطي", style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Theme
                                          .of(context)
                                          .primaryColor,),))

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
                          return Homepage();
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