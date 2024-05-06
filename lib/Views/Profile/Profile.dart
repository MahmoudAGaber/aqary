

import 'dart:io';

import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/Models/UserModel.dart';
import 'package:aqary/ViewModel/UserViewModel.dart';
import 'package:aqary/Views/Home/Widgets/EstateDetails.dart';
import 'package:aqary/Views/Profile/EditProfile.dart';
import 'package:aqary/Views/Profile/EditRealState.dart';
import 'package:aqary/Views/Profile/Settings.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../base/custom_app_bar.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(UserProvider.notifier).getUserInfo();
      ref.read(UserPropProvider.notifier).getUserProp(UserProp.all);

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(UserProvider);
    var userProp = ref.watch(UserPropProvider);
    var userPropSelection = ref.watch(userPropSelectionProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "الصفحه الشخصيه",
        isBackButtonExist: false,
        leadingView: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Settings()));
          },
            child: Icon(Icons.settings,color: Colors.black,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: user.handelState<UserModel>(
            onLoading: (state) => Center(child: SizedBox(height:30,width:30,child: CircularProgressIndicator(color: Colors.grey,))),
            onSuccess: (state)=> Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 100,width: 100,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: user.data!.pic != ''
                                        ?Image.network(user.data!.pic,fit: BoxFit.cover,height: 100,width: 100,)
                                :SizedBox(child: CircleAvatar(radius: 50,backgroundColor: Colors.grey,),)),
                              ),
                              Positioned(
                                bottom: 2,
                                right: 2,
                                child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfile(userName: user.data!.name,)));
                                    },
                                    child: Container(
                                        height: 30,width: 30,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context).primaryColor,
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Icon(Icons.edit,color: Colors.white,size: 18,))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.paddingSizeDefault,),
                        Text(user.data!.name, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600)),
                        SizedBox(height: 4,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              user.data!.phone,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 10),
                              overflow: TextOverflow.clip,
                              softWrap: true,
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.paddingSizeLarge,),
                        Container(
                          width: MediaQuery.of(context).size.width*.9,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF5F4F7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                    onTap: (){
                                      ref.read(userPropSelectionProvider.notifier).state = UserProp.available;
                                      ref.read(UserPropProvider.notifier).getUserProp(UserProp.available);
                                  },
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: userPropSelection == UserProp.available ? Theme.of(context).primaryColor:null,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                                      child: Text(
                                          'العقارات المتوفره',
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color:userPropSelection == UserProp.available ? Colors.white:Colors.black)
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                InkWell(
                                  onTap: (){
                                    ref.read(userPropSelectionProvider.notifier).state = UserProp.notAvailable;

                                    ref.read(UserPropProvider.notifier).getUserProp(UserProp.notAvailable);
                                  },
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: userPropSelection == UserProp.notAvailable ? Theme.of(context).primaryColor:null,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                                      child: Text(
                                          'العقارات المؤجره',
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color:userPropSelection == UserProp.notAvailable ? Colors.white:Colors.black)
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                InkWell(
                                  onTap: (){
                                    ref.read(userPropSelectionProvider.notifier).state = UserProp.all;
                                    ref.read(UserPropProvider.notifier).getUserProp(UserProp.all);
                                  },
                                  child: Container(
                                    decoration: ShapeDecoration(
                                      color: userPropSelection == UserProp.all ? Theme.of(context).primaryColor:null,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                                      child: Text(
                                          'الكل',
                                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color:userPropSelection == UserProp.all ? Colors.white:Colors.black)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ),
                        SizedBox(height: Dimensions.paddingSizeDefault,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*.9,
                          child: userProp.handelState<List<RealStateModel>>(
                              onLoading: (state) => Center(child: SizedBox(height:30,width:30,child: CircularProgressIndicator(color: Colors.grey,))),
                            onSuccess: (state)=> GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // number of items in each row
                                    mainAxisSpacing: 2.0, // spacing between rows
                                    crossAxisSpacing: 2.0, // spacing between columns
                                    mainAxisExtent: 270
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
                                        Card(
                                          color: Colors.white,
                                          elevation: 2,
                                          surfaceTintColor: Colors.white,
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: (){},
                                                child: Stack(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: InkWell(
                                                        onTap: (){
                                                          Navigator.push(context, MaterialPageRoute(builder: (contex)=> EstateDetails(propertyId: item.id!)));
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                                          child: item.images.isEmpty ? Container(height: 190,
                                                            width: 220,color: Colors.grey,)
                                                              :Image.network(
                                                            item.images.first.path,
                                                            height: 190,
                                                            width: 220,
                                                            fit: BoxFit.cover ,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 18,
                                                      right: 18,
                                                      child: Container(
                                                        decoration: BoxDecoration(color:  Theme.of(context).primaryColor,
                                                          borderRadius: BorderRadius.circular(12),),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                                          child: Text("${item.yearPrice} / سنويا ", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize:10, color: Colors.white),),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 2),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(item.title,
                                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black)),
                                                    SizedBox(height: 4,),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.location_on,
                                                          color: Theme.of(context).primaryColor,
                                                          size: 14,
                                                        ),
                                                        SizedBox(
                                                          width: Dimensions.paddingSizeExtraSmall,
                                                        ),
                                                        Text(
                                                          "${item.country}, ${item.city}",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall!
                                                              .copyWith(fontSize: 10,color: Theme.of(context).primaryColor),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 18,
                                          left: 18,
                                          child: SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: Stack(
                                              children: [
                                                Center(child: Container(width: 25,height:25,
                                                  decoration: BoxDecoration(color:  Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.circular(50)),)),
                                                Center(child: InkWell(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                                      => EditEstate(realStateModel:item)));
                                                    },
                                                    child: Icon(Icons.edit,color: Colors.white,size: 14,)),),

                                              ],
                                            ),),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            onFailure: (state)=> Text("....")
                          )
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
              onFailure: (state) => Center(child: Container(child: Text("")),)
          ),
        ),
      ),
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
}
