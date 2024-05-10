import 'package:aqary/Models/BanerModel.dart';
import 'package:aqary/ViewModel/BannerViewModel.dart';
import 'package:aqary/data/StateModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../helper/Shimmer/ShimmerWidget.dart';

class Banners extends ConsumerStatefulWidget {
   Banners({super.key});

  @override
  ConsumerState<Banners> createState() => _BannersState();
}

class _BannersState extends ConsumerState<Banners> {
   int _currentPage = 0;

  List<String> images = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
  ];

  @override
  Widget build(BuildContext context) {
    var banners = ref.watch(bannerProvider);
    return banners.handelState<BannerModel>(
        onLoading: (state) => SizedBox(
            height: 120,
            child: ShimmerList("Banner")),
       onSuccess: (state) => CarouselSlider.builder(
         itemCount:  banners.data!.length,
         options: CarouselOptions(
           initialPage: _currentPage,
           autoPlay: true,
           autoPlayInterval: Duration(seconds: 8),
           height: 120,
           viewportFraction: .82,
           enableInfiniteScroll: true,

         ),
         itemBuilder: (context, index, realIndex) {
           return Padding(
             padding: const EdgeInsets.symmetric(horizontal: 6),
             child: SizedBox(
               width: MediaQuery.of(context).size.width,
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(10),
                 child: Image.network(
                   banners.data![index].image,
                   fit: BoxFit.cover,
                 ),
               ),
             ),
           );
         },
       ),
        onFailure: (state) => Center(child: Container(child: Text("shit")),)

    );
  }
}
