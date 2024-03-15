
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utill/dimensions.dart';
import '../../HomePage.dart';
import '../../base/custom_button.dart';
import '../../base/custom_dialog.dart';
import 'EstateDetails.dart';

class PaymentEstate extends StatefulWidget {
  const PaymentEstate({super.key});

  @override
  State<PaymentEstate> createState() => _PaymentEstateState();
}

class _PaymentEstateState extends State<PaymentEstate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "الدفع",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 112,
                child: Card(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => EstateDetails()));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            "assets/images/estate1.png",
                            width: 154,
                            height: 122,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("شقه للايجار في الشامخه", style: Theme
                                .of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                Text("1", style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith()),
                                SizedBox(width: 4,),
                                SvgPicture.asset("assets/images/bathroom.svg",
                                  color: Colors.grey, height: 16,),
                                SizedBox(width: Dimensions.paddingSizeDefault,),
                                Text("2", style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith()),
                                SizedBox(width: 4,),
                                SvgPicture.asset(
                                  "assets/images/bed.svg", color: Colors.grey,
                                  height: 16,),

                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: Dimensions.paddingSizeExtraSmall,
                                ),
                                Text(
                                  "الشامخه, أبوظبي",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontSize: 10),
                                ),
                              ],
                            ),
                            Text("30,000 درهم / سنويا", style: Theme
                                .of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 10, color: Theme
                                .of(context)
                                .primaryColor),),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text("تفاصيل الحساب", style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge!),
                  ),
                  SizedBox(height: Dimensions.paddingSizeSmall,),
                  Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFECEDF3)),
                        borderRadius: BorderRadius.circular(15),
                      ),),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.paddingSizeDefault),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("الدفعات المستحقه", style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Color(0xFF53577A))),
                              SizedBox(height: Dimensions.paddingSizeSmall,),
                              Text("الدفع الشهري", style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Color(0xFF53577A))),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("2 شهر", style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Color(0xFF53577A))),
                              SizedBox(height: Dimensions.paddingSizeSmall,),
                              Text("2000 درهم", style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Color(0xFF53577A))),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFF5F4F7),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("الإجمالي", style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith()),

                      Text("4000 درهم", style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith()),

                    ],
                  ),
                ),
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("طريقة الدفع", style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge!),
                        InkWell(
                            onTap: () {
                              openDialog(
                                paymentType(context),context, isDismissible: true,isDialog: true, willPop: true,
                              );
                            },
                            child: Text("تغيير", style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Color(0xFF677294),))),

                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.paddingSizeSmall,),
                  Container(
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xFFECEDF3),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeDefault),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/images/cash.svg", height: 25,),
                          SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text("كاش", style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text("ملاحظات", style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge!),
                  ),
                  SizedBox(height: Dimensions.paddingSizeSmall,),
                  TextFormField(
                    //  controller: searchController,
                    textDirection: TextDirection.rtl,
                    cursorColor: Colors.grey,
                    maxLines: 3,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        fillColor: Color(0xFFF9FAFA),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        hintText: "اكتب ملاحظاتك هنا",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xFFF9FAFA),
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme
                                    .of(context)
                                    .primaryColor
                            )
                        )
                    ),
                    onTap: () {

                    },
                    onChanged: (value) {

                    },
                  ),
                ],
              ),
              SizedBox(height: Dimensions.paddingSizeLarge,),
              CustomButton(
                onPressed: (){
                  Navigator.pop(context);
                  showAnimatedDialog(
                      context, dismissible: false, estateAdded()
                  );
                },
                buttonText: "تم",
                textColor: Colors.white,
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget paymentType(context) {
    return SizedBox(
      height: 320,
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault,right: Dimensions.paddingSizeDefault,left: Dimensions.paddingSizeDefault),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Center(
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 3,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.paddingSizeLarge,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text("تغيير طريقة الدفع",style: Theme.of(context).textTheme.titleLarge!),
                          ),
                          SizedBox(height: Dimensions.paddingSizeDefault,),
                          Container(
                            height: 95,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/images/cash.svg",color: Colors.white,),
                                SizedBox(height: Dimensions.paddingSizeSmall,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: Text("كاش",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Dimensions.paddingSizeDefault,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text("",style: Theme.of(context).textTheme.titleLarge!),
                          ),
                          SizedBox(height: Dimensions.paddingSizeSmall,),
                          Container(
                            height: 95,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xFFF9FAFA),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset("assets/images/bank.svg",color: Colors.black,),
                                SizedBox(height: Dimensions.paddingSizeSmall,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 6),
                                  child: Text("تحويل بنكي",style: Theme.of(context).textTheme.bodyMedium!),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                CustomButton(
                    buttonText: "اختر طريقه الدفع",
                    textColor: Colors.white,
                    onPressed: (){})


              ])
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
                Text('تم تأجير العقار بنجاح',
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
