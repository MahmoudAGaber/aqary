

import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/Views/base/custom_shadow_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utill/dimensions.dart';
import '../../base/custom_button.dart';
import '../../base/custom_imageView.dart';
import '../MapView.dart';
import 'Rent.dart';

class EstateDetails extends StatefulWidget {
  const EstateDetails({super.key});

  @override
  State<EstateDetails> createState() => _EstateDetailsState();
}

class _EstateDetailsState extends State<EstateDetails> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.1937, 55.2666),
    zoom: 14.3,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                    color: Theme.of(context).primaryColor,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CustomChatImageView(imageUrl: "assets/images/Shape.png",)));

                    },
                    child: Image.asset(
                      'assets/images/Shape.png',
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
                            children: List.generate(searchImage.length < 3 ? searchImage.length : 3, (index) => estateViews(index))
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
                          Text("شقه للايجار في الشامخه", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                          SizedBox(width: 4,),
                          Text("30,000 درهم / سنويا", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor),),
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
                                "الشامخه, أبوظبي",
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
                                        "احمد محمد",
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
                              SvgPicture.asset('assets/images/messageminus.svg')
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
                                  Text("2 غرفه نوم",style: Theme.of(context).textTheme.bodyMedium,)
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
                                  Text("2 حمام",style: Theme.of(context).textTheme.bodyMedium,)
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
                              child: Text("هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النصهذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black45),),
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
                              Text(
                                "شقه 12675, الشامخه, أبوظبي",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
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
                                  Text("2.5 كم",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor)),
                                  SizedBox(width: 4,),
                                  Text("من موقعك",style: Theme.of(context).textTheme.bodyMedium!),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.paddingSizeDefault,),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: GoogleMap(
                                      onTap: (v){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MapView()));
                                      },
                                      initialCameraPosition: _kGooglePlex ,
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
                      Navigator.push(context, MaterialPageRoute(builder: (contex)=>Rent()));
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
  List<String> searchImage =[
    "assets/images/estate1.png",
    "assets/images/estate1.png",
    "assets/images/estate1.png",
    "assets/images/estate1.png",
    "assets/images/estate1.png",
    "assets/images/estate1.png",
  ];

  Widget estateViews(index){
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
            image: AssetImage(searchImage[index]),
            fit: BoxFit.fill,
          ),
        ),
        child: index >= 2 ? Center(child: Text(searchImage.length == 3 ? "": "${searchImage.length - 3}+",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white,fontWeight: FontWeight.bold),),
        ): SizedBox()
      ),
    );
  }
}
