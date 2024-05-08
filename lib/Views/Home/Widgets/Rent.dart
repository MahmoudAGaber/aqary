import 'dart:io';

import 'package:aqary/Models/ContractModel.dart';
import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/ViewModel/RealStateViewModel.dart';
import 'package:aqary/Views/Home/Widgets/SignaturePad.dart';
import 'package:aqary/Views/PdfViewer.dart';
import 'package:aqary/Views/base/custom_button.dart';
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

class Rent extends ConsumerStatefulWidget {
  RealStateModel property;
  Rent({super.key, required this.property});

  @override
  ConsumerState<Rent> createState() => _RentState();
}

class _RentState extends ConsumerState<Rent> {
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      todayDate = DateConverter.slotDate(DateTime.now());
      ownerEstateEditingController.text = widget.property.createdBy['name'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var paymentSystem = ref.watch(paymentsSystemProvider);
    var paymentType = ref.watch(paymentTypeProvider);
    var signature = ref.watch(signatureProvider);
    print(signature);
    paymentSystemEditingController.text =
    "الدفعة ${PaymentHelper.getPayment(DateConverter.numberFormat(widget.property.yearPrice), paymentSystem)}";

    return Scaffold(
      appBar: CustomAppBar(
        title: "استأجر الان",
        isCenter: true,
        isBackButtonExist: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Form(
            key: _formKey,
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EstateDetails(
                                          propertyId: widget.property.id!,
                                        )));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: widget.property.images.isEmpty
                                ? SizedBox()
                                :Image.network(
                              widget.property.images.first.path,
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
                              Text(widget.property.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontWeight: FontWeight.w600)),
                              Row(
                                children: [
                                  Text(
                                      widget.property.bathroomsCount.toString(),
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
                                  Text(widget.property.bedroomsCount.toString(),
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
                                    "${widget.property.city}, ${widget.property.country}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 10),
                                  ),
                                ],
                              ),
                              Text(
                                "${DateConverter.numberFormat(widget.property.yearPrice)} درهم / سنويا",
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
                            enabled: false,
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
                                hintText: "من",
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
                                hintText: "إلي",
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
                SizedBox(
                  height: Dimensions.paddingSizeLarge,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text("نظام الدفعات",
                          style: Theme.of(context).textTheme.titleLarge!),
                    ),
                    SizedBox(
                      height: Dimensions.paddingSizeSmall,
                    ),
                    Wrap(
                        crossAxisAlignment: WrapCrossAlignment.end,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                            paymentsSystemTxt.length,
                            (index) => paymentWidget(index, paymentSystem,
                                widget.property.yearPrice))),
                  ],
                ),
                SizedBox(
                  height: Dimensions.paddingSizeDefault,
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
                              ref.read(paymentTypeProvider.notifier).state =
                                  PaymentType.cash;
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
                                                color: paymentType == PaymentType.cash
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
                              ref.read(paymentTypeProvider.notifier).state =
                                  PaymentType.bank;
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
                            var rentPeriod = "${calculateMonthsBetween(fromDateEditingController.text, toDateEditingController.text)}  شهر";
                           File file =  await PdfInvoiceApi.generate(
                                signature: ref,
                                todayDate: todayDate!,
                                from: fromDateEditingController.text,
                                to: toDateEditingController.text,
                                rentPeriod: rentPeriod,
                                location: widget.property.location,
                                ownerName: ownerEstateEditingController.text,
                                renterName: renterEstateEditingController.text,
                                titleRent: "${widget.property.title}",
                                payment: paymentSystemEditingController.text,
                                notes: noteEditingController.text,
                                isOwner: false,
                                paymentStyle:
                                    PaymentHelper.getArabicPaymentStyle(
                                        paymentSystem));

                           print("TestContractFIle${file.path}");

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfViewer()));
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
                    if(signature.data!.isNotEmpty || signature.data != null) {
                      if (_formKey.currentState!.validate()) {
                        var rentPeriod = "${calculateMonthsBetween(fromDateEditingController.text, toDateEditingController.text)}  شهر";
                        File file =  await PdfInvoiceApi.generate(
                            signature: ref,
                            todayDate: todayDate!,
                            from: fromDateEditingController.text,
                            to: toDateEditingController.text,
                            rentPeriod: rentPeriod,
                            location: widget.property.location,
                            ownerName: ownerEstateEditingController.text,
                            renterName: renterEstateEditingController.text,
                            titleRent: "${widget.property.title}",
                            payment: paymentSystemEditingController.text,
                            notes: noteEditingController.text,
                            isOwner: false,

                            paymentStyle: PaymentHelper.getArabicPaymentStyle(paymentSystem)).then((value){
                          ref.read(ContractProvider.notifier).sentContract(
                              ContractModel(
                                  value,
                                  fromDateEditingController.text,
                                  toDateEditingController.text,
                                  rentPeriod,
                                  paymentSystemEditingController.text.split(" ")[1],
                                  paymentType.name,
                                  noteEditingController.text),
                              widget.property.id);
                          return value;
                        });

                        Navigator.pop(context);
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("من فضلك قم بإضة التوقيع الخاص بك",style: TextStyle(color: Colors.black),)));
                    }
                  },
                  buttonText: "إرسال",
                  textColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                )
              ],
            ),
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
