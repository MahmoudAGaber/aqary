import 'dart:async';

import 'package:aqary/Views/Home/MapView.dart';
import 'package:aqary/Views/base/custom_text_field.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../ViewModel/LocationViewModel.dart';
import 'EstateOwner.dart';
import 'Notification.dart';
import 'Search/Search.dart';

class Header extends ConsumerStatefulWidget {
  const Header({super.key});

  @override
  ConsumerState<Header> createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<Header> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  List<Marker> markers = [
    Marker(markerId: MarkerId("1"),
        consumeTapEvents: true,
        infoWindow: InfoWindow(title: "Me"))
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var currentLocation = ref.watch(locationProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 20,right: Dimensions.paddingSizeDefault,left: Dimensions.paddingSizeDefault),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "موقعك",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MapView()));
                        },
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).primaryColor,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                      currentLocation != null ?
                      Text(
                        "${currentLocation.placemark!.administrativeArea}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 15),
                        overflow: TextOverflow.clip,
                      ):SizedBox(),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black12)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.share,
                        size: 26,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.paddingSizeDefault,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Notifications()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.notifications_none,
                          size: 26,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: Dimensions.paddingSizeDefault,),
          Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0x70e1f1ce)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text("هل أنت مالك عقار ؟",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18)),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EstateOwner()));
                    },
                    child: Container(
                        width: 60,
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
                            color: Theme.of(context).primaryColor),
                      child: SizedBox(
                        width: 2,height: 10,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                            child: SvgPicture.asset("assets/images/arrow_left_alt.svg",),
                          )),
                    ),
                  ),
                ),
              )
            ],
          ),),
          SizedBox(height: Dimensions.paddingSizeDefault,),
          CustomTextField(
            hintText: 'ابحث عن العقار الذي تريده',
            isIcon: true,
            prefixIconUrl: CupertinoIcons.search,
            isShowPrefixIcon: true,
            inputAction: TextInputAction.search,
            isSearch: true,
            isShowBorder: true,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Search()));
            },
          )
        ],
      ),
    );
  }
}
