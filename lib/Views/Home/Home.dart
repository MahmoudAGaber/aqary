

import 'dart:async';

import 'package:aqary/ViewModel/BannerViewModel.dart';
import 'package:aqary/Views/Home/Widgets/Header.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../ViewModel/CategoryViewModel.dart';
import 'Widgets/AddReal_estate.dart';
import 'Widgets/Banner.dart';
import 'Widgets/EstateNearYou.dart';
import 'Widgets/Estate_card.dart';
import 'Widgets/Estate_filter.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {


  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(bannerProvider.notifier).getBanners();
      ref.watch(categoryProvider.notifier).getCategories();

    });
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
              EstateNearYou()
            ],
          ),
        ),
      ),
    );
  }
}
