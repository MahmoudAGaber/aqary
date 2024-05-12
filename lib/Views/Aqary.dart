

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
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Aqary extends ConsumerStatefulWidget {
  const Aqary({super.key});

  @override
  ConsumerState<Aqary> createState() => _AqaryState();
}

class _AqaryState extends ConsumerState<Aqary>  with SingleTickerProviderStateMixin{
  bool isOwner = true;
  SampleItem? selectedItem;
  TabController? tabController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      tabController = TabController(length: 2, vsync: this);
      ref.read(ManagedEstatesProvider.notifier).getManagedEstate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var managedEstates = ref.watch(ManagedEstatesProvider);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("عقارتي",style: TextStyle(color: Colors.white,fontSize: 20),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: TabBar(
          splashBorderRadius: BorderRadius.circular(12),
              labelColor: Colors.white,
              controller: tabController,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              indicatorColor: Theme.of(context).primaryColor,
              tabs: [
            Tab(text: "مالك عقار",),
            Tab(text: "مستأجر",),
          ])
        ),
        body: TabBarView(controller: tabController,
            children: [
              SafeArea(
                bottom: true,
                minimum: EdgeInsets.only(bottom: 60),
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: SingleChildScrollView(
                      child: managedEstates.handelState(
                          onLoading: (state)=> Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Center(child: SizedBox(height:25,width:25,child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)),),
                          ),
                          onSuccess: (state)=> Column(
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
                                    managedEstates.data!.manage.isNotEmpty
                                        ?  ListView.builder(
                                      itemCount: managedEstates.data!.manage.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index){
                                        var item = managedEstates.data!.manage[index];
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border(top: BorderSide(color: Colors.grey))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 6,bottom: 6,right: 6),
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
                                                              Icon(Icons.view_list_outlined ,size: 18,),
                                                              SizedBox(width: 6,),
                                                              Text('معاينة العقد',style: TextStyle(color: Colors.black,fontSize: 15),),
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
                                                         PopupMenuItem<SampleItem>(
                                                          value: SampleItem.itemThree,
                                                          child: Row(
                                                            children: [
                                                              Icon(CupertinoIcons.delete ,size: 18,),
                                                              SizedBox(width: 8,),
                                                              Text('حذف',style: TextStyle(color: Colors.black,fontSize: 15),),

                                                            ],
                                                          ),
                                                           onTap: (){
                                                            ref.read(ManagedEstatesProvider.notifier).deleteManagedEstate(item.contractId);
                                                           },
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
                                    )
                                        : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 25),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 185,
                                                width: 185,
                                                child: Stack(
                                                  children: [
                                                    SvgPicture.asset("assets/images/Ellipse2.svg",colorFilter: ColorFilter.linearToSrgbGamma(),),
                                                    Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),)),
                                                    Center(child: SvgPicture.asset("assets/images/aqary.svg",height: 30,width: 30,color: Theme.of(context).primaryColor,)),
                                                    Positioned(
                                                      top: 48,
                                                      right: 50,
                                                      child: Text('Z',
                                                        style: TextStyle(
                                                            color: Theme.of(context).primaryColor,
                                                            fontSize: Dimensions.fontSizeExtraLarge,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 65,
                                                      right: 65,
                                                      child: Text('Z',
                                                        style: TextStyle(
                                                            color: Theme.of(context).primaryColor,
                                                            fontSize: Dimensions.fontSizeDefault,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    )

                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text("لا يوجد عقارات",
                                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),overflow: TextOverflow.clip,),
                                                  SizedBox(height: Dimensions.paddingSizeSmall,),
                                                  Text("لا يوجد عقارات لإدارتها في الوقت الحالي",
                                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey,overflow: TextOverflow.clip,))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                          child: managedEstates.data!.manage.isNotEmpty
                                              ? Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 6),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: Text("${managedEstates.data!.manage.length}",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).primaryColor),),
                                                ),
                                                Flexible(
                                                    flex: 4,
                                                    child: Center(child: Text(DateConverter.numberFormat(ref.watch(ManagedEstatesProvider.notifier).rentAmount(managedEstates.data!.manage)).toString(),style: Theme.of(context).textTheme.titleSmall,))),
                                                Flexible(
                                                    flex: 3,
                                                    child: Center(child: Text(DateConverter.numberFormat(ref.watch(ManagedEstatesProvider.notifier).deservedAmount(managedEstates.data!.manage)).toString(),style: Theme.of(context).textTheme.titleSmall,))),
                                                Flexible(
                                                    flex: 3,
                                                    child: Center(child: Text(DateConverter.numberFormat(ref.watch(ManagedEstatesProvider.notifier).paidAmount(managedEstates.data!.manage)).toString(),style: Theme.of(context).textTheme.titleSmall,))),
                                              ],
                                            ),
                                          )
                                              :SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.paddingSizeLarge,)
                            ],
                          ),
                          onFailure: (state)=> Text("SHIT")
                      )

                  ),
                ),
              ),
              SafeArea(child: managedEstates.handelState(
                  onLoading: (state)=> Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),),),
                  onSuccess: (state)=>  managedEstates.data!.renter.isNotEmpty
                      ?ListView.builder(
                      shrinkWrap: true,
                      itemCount: managedEstates.data!.renter.length,
                      reverse: true,
                      itemBuilder: (context, index){
                        var item = managedEstates.data!.renter[index];
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
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("اسم العقار",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                          Text(item.propertyName,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),

                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("عنوان العقار",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold,overflow: TextOverflow.clip),),
                                          SizedBox(width: MediaQuery.of(context).size.width*.3,),
                                          Flexible(child: Text(item.propertyLocation,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826)),)),

                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("مده الإيجار",style:Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                          Text("من  ${DateConverter.estimatedDate(item.from)}   الي   ${DateConverter.estimatedDate(item.to.subtract(Duration(days: 1)))}",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),

                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("المبلغ المستحق",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                          Text("${item.rent}",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),

                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("المبلغ المدفوع",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                          Text("${item.paid}",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),

                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("طريقه الدفع",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
                                          Text("${item.paymentType}",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Color(0xFF121826),),),

                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("الحاله",style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),),
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
                                      ),





                                    ]
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      :Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 185,
                              width: 185,
                              child: Stack(
                                children: [
                                  SvgPicture.asset("assets/images/Ellipse2.svg",colorFilter: ColorFilter.linearToSrgbGamma(),),
                                  Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),)),
                                  Center(child: SvgPicture.asset("assets/images/aqary.svg",height: 30,width: 30,color: Theme.of(context).primaryColor,)),
                                  Positioned(
                                    top: 48,
                                    right: 50,
                                    child: Text('Z',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: Dimensions.fontSizeExtraLarge,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 65,
                                    right: 65,
                                    child: Text('Z',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: Dimensions.fontSizeDefault,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text("لا يوجد عقارات",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),overflow: TextOverflow.clip,),
                                SizedBox(height: Dimensions.paddingSizeSmall,),
                                Text("لا يوجد عقارات نشطه في الوقت الحالي",
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey,overflow: TextOverflow.clip,))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  onFailure: (state)=> Text("SHIT")
              ))
            ]
        )
      ),
    );

  }

  List s= ["30,000","20,000","10,000","5,000","200,000","10,000","5,000","200,000","200,000","200,000","200,000","200,000"];
  List x= ["1.0,000","2,000","1,000","55,000","3,000","15,000","500,000","20,000","200,000","200,000","200,000","200,000"];
  List y= ["1.0,000","2,000","1,000","5,000","3,000","1,000","5,000","20,000","200,000","200,000","200,000","200,000"];
}
enum SampleItem { itemOne, itemTwo, itemThree }
