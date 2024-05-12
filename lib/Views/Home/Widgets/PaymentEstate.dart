import 'dart:io';

import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:aqary/helper/date_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../ViewModel/ContractViewModel.dart';
import '../../../ViewModel/RealStateViewModel.dart';
import '../../../utill/dimensions.dart';
import '../../HomePage.dart';
import '../../base/custom_button.dart';
import '../../base/custom_dialog.dart';
import 'EstateDetails.dart';

class PaymentEstate extends ConsumerStatefulWidget {
  String contractId;
  String type;
  PaymentEstate({super.key, required this.contractId,required this.type});

  @override
  ConsumerState<PaymentEstate> createState() => _PaymentEstateState();
}

class _PaymentEstateState extends ConsumerState<PaymentEstate> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController paymentNotesController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(ContractMineProvider.notifier).getOneContract(widget.contractId).then((value) async {
        print("HOHO${value}");
        await ref.read(RealStateGetOneProvider.notifier).getOneEstate(value!.property.id!);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var paymentSystem = ref.watch(paymentsSystemProvider);
    var signature = ref.watch(signatureProvider);
    var property = ref.watch(RealStateGetOneProvider);
    var contract = ref.watch(ContractMineProvider);
    var paymentType = ref.watch(EstatePaymentProvider);
    var bankPaymentImage = ref.watch(BankPaymentImageProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: "الدفع",
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: contract.handelState(
                onLoading: (state) => Center(
                      child: CircularProgressIndicator(),
                    ),
                onSuccess: (state) => Form(
                  key: _formKey,
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          property.handelState(
                            onLoading: (state) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            onSuccess: (state) => SizedBox(
                              height: 112,
                              child: Card(
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EstateDetails(
                                                      propertyId:
                                                          property.data!.data.id!,
                                                    )));
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                        child: property.data!.data.images.isEmpty
                                            ? SizedBox()
                                            : Image.network(
                                                property
                                                    .data!.data.images.first.path,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(property.data!.data.title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          Row(
                                            children: [
                                              Text(
                                                  property
                                                      .data!.data.bathroomsCount
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith()),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              SvgPicture.asset(
                                                "assets/images/bathroom.svg",
                                                color: Colors.grey,
                                                height: 16,
                                              ),
                                              SizedBox(
                                                width:
                                                    Dimensions.paddingSizeDefault,
                                              ),
                                              Text(
                                                  property
                                                      .data!.data.bedroomsCount
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith()),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              SvgPicture.asset(
                                                "assets/images/bed.svg",
                                                color: Colors.grey,
                                                height: 16,
                                              ),
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
                                                width: Dimensions
                                                    .paddingSizeExtraSmall,
                                              ),
                                              Text(
                                                "${property.data!.data.city}, ${property.data!.data.country}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${DateConverter.numberFormat(property.data!.data.yearPrice)} درهم / سنويا",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 10,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onFailure: (state) => Text("SHIT"),
                          ),
                          SizedBox(
                            height: Dimensions.paddingSizeLarge,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text("تفاصيل الحساب",
                                    style:
                                        Theme.of(context).textTheme.titleLarge!),
                              ),
                              SizedBox(
                                height: Dimensions.paddingSizeSmall,
                              ),
                              Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Color(0xFFECEDF3)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      Dimensions.paddingSizeDefault),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("الدفعات المستحقه",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Color(0xFF53577A))),
                                          SizedBox(
                                            height: Dimensions.paddingSizeSmall,
                                          ),
                                          Text("الدفع الشهري",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Color(0xFF53577A))),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text("1 شهر",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Color(0xFF53577A))),
                                          SizedBox(
                                            height: Dimensions.paddingSizeSmall,
                                          ),
                                          Text(
                                              "${contract.data!.first.monthlyPrice} درهم",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: Color(0xFF53577A))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.paddingSizeLarge,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F4F7),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("الإجمالي",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith()),
                                  Text(
                                      "${contract.data!.first.monthlyPrice} درهم",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith()),
                                ],
                              ),
                            ),
                          ),
                         widget.type == 'prepaid'? Column(
                            children: [
                              SizedBox(
                                height: Dimensions.paddingSizeLarge,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("طريقة الدفع",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!),
                                        InkWell(
                                            onTap: () {
                                              openDialog(
                                                widgetPaymentType(context),
                                                context,
                                                isDismissible: true,
                                                isDialog: true,
                                                willPop: true,
                                              );
                                            },
                                            child: Text("تغيير", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Color(0xFF677294),
                                            ))
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  paymentType == PaymentType.cash
                                      ? Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                            color: Color(0xFFECEDF3),
                                          )),
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset("assets/images/cash.svg", height: 25,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.paddingSizeExtraSmall,
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 6),
                                                    child: Text("كاش",
                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold))),
                                              ]
                                          )))
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset("assets/images/cash.svg", height: 25,
                                          ),
                                          SizedBox(width: Dimensions.paddingSizeExtraSmall,),
                                          Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 6),
                                              child: Text("تحويل بنكي", style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold))),
                                        ],
                                      ),
                                      SizedBox(height: Dimensions.paddingSizeDefault,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          bankPaymentImage.isNotEmpty
                                              ? Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: SizedBox(
                                                  height: 200,width: 320,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(8),
                                                      child: Image.file(File(bankPaymentImage.first.path),fit: BoxFit.cover,)),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  ref.read(BankPaymentImageProvider.notifier).getBankImage();
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(
                                                      radius: 12,
                                                      backgroundColor: Theme.of(context).primaryColor,
                                                      child: Icon(Icons.replay,color: Colors.white,size: 18,)),
                                                ),
                                              )
                                            ],
                                          )
                                              :InkWell(
                                            onTap: () {
                                              ref.read(BankPaymentImageProvider.notifier).getBankImage();
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 120,
                                                width: MediaQuery.of(context).size.width*.9,
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Theme.of(context).primaryColor),
                                                    borderRadius: BorderRadius.circular(12)
                                                ),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Image.asset("assets/images/addBank.png",
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8,),
                                                    Text("إضافة صور التحويل البنكي", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),


                                ],
                              ),
                              SizedBox(
                                height: Dimensions.paddingSizeLarge,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text("ملاحظات",
                                        style:
                                        Theme.of(context).textTheme.titleLarge!),
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  TextFormField(
                                    controller: paymentNotesController,
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
                                        hintStyle: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Color(0xFFF9FAFA),
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color:
                                                Theme.of(context).primaryColor))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'من فضلك  قوم بتدوين الدفع';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.paddingSizeLarge,
                              ),
                              CustomButton(
                                onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                    Map<String, String> data = {
                                      'payment_type': paymentType.name,
                                      'note' : paymentNotesController.text,
                                      'amount': contract.data!.first.monthlyPrice.toString()
                                    };
                                    if(paymentType == PaymentType.cash){
                                      ref.read(PaymentPayProvider.notifier).estatePay(widget.contractId, "", data);
                                    }
                                    else if(paymentType == PaymentType.bank){
                                      if(bankPaymentImage.isNotEmpty){
                                        print("OK");
                                        ref.read(PaymentPayProvider.notifier).estatePay(
                                            widget.contractId, bankPaymentImage.first.path, data);
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("من فضلك قوم باختيار صوره للتحويل البنكي"),duration: Duration(seconds: 2),));
                                      }

                                    }
                                    Navigator.pop(context);
                                    showAnimatedDialog(
                                        context, dismissible: false, estateAdded());
                                  }

                                },
                                buttonText: "تم",
                                textColor: Colors.white,
                                backgroundColor: Theme.of(context).primaryColor,
                              )
                            ],
                          ):SizedBox()

                        ],
                      ),
                ),
                onFailure: (state) => Center(child: Text("SHIT")))),
      ),
    );
  }

  Widget widgetPaymentType(context) {
    return Consumer(
      builder: (context, ref, child) {
        var paymentType = ref.watch(EstatePaymentProvider);
        return SizedBox(
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.only(
                  top: Dimensions.paddingSizeDefault,
                  right: Dimensions.paddingSizeDefault,
                  left: Dimensions.paddingSizeDefault),
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
                    SizedBox(
                      height: Dimensions.paddingSizeLarge,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text("تغيير طريقة الدفع",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!),
                              ),
                              SizedBox(
                                height: Dimensions.paddingSizeDefault,
                              ),
                              InkWell(
                                onTap: () {
                                  ref
                                      .read(EstatePaymentProvider.notifier)
                                      .changePaymentType(PaymentType.cash);
                                },
                                child: Container(
                                  height: 95,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: paymentType == PaymentType.cash
                                        ? Theme.of(context).primaryColor
                                        : Color(0xFFF9FAFA),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/cash.svg",
                                        color: paymentType == PaymentType.cash
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      SizedBox(
                                        height: Dimensions.paddingSizeSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Text("كاش",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: paymentType ==
                                                            PaymentType.cash
                                                        ? Colors.white
                                                        : Colors.black)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.paddingSizeDefault,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text("",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!),
                              ),
                              SizedBox(
                                height: Dimensions.paddingSizeSmall,
                              ),
                              InkWell(
                                onTap: () {
                                  ref.read(EstatePaymentProvider.notifier).changePaymentType(PaymentType.bank);
                                },
                                child: Container(
                                  height: 95,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: paymentType == PaymentType.bank
                                        ? Theme.of(context).primaryColor
                                        : Color(0xFFF9FAFA),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/bank.svg",
                                        color: paymentType == PaymentType.bank
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      SizedBox(
                                        height: Dimensions.paddingSizeSmall,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Text("تحويل بنكي",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: paymentType == PaymentType.bank
                                                        ? Colors.white
                                                        : Colors.black)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeExtraLarge,
                    ),
                    CustomButton(
                        buttonText: "اختر طريقه الدفع",
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ])),
        );
      },
    );
  }

  Widget estateAdded() {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      insetPadding: EdgeInsets.zero,
      child: Builder(
        builder: (BuildContext dialogContext) {
          return Container(
            height: MediaQuery.of(dialogContext).size.height * .38,
            width: MediaQuery.of(dialogContext).size.width * .9,
            child: Column(
              children: [
                SizedBox(
                  height: 185,
                  width: 185,
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/images/Ellipse2.svg",
                        colorFilter: ColorFilter.linearToSrgbGamma(),
                      ),
                      Center(
                          child: SvgPicture.asset(
                        "assets/images/Ellipse2.svg",
                        height: 150,
                        width: 150,
                      )),
                      Center(
                          child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Theme.of(dialogContext).primaryColor,
                            borderRadius: BorderRadius.circular(50)),
                      )),
                      Center(
                          child: Text(
                        "✓",
                        style: Theme.of(dialogContext)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 22, color: Colors.white),
                      )),
                    ],
                  ),
                ),
                Text(
                  'تم تأكيد الدفع',
                  textAlign: TextAlign.center,
                  style: Theme.of(dialogContext)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: Dimensions.paddingSizeLarge,
                ),
                CustomButton(
                    buttonText: "تم",
                    height: 50,
                    width: 200,
                    textColor: Colors.white,
                    borderRadius: 12,
                    onPressed: () {
                      Navigator.push(dialogContext,
                          MaterialPageRoute(builder: (BuildContext? context) {
                        if (context != null) {
                          return Homepage(
                            page: 0,
                          );
                        } else {
                          // Handle the case where context is null
                          return Container(); // or any other fallback UI
                        }
                      }));
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
