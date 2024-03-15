

import 'dart:async';

import 'package:aqary/Views/Home/Widgets/Header.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Widgets/AddReal_estate.dart';
import 'Widgets/Banner.dart';
import 'Widgets/EstateNearYou.dart';
import 'Widgets/Estate_card.dart';
import 'Widgets/Estate_filter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        minimum: EdgeInsets.only(bottom: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: Dimensions.paddingSizeDefault,),
              Banners(),
              SizedBox(height: Dimensions.paddingSizeDefault,),
              AddRealEstate(),
              SizedBox(height: Dimensions.paddingSizeDefault,),
              EstateFilter(),
              SizedBox(height: Dimensions.paddingSizeDefault,),
              EstateCard(),
              SizedBox(height: Dimensions.paddingSizeDefault,),
              EstateNearYou()
            ],
          ),
        ),
      ),
    );
  }
}
