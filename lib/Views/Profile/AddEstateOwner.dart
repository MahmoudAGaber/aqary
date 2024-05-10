
import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/Models/UserModel.dart';
import 'package:aqary/Views/Home/Home.dart';
import 'package:aqary/Views/HomePage.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../ViewModel/UserViewModel.dart';
import '../../helper/Shimmer/ShimmerWidget.dart';
import '../../utill/dimensions.dart';
import '../base/custom_app_bar.dart';
import '../base/custom_button.dart';
import '../base/custom_dialog.dart';
import 'Settings.dart';

class AddEstateOwner extends ConsumerStatefulWidget {
  const AddEstateOwner({super.key});

  @override
  ConsumerState<AddEstateOwner> createState() => _AddEstateOwnerState();
}

class _AddEstateOwnerState extends ConsumerState<AddEstateOwner> {

 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(UserPropProvider.notifier).getUserProp(UserProp.all);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var userProp = ref.watch(UserPropProvider);
    var addEstateToManage = ref.watch(EstateManagerProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "إضافة مالك عقار",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text("بيانات مالك العقار",style: Theme.of(context).textTheme.titleLarge!),
                    ),
                    SizedBox(height: Dimensions.paddingSizeDefault,),
                    TextFormField(
                      controller: nameEditingController,
                      textDirection: TextDirection.rtl,
                      cursorColor: Colors.grey,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Color(0xFFF9FAFA),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: "الاسم بالكامل",
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
                          return 'قم بادخال الاسم';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: Dimensions.paddingSizeDefault,),
                    TextFormField(
                        controller: phoneEditingController,
                      textDirection: TextDirection.rtl,
                      cursorColor: Colors.grey,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          fillColor: Color(0xFFF9FAFA),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          hintText: "رقم الهاتف",
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
                          return 'قم بادخال رقم الهاتف';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      Text("تحديد العقار",style: Theme.of(context).textTheme.titleLarge!),
                    ],
                  ),

                ),
                SizedBox(height: Dimensions.paddingSizeDefault,),
                userProp.handelState<List<RealStateModel>>(
                    onLoading: (state) => SizedBox(
                        height: MediaQuery.of(context).size.height*.6,
                        child: ShimmerList("Grid")),
                  onSuccess:(state)=> GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items in each row
                          mainAxisSpacing: 2.0, // spacing between rows
                          crossAxisSpacing: 2.0, // spacing between columns
                          mainAxisExtent: 250
                      ),
                      shrinkWrap: true,
                      itemCount: userProp.data!.length,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemBuilder: (context,index){
                        var item = userProp.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 260,
                                child: Card(
                                  color: ref.watch(estateSelectionProvider(index)) ? Theme.of(context).primaryColor:Colors.white,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          ref.read(estateSelectionProvider(index).notifier).state =  !ref.read(estateSelectionProvider(index).notifier).state;
                                          ref.read(EstateManagerProvider.notifier).addEstate(item, ref.watch(estateSelectionProvider(index)));
                                          print(ref.watch(estateSelectionProvider(index)));

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            child: item.images.isEmpty?Container( height: 169,color: Colors.grey,)
                                                :Image.network(
                                             item.images.first.path,
                                              height: 169,
                                              width: 260,
                                              fit: BoxFit.cover ,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 3),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(item.title,
                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: ref.watch(estateSelectionProvider(index)) ? Colors.white : Colors.black)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 18,
                                right: 18,
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Stack(
                                    children: [
                                      Center(child: Container(width: 25,height:25,
                                        decoration: BoxDecoration(color: ref.watch(estateSelectionProvider(index)) ? Theme.of(context).primaryColor: Colors.grey,borderRadius: BorderRadius.circular(50)),)),
                                      Center(child: Text("✓",style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),)),

                                    ],
                                  ),),
                              ),
                            ],
                          ),
                        );
                      }),
                  onFailure: (state) =>Text("SHIT")
                ),
                SizedBox(height: 60,)
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: CustomButton(
              buttonText: "إضافة",
              height: 48,
              borderRadius: 12,
              textColor: Colors.white,
              onPressed: (){
                if(addEstateToManage.isNotEmpty){
                  List<String> propsId = [];
                  addEstateToManage.forEach((element) {propsId.add(element.id!);});
                  if(_formKey.currentState!.validate()){
                    ref.read(EstateManagerProvider.notifier).addEstateToManage(
                        ManagerModel(
                            phone: phoneEditingController.text,
                            name: nameEditingController.text,
                            properties: propsId))
;                    showAnimatedDialog(
                        context, dismissible: false, housingOfficalAdded()
                    );
                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("قم بتحديد العقار",style: TextStyle(color: Colors.black),)));
                }

              }
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  List<String> searchImage =[
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",

  ];

  Widget housingOfficalAdded(){
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
                Text('تم إضافة الوسيط بنجاح !',
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
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext? context) {
                        if (context != null) {
                          return Homepage(page: 4);
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
