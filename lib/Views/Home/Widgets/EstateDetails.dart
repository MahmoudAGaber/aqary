

import 'dart:io';

import 'package:aqary/Models/CategoryModel.dart';
import 'package:aqary/Models/RealStateModel.dart';
import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/Views/base/custom_shadow_view.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:aqary/helper/date_converter.dart';
import 'package:aqary/payment_configurations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Models/ChatModel.dart';
import '../../../ViewModel/RealStateViewModel.dart';
import '../../../data/services/FiresbaseServices.dart';
import '../../../helper/Authentication.dart';
import '../../../utill/dimensions.dart';
import '../../Chat/ChatScreen.dart';
import '../../base/custom_button.dart';
import '../../base/custom_imageView.dart';
import '../MapView.dart';
import 'Rent.dart';

class EstateDetails extends ConsumerStatefulWidget {
  String propertyId;

  EstateDetails({super.key, required this.propertyId});

  @override
  ConsumerState<EstateDetails> createState() => _EstateDetailsState();
}

class _EstateDetailsState extends ConsumerState<EstateDetails> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
     await ref.read(RealStateGetOneProvider.notifier).getOneEstate(widget.propertyId);

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   var stateDetails =  ref.watch(RealStateGetOneProvider);
    return Scaffold(
      body: stateDetails.handelState<RealStateModel>(
          onLoading: (state) => Center(child: SizedBox(height:30,width:30,child: CircularProgressIndicator(color: Colors.grey,))),
        onSuccess: (state) {
          var item = stateDetails.data!.data;
          var images = item.images.cast<dynamic>();

          return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height*.62, // Set the height of the header when expanded
                  floating: true,
                  leading: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  actions:[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: CustomShadowView(
                          borderRadius: 50,
                          padding: EdgeInsets.all(8),
                          color: item.isFavorite ? Theme.of(context).primaryColor : Colors.grey,
                          isActive: true,
                          child: Icon(CupertinoIcons.heart_solid,size: 18,)),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        // Add the background image
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomImageView(imagesUrl: images,)));

                          },
                          child:item.images.isEmpty ? SizedBox() :Image.network(
                            item.images.first.path,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, bottom: 16),
                            child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 1.0, end: 0.0),
                              duration: Duration(milliseconds: 500),
                              builder: (BuildContext context, double value,
                                  Widget? child) {
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: List.generate(item.images.length < 3 ? item.images.length : 3, (index) => estateViews(index, item))
                                );
                              },
                            ),
                          ),

                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16, bottom: 16),
                            child: Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child: Center(child: Text("شقه",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Other properties like pinned, floating, elevation, etc.
                  // can be customized as needed
                ),

                SliverFillRemaining(
                  hasScrollBody: false,
                  child: SizedBox(
                    height: 1050,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                              SizedBox(width: 4,),
                              Text("${DateConverter.numberFormat(item.yearPrice)} درهم / سنويا", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor),),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: Dimensions.paddingSizeExtraSmall,
                                  ),
                                  Text(
                                    "${item.country}, ${item.city}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Icon(Icons.share,size: 20,)
                            ],
                          ),
                          SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                          Container(
                            height: 85,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFFF5F4F7)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 16,
                                      ),
                                      SizedBox(width: Dimensions.paddingSizeDefault,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                             item.createdBy['name'] == null || item.createdBy['name'].isEmpty
                                                ?item.createdBy['phone']
                                                :item.createdBy['name'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(fontSize: 15),
                                          ),
                                          Text(
                                            "وكيل عقارات",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: Colors.grey),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: ()async{
                                      String chatRoomId = await FirebaseServices().createChatRoom(AuthService().auth.currentUser!.uid, item.createdBy['firebase_id'], Message().toJson());
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ChatScreen(chatRoomId: chatRoomId,recipientId: item.createdBy['firebase_id'],recipientName: item.createdBy['name']??"",recipientPhone: item.createdBy['phone'],)));
                                    },
                                      child: SvgPicture.asset('assets/images/messageminus.svg'))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                          Row(
                            children: [
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFF5F4F7)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/images/bed.svg"),
                                      SizedBox(width: Dimensions.paddingSizeSmall,),
                                      Text("${item.bedroomsCount} غرفه نوم",style: Theme.of(context).textTheme.bodyMedium,)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.paddingSizeDefault,),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFF5F4F7)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/images/bathroom.svg"),
                                      SizedBox(width: Dimensions.paddingSizeSmall,),
                                      Text("${item.bathroomsCount} حمام",style: Theme.of(context).textTheme.bodyMedium,)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text("المواصفات",style: Theme.of(context).textTheme.titleLarge!),
                              ),
                              SizedBox(height: Dimensions.paddingSizeSmall,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFF5F4F7)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical:Dimensions.paddingSizeDefault ),
                                  child: Text(item.description,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black45),),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text("الموقع",style: Theme.of(context).textTheme.titleLarge!),
                              ),
                              SizedBox(height: Dimensions.paddingSizeSmall,),
                              Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Color(0xFFF5F4F7)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical:Dimensions.paddingSizeSmall ),
                                      child: Icon(Icons.location_on_outlined,size: 18,),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.paddingSizeSmall,),
                                  Flexible(
                                    child: Text(
                                      item.location,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.paddingSizeDefault,),
                              Container(
                                height: 52,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color:Color(0xFFECEDF3))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on,size: 20,color: Colors.grey,),
                                      SizedBox(width: Dimensions.paddingSizeSmall,),
                                      Text("${item.distance!.toStringAsFixed(1)} كم",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor)),
                                      SizedBox(width: 4,),
                                      Text("من موقعك",style: Theme.of(context).textTheme.bodyMedium!),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Dimensions.paddingSizeDefault,),
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 260,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: GoogleMap(
                                          onTap: (v){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> MapView(lat: LatLng(item.lat, item.long),title: 'موقع العقار',isSelected: false,isUserLocation: false,)));
                                          },
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(item.lat,item.long),
                                            zoom: 14.3,
                                          ),
                                          liteModeEnabled: true,
                                          mapType: MapType.terrain,
                                          indoorViewEnabled: false,
                                          mapToolbarEnabled: false,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Container(
                                          height: 35,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Color(0xffF9FAFA)
                                            //borderRadius: BorderRadius.circular(12)
                                          ),
                                          child: Center(child: Text("عرض الموقع علي الخريطه",style: Theme.of(context).textTheme.bodySmall!.copyWith(color:  Color(0xff677294)))),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
        },
        onFailure: (state)=> Text("SHIT")
      ),
      floatingActionButton:Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                    buttonText: "اتصل",
                    height: 48,
                    borderRadius: 12,
                    textColor: Colors.white,
                    onPressed: (){
                      makePhoneCall(stateDetails.data!.data.createdBy['phone']);
                    }
                ),
              ),
              SizedBox(width: Dimensions.paddingSizeDefault,),
              Expanded(
                child: CustomButton(
                    buttonText: "استأجر الأن",
                    height: 48,
                    backgroundColor: Colors.white,
                    textColor: Theme.of(context).primaryColor,
                    borderRadius: 8,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (contex)=>Rent(property: stateDetails.data!.data,)));
                    }
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );

  }
  // List<String> searchImage =[
  //   "assets/images/estate1.png",
  //   "assets/images/estate1.png",
  //   "assets/images/estate1.png",
  //   "assets/images/estate1.png",
  //   "assets/images/estate1.png",
  //   "assets/images/estate1.png",
  // ];

  Widget estateViews(index,item){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            width: 3,
            color: Colors.white,
          ),
          image: DecorationImage(
            image: NetworkImage(item.images[index].path),
            fit: BoxFit.fill,
          ),
        ),
        child: index >= 2 ? Center(child: Text(item.images.length == 3 ? "": "${item.images.length - 3}+",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
        ): SizedBox()
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }
}

