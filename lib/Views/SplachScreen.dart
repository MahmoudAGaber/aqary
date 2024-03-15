
import 'dart:async';

import 'package:aqary/Views/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../ViewModel/AuthViewModel.dart';
import '../ViewModel/LocationViewModel.dart';
import 'HomePage.dart';
import 'OnBoarding.dart';


class SplachScreen extends ConsumerStatefulWidget {
  const SplachScreen({super.key});

  @override
  ConsumerState<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends ConsumerState<SplachScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      var auth =  ref.watch(authStateProvider.future);

      Timer(Duration(seconds: 3), () async{
          await  ref.watch(locationProvider.notifier).getCurrentLocation();

       auth.then((user) {
          user != null
              ?Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()))
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
