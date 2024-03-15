import 'package:aqary/Views/Login.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentPage = 0;

  CarouselController carouselController = CarouselController();

  List<String> images = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=>Login()));
                    },
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.grey[200],
                            fixedSize: Size(80,24)
                        ),
                        child: Text("تخطي", style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 13),)),
                  ),
                  Image.asset("assets/images/logo.png"),

                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 12),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*.5,
                    child: Column(
                      children: [
                        Text("البحث عن أفضل مكان للإقامة بسعر جيد",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        SizedBox(height: Dimensions.paddingSizeSmall,),
                        Text("هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص.",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey),textAlign: TextAlign.center,),
                      ],
                    )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 12),
                  child: Column(
                    children: [
                      Expanded(
                        child: CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount: images.length,
                          options: CarouselOptions(
                            initialPage: _currentPage,
                            height: MediaQuery.of(context).size.height*.65,
                            viewportFraction: 1,
                            enableInfiniteScroll: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentPage = index;
                              });
                            },

                          ),
                          itemBuilder: (context, index, realIndex) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 0,
                                  right:0,
                                  child: Row(
                                    mainAxisAlignment:  _currentPage == 0 ? MainAxisAlignment.center :  MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: List.generate(
                                              images.length,
                                                  (index) => buildIndicator(index),
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.paddingSizeSmall,),
                                          TextButton(
                                            onPressed: () {
                                              carouselController.nextPage();
                                              _currentPage++;
                                              if (_currentPage > images.length-1) {
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex)=>Login()));
                                              }
                                            },
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                padding: EdgeInsets.zero,
                                                backgroundColor: Theme.of(context).primaryColor,
                                                fixedSize: Size(190,54)
                                            ),
                                            child: Text('التالي',style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),),
                                          ),
                                        ],
                                      ),
                                      _currentPage == 0
                                          ? SizedBox(width: 0,)
                                          :Container(
                                        width: 54,
                                        height: 54,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: InkWell(
                                          onTap: (){
                                            if (_currentPage > 0) {
                                                _currentPage--;
                                                carouselController.previousPage();
                                            }
                                          },
                                            child: Icon(Icons.arrow_forward,size: 24,))
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 8.0,
      height: 20.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Theme.of(context).primaryColor : Colors.white,
      ),
    );
  }
}