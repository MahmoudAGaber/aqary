

import 'dart:io';

import 'package:aqary/Models/ContractModel.dart';
import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/ViewModel/RealStateViewModel.dart';
import 'package:aqary/Views/Home/Widgets/SignaturePad.dart';
import 'package:aqary/Views/PdfViewer.dart';
import 'package:aqary/Views/base/custom_button.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:aqary/helper/payment_helper.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../ViewModel/ContractViewModel.dart';
import '../../../helper/date_converter.dart';
import '../../PdfGenerator.dart';
import '../../base/custom_app_bar.dart';
import 'EstateDetails.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class OwnerCTSignature extends ConsumerStatefulWidget {
  String contractId;
  OwnerCTSignature({super.key,required this.contractId});

  @override
  ConsumerState<OwnerCTSignature> createState() => _RentState();
}

class _RentState extends ConsumerState<OwnerCTSignature> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController ownerEstateEditingController = TextEditingController();
  TextEditingController renterEstateEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  TextEditingController paymentSystemEditingController = TextEditingController();
  TextEditingController fromDateEditingController = TextEditingController();
  TextEditingController toDateEditingController = TextEditingController();

  String? todayDate;

  Future<void> _selectDate(BuildContext context,TextEditingController dateText) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green, // Change primary color
            colorScheme: ColorScheme.light(
                primary: Theme.of(context).primaryColor,
                surface: Colors.white,
                surfaceTint: Colors.white),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dateText.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  DateTime parseDateString(String dateString) {
    return DateFormat('dd/MM/yyyy').parse(dateString);
  }

  int calculateMonthsBetween(String fromDate, String toDate) {
    DateTime startDate = parseDateString(fromDate);
    DateTime endDate = parseDateString(toDate);

    if (startDate.isAfter(endDate)) {
      throw ArgumentError('The start date must be before the end date.');
    }

    int months = (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;

    if (endDate.day < startDate.day) {
      months--;
    }

    return months;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      ref.read(ContractMineProvider.notifier).getOneContract(widget.contractId).then((value)async{
        await ref.read(RealStateGetOneProvider.notifier).getOneEstate(value!.property.id!);
        ownerEstateEditingController.text = value.owner;
        renterEstateEditingController.text = value.renter;
        fromDateEditingController.text = DateConverter.isoStringToLocalDateOnly2(value.from);
        toDateEditingController.text = DateConverter.isoStringToLocalDateOnly2(value.to);
        ref.read(paymentTypeProvider.notifier).state = value.paymentType == PaymentType.bank.name ? PaymentType.bank:PaymentType.cash;
        noteEditingController.text = value.note;
        paymentSystemEditingController.text = "${value.monthlyPrice} الدفعة ";
      });

      todayDate = DateConverter.slotDate(DateTime.now());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var paymentSystem = ref.watch(paymentsSystemProvider);
    var paymentType = ref.watch(paymentTypeProvider);
    var signature = ref.watch(signatureProvider);
    var property =  ref.watch(RealStateGetOneProvider);
    var contract = ref.watch(ContractMineProvider);
    print("NOTIFICATION$property");
    if(property.data !=null){
      paymentSystemEditingController.text = "الدفعة ${PaymentHelper.getPayment(property.data!.data.yearPrice, paymentSystem)}";

    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "توقيع المؤجر",
        isCenter: true,
        isBackButtonExist: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Form(
            key: _formKey,
            child: contract.handelState(
              onLoading: (state)=> Center(child: CircularProgressIndicator(),),
              onSuccess: (state)=>Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  property.handelState(
                    onLoading: (state)=> Center(child: CircularProgressIndicator(),),
                    onSuccess: (state)=>Column(
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EstateDetails(
                                              propertyId: property.data!.data.id!,
                                            )));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: property.data!.data.images.isEmpty
                                        ? SizedBox()
                                        :Image.network(
                                      property.data!.data.images.first.path,
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
                                      Text(property.data!.data.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontWeight: FontWeight.w600)),
                                      Row(
                                        children: [
                                          Text(
                                              property.data!.data.bathroomsCount.toString(),
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
                                            width: Dimensions.paddingSizeDefault,
                                          ),
                                          Text(property.data!.data.bedroomsCount.toString(),
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
                                            width: Dimensions.paddingSizeExtraSmall,
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
                                        "${property.data!.data.yearPrice} درهم / سنويا",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                            fontSize: 10,
                                            color: Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                )
                              ],
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
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text("المأجر",
                                        style: Theme.of(context).textTheme.titleLarge!),
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  TextFormField(
                                    controller: ownerEstateEditingController,
                                    textDirection: ui.TextDirection.rtl,
                                    cursorColor: Colors.grey,
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                    decoration: InputDecoration(
                                        fillColor: Color(0xFFF9FAFA),
                                        filled: true,
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                        hintText: "اسم مأجر العقار",
                                        hintStyle:
                                        TextStyle(color: Colors.grey, fontSize: 14),
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
                                    validator: (value){
                                      if (value == null || value.isEmpty) {
                                        return 'من فضلك قم بإدخال اسم مؤجر العقار';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.paddingSizeSmall,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text("المستأجر",
                                        style: Theme.of(context).textTheme.titleLarge!),
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  TextFormField(
                                    controller: renterEstateEditingController,
                                    textDirection: ui.TextDirection.rtl,
                                    cursorColor: Colors.grey,
                                    style: TextStyle(color: Colors.black, fontSize: 14),
                                    decoration: InputDecoration(
                                        fillColor: Color(0xFFF9FAFA),
                                        filled: true,
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                        hintText: "اسم المستأجر للعقار",
                                        hintStyle:
                                        TextStyle(color: Colors.grey, fontSize: 14),
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
                                    validator: (value){
                                      if (value == null || value.isEmpty) {
                                        return 'من فضلك قم بإدخال اسم مستأجر العقار';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text("مده الإيجار",
                                        style: Theme.of(context).textTheme.titleLarge!),
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  TextFormField(
                                    enabled: false,
                                    controller: fromDateEditingController,
                                    textDirection: ui.TextDirection.ltr,
                                    cursorColor: Colors.grey,
                                    keyboardType: TextInputType.datetime,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        fillColor: Color(0xFFF9FAFA),
                                        filled: true,
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                        labelText: "من",
                                        labelStyle: TextStyle(color: Colors.black),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            height: 2.5),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Color(0xFFF9FAFA),
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Theme.of(context).primaryColor)),
                                        prefixIcon: IconButton(
                                          onPressed: () {
                                            _selectDate(context,fromDateEditingController);
                                          },
                                          icon: Icon(Icons.calendar_month_outlined,
                                              color: Colors.black, size: 20),
                                        )),
                                    readOnly: true, // Make it read-only
                                    onTap: () {
                                      _selectDate(context,fromDateEditingController); // Show date picker when tapped
                                    },
                                    validator: (value){
                                      if (value == null || value.isEmpty) {
                                        return 'من فضلك قم بإدخال تاريخ بدايه العقد';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.paddingSizeSmall,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text("",
                                        style: Theme.of(context).textTheme.titleLarge!),
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  TextFormField(
                                    enabled: false,
                                    controller: toDateEditingController,
                                    textDirection: ui.TextDirection.ltr,
                                    cursorColor: Colors.grey,
                                    keyboardType: TextInputType.datetime,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        fillColor: Color(0xFFF9FAFA),
                                        filled: true,
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                        labelText: "إلي",
                                        labelStyle: TextStyle(color: Colors.black),
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            height: 2.5),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Color(0xFFF9FAFA),
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Theme.of(context).primaryColor)),
                                        prefixIcon: IconButton(
                                          onPressed: () {
                                            _selectDate(context,toDateEditingController);
                                          },
                                          icon: Icon(Icons.calendar_month_outlined,
                                              color: Colors.black, size: 20),
                                        )),
                                    readOnly: true, // Make it read-only
                                    onTap: () {
                                      _selectDate(context,toDateEditingController); // Show date picker when tapped
                                    },
                                    validator: (value){
                                      if (value == null || value.isEmpty) {
                                        return 'من فضلك قم بإدخال تاريخ نهاية العقد';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: Dimensions.paddingSizeLarge,
                        // ),
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(horizontal: 6),
                        //       child: Text("نظام الدفعات",
                        //           style: Theme.of(context).textTheme.titleLarge!),
                        //     ),
                        //     SizedBox(
                        //       height: Dimensions.paddingSizeSmall,
                        //     ),
                        //     Wrap(
                        //         crossAxisAlignment: WrapCrossAlignment.end,
                        //         alignment: WrapAlignment.center,
                        //         children: List.generate(
                        //             paymentsSystemTxt.length,
                        //                 (index) => paymentWidget(index, paymentSystem,
                        //                 property.yearPrice))),
                        //   ],
                        // ),
                        SizedBox(
                          height: Dimensions.paddingSizeLarge,
                        ),
                        TextFormField(
                          controller: paymentSystemEditingController,
                          textDirection: ui.TextDirection.rtl,
                          cursorColor: Colors.grey,
                          enabled: false,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Color(0xFFF9FAFA),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              hintText: "الدفعه${paymentSystemEditingController.text} ",
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFF9FAFA),
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor))),
                          onTap: () {},
                          onChanged: (value) {},
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
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text("طريقه الدفع",
                                        style: Theme.of(context).textTheme.titleLarge!),
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //   ref.read(paymentTypeProvider.notifier).state = PaymentType.cash;
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
                              width: Dimensions.paddingSizeExtraSmall,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
                                    child: Text("",
                                        style: Theme.of(context).textTheme.titleLarge!),
                                  ),
                                  SizedBox(
                                    height: Dimensions.paddingSizeSmall,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      //  ref.read(paymentTypeProvider.notifier).state = PaymentType.bank;
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
                                                    color: paymentType ==
                                                        PaymentType.bank
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
                          height: Dimensions.paddingSizeLarge,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Text("ملاحظات",
                                  style: Theme.of(context).textTheme.titleLarge!),
                            ),
                            SizedBox(
                              height: Dimensions.paddingSizeSmall,
                            ),
                            TextFormField(
                              enabled: false,
                              controller: noteEditingController,
                              textDirection: ui.TextDirection.rtl,
                              cursorColor: Colors.grey,
                              maxLines: 2,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Color(0xFFF9FAFA),
                                  filled: true,
                                  contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  hintText: "اكتب ملاحظاتك هنا",
                                  hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFFF9FAFA),
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor))),
                              onTap: () {},
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeLarge,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 123,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor)),
                                child: InkWell(
                                  onTap: () async{
                                    if(ref.watch(signatureProvider).data != null){
                                      var rentPeriod = "${calculateMonthsBetween(fromDateEditingController.text, toDateEditingController.text)}  شهر";
                                      File file =  await PdfInvoiceApi.generate(
                                          signature: ref,
                                          todayDate: todayDate!,
                                          from: fromDateEditingController.text,
                                          to: toDateEditingController.text,
                                          rentPeriod: rentPeriod,
                                          location: property.data!.data.location,
                                          ownerName: ownerEstateEditingController.text,
                                          renterName: renterEstateEditingController.text,
                                          titleRent: "${property.data!.data.title}",
                                          payment: paymentSystemEditingController.text,
                                          notes: noteEditingController.text,
                                          isOwner: true,
                                          paymentStyle: PaymentHelper.getArabicPaymentStyle(paymentSystem));

                                      print("TestContractFIle${file.path}");

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => PdfViewer()));
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("من فضلك قم بإضة التوقيع الخاص بك",style: TextStyle(color: Colors.black),)));

                                    }

                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/file.png",
                                        height: 38,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      SizedBox(
                                        height: Dimensions.paddingSizeSmall,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 6),
                                        child: Text("معاينة العقد",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.paddingSizeDefault,
                            ),
                            Expanded(
                              child: Container(
                                height: 123,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignaturePad()));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/sing.svg",
                                      ),
                                      SizedBox(
                                        height: Dimensions.paddingSizeSmall,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 6),
                                        child: Text("توقيع عقد الإيجار",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.paddingSizeLarge,
                        ),
                        CustomButton(
                          onPressed: ()async {
                            if(contract.data!.first.status == 'requested'){
                              if(signature.data! != null) {
                                if (_formKey.currentState!.validate()) {
                                  var rentPeriod = "${calculateMonthsBetween(fromDateEditingController.text, toDateEditingController.text)}  شهر";
                                  File file =  await PdfInvoiceApi.generate(
                                      signature: ref,
                                      todayDate: todayDate!,
                                      from: fromDateEditingController.text,
                                      to: toDateEditingController.text,
                                      rentPeriod: rentPeriod,
                                      location: property.data!.data.location,
                                      ownerName: ownerEstateEditingController.text,
                                      renterName: renterEstateEditingController.text,
                                      titleRent: "${property.data!.data.title}",
                                      payment: paymentSystemEditingController.text,
                                      notes: noteEditingController.text,
                                      isOwner: true,
                                      paymentStyle: PaymentHelper.getArabicPaymentStyle(paymentSystem)).then((value){
                                    ref.read(ContractMineProvider.notifier).acceptContract(widget.contractId,value.path);
                                    return value;
                                  });

                                  Navigator.pop(context);
                                }
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("من فضلك قم بإضة التوقيع الخاص بك",style: TextStyle(color: Colors.black),)));
                              }
                            }
                          },
                          buttonText: "إرسال",
                          textColor: Colors.white,
                          backgroundColor: contract.data!.first.status != 'requested'? Colors.grey : Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                    onFailure: (state)=> Text("SHIT"),
                  ),
                ],
              ),
                onFailure: (state)=> Center(child: Text("SHIT"))

            )

          ),
        ),
      ),
    );
  }

  List<String> paymentsSystemTxt = [
    "سنوي",
    "نصف سنوي",
    "شهري",
    "ربع سنوي",
  ];

  Widget paymentWidget(index, paymentSystem, yealyprice) {
    return Consumer(
      builder: (context, consumerRef, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * .45,
          child: ListTile(
            title: Text(paymentsSystemTxt[index],
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Color(0xff677294))),
            leading: Radio<PaymentsSystem>(
              value: PaymentsSystem.values[index],
              groupValue: paymentSystem,
              onChanged: (PaymentsSystem? value) {
                if (value != null) {
                  consumerRef.read(paymentsSystemProvider.notifier).state =
                      value;
                  paymentSystemEditingController.text =
                  "الدفعه ${PaymentHelper.getPayment(yealyprice, value)}";
                }
              },
            ),
          ),
        );
      },
    );
  }
}
