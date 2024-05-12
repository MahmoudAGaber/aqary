
import 'dart:async';

import 'package:aqary/Views/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

import '../ViewModel/AuthViewModel.dart';
import '../ViewModel/LocationViewModel.dart';
import '../helper/address_helper.dart';
import 'HomePage.dart';
import 'OnBoarding.dart';



class SplachScreen extends ConsumerStatefulWidget {
  const SplachScreen({super.key});

  @override
  ConsumerState<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends ConsumerState<SplachScreen> {


  Future<void> requestPermissions() async {
    var status = await Permission.locationAlways.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      // Request permissions
      Map<Permission, PermissionStatus> statuses = await [
        Permission.locationAlways,
      ].request();
      if (statuses[Permission.locationAlways]?.isGranted ?? false) {
        // Permission is granted, proceed
        getLocations();
      } else {
        // Handle the case when permission is denied
        _handlePermissionDenied();
      }
    } else if (status.isGranted) {
      // Permission is already granted, proceed
      getLocations();
    }
  }

  void _handlePermissionDenied() {
    // Logic to handle when the user denies the permission
  }

  Future<void> getLocations()async{
    await  ref.watch(estatelocationProvider.notifier).getCurrentEstateLocation();
    await  ref.watch(userLocationProvider.notifier).getCurrentUserLocation();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      var auth =  ref.watch(authStateProvider.future);
      AddressHelper.checkPermission(getLocations);
      Timer(Duration(seconds: 3), () async{


       // requestPermissions();

       auth.then((user) {
          user != null
              ?Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage(page: 0,)))
             : Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

       });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OnBoarding()));


      });
    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/SplashScreen.png"),
            fit: BoxFit.cover
        ),
      ),)
    );
  }
}
