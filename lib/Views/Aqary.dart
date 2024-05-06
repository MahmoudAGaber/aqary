

import 'package:aqary/ViewModel/UserViewModel.dart';
import 'package:aqary/Views/Home/Widgets/AddEstate/AddEstate.dart';
import 'package:aqary/Views/Home/Widgets/EstateDetails.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/Views/base/custom_button.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:aqary/helper/date_converter.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Aqary extends ConsumerStatefulWidget {
  const Aqary({super.key});

  @override
  ConsumerState<Aqary> createState() => _AqaryState();
}

class _AqaryState extends ConsumerState<Aqary> {
  bool isOwner = true;
  SampleItem? selectedItem;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(ManagedEstatesProvider.notifier).getManagedEstate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var managedEstates = ref.watch(ManagedEstatesProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "عقاراتي",
        isBackButtonExist: false,
      ),
      body: SafeArea(
        bottom: true,
        minimum: EdgeInsets.only(bottom: 60),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SingleChildScrollView(
            child: managedEstates.handelState(
                onLoading: (state)=> Center(child: CircularProgressIndicator(),),
                onSuccess: (state)=> isOwner
                  ?Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomButton(
                      width: 160,
                      buttonText: "إضافه عقار",
                      textColor: Colors.white,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddEstate()));
                      }),
                  SizedBox(height: Dimensions.paddingSizeLarge,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor
                        )
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 6),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(child: Text("رقم الشقه",style: Theme.of(context).textTheme.titleSmall,)),
                              Center(child: Text("مبلغ الايجار",style: Theme.of(context).textTheme.titleSmall,)),
                              Center(child: Text("المبلغ المستحق",style: Theme.of(context).textTheme.titleSmall,)),
                              Center(child: Text("المبلغ المدفوع",style: Theme.of(context).textTheme.titleSmall,)),
                              SizedBox(width: 20,)
                            ],
                          ),

                        ),
                        ListView.builder(
                          itemCount: managedEstates.data!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            var item = managedEstates.data![index];
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border(top: BorderSide(color: Colors.grey))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 12,bottom: 12,right: 6),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EstateDetails(propertyId: item.id)));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Theme.of(context).primaryColor,
                                            child: Text("${index+1}",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),)),
                                      ),
                                      Flexible(
                                          flex: 4,
                                          child: Center(child: Text("${DateConverter.numberFormat(item.rent)}",style: Theme.of(context).textTheme.titleSmall,))),
                                      Flexible(
                                          flex: 3,
                                          child: Center(child: Text("${DateConverter.numberFormat(item.monthly)}",style: Theme.of(context).textTheme.titleSmall,))),
                                      Flexible(
                                          flex: 3,
                                          child: Center(child: Text("${DateConverter.numberFormat(item.paid)}",style: Theme.of(context).textTheme.titleSmall,))),
                                      Flexible(
                                        flex: 2,
                                        child:PopupMenuButton<SampleItem>(
                                          initialValue: selectedItem,
                                          surfaceTintColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              side: BorderSide(color: Theme.of(context).primaryColor)
                                          ),
                                          onSelected: (SampleItem item) {
                                            setState(() {
                                              selectedItem = item;
                                            });
                                          },

                                          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
                                            const PopupMenuItem<SampleItem>(
                                              value: SampleItem.itemOne,
                                              child: Row(
                                                children: [
                                                  Icon(CupertinoIcons.add_circled_solid ,size: 18,),
                                                  SizedBox(width: 6,),
                                                  Text('إنشاء عقد إيجار',style: TextStyle(color: Colors.black,fontSize: 15),),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuItem<SampleItem>(
                                              value: SampleItem.itemTwo,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit ,size: 18,),
                                                  SizedBox(width: 8,),
                                                  Text('تعديل',style: TextStyle(color: Colors.black,fontSize: 15),),
                                                ],
                                              ),
                                            ),
                                            const PopupMenuItem<SampleItem>(
                                              value: SampleItem.itemThree,
                                              child: Row(
                                                children: [
                                                  Icon(CupertinoIcons.delete ,size: 18,),
                                                  SizedBox(width: 8,),
                                                  Text('حذف',style: TextStyle(color: Colors.black,fontSize: 15),),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: Dimensions.paddingSizeLarge,),
                        Column(
                          children: [
                            Text("المجـــمـــوع",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).primaryColor),),
                            SizedBox(height: Dimensions.paddingSizeDefault,),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(top: BorderSide(color: Theme.of(context).primaryColor))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: Text("${managedEstates.data!.length}",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor),),
                                    ),
                                    Flexible(
                                        flex: 4,
                                        child: Center(child: Text(DateConverter.numberFormat(ref.watch(ManagedEstatesProvider.notifier).rentAmount(managedEstates.data!)).toString(),style: Theme.of(context).textTheme.titleSmall,))),
                                    Flexible(
                                        flex: 3,
                                        child: Center(child: Text(DateConverter.numberFormat(ref.watch(ManagedEstatesProvider.notifier).deservedAmount(managedEstates.data!)).toString(),style: Theme.of(context).textTheme.titleSmall,))),
                                    Flexible(
                                        flex: 3,
                                        child: Center(child: Text(DateConverter.numberFormat(ref.watch(ManagedEstatesProvider.notifier).paidAmount(managedEstates.data!)).toString(),style: Theme.of(context).textTheme.titleSmall,))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.paddingSizeLarge,)
                ],
              )
                  : ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Card(
                        shadowColor: Theme.of(context).primaryColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(.5))
                        ),
                        surfaceTintColor: Colors.white,

                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            height: 243,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("اسم العقار",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                    Text("عنوان العقار",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                    Text("مده الإيجار",style:Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                    Text("المبلغ المدفوع",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                    Text("المبلغ المتبقي",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                    Text("طريقه الدفع",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                    Text("الحاله",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("شقه للايجار في الشامخه",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),
                                    Text("شقه 12675, الشامخه, أبوظبي",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),
                                    Text("من 12 يناير الي 22 يناير 2023",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),
                                    Text("12,000",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),
                                    Text("18,000",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),
                                    Text("تحويل بنكي",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),
                                    Container(
                                      height: 28,
                                      width: 72,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor.withOpacity(.1),
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child:Center(child: Text("نشط",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor,),)),

                                    )


                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                onFailure: (state)=> Text("SHIT")
            )

          ),
        ),
      ),
    );

  }

  List s= ["30,000","20,000","10,000","5,000","200,000","10,000","5,000","200,000","200,000","200,000","200,000","200,000"];
  List x= ["1.0,000","2,000","1,000","55,000","3,000","15,000","500,000","20,000","200,000","200,000","200,000","200,000"];
  List y= ["1.0,000","2,000","1,000","5,000","3,000","1,000","5,000","20,000","200,000","200,000","200,000","200,000"];
}
enum SampleItem { itemOne, itemTwo, itemThree }
