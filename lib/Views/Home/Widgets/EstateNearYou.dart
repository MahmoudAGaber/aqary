

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utill/dimensions.dart';
import 'EstateDetails.dart';

class EstateNearYou extends StatefulWidget {
  const EstateNearYou({super.key});

  @override
  State<EstateNearYou> createState() => _EstateNearYouState();
}

class _EstateNearYouState extends State<EstateNearYou> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("بالقرب منك", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18)),
                InkWell(
                    child: Text("المزيد",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColor))),
              ],
            ),
          ),
         SizedBox(height: Dimensions.paddingSizeSmall,),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: searchImage.length,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    height: 112,
                    child: Card(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                           // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EstateDetails()));

                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: Image.asset(
                                      searchImage[index],
                                      width: 132,
                                      height: 88,
                                      fit: BoxFit.cover ,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("شقه للايجار في الشامخه", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
                                    SizedBox(height: 3,),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: Dimensions.paddingSizeExtraSmall,
                                        ),
                                        Text(
                                          "الشامخه, أبوظبي",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 3,),
                                    Text("30,000 درهم / سنويا", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize:10, color: Theme.of(context).primaryColor),),



                                  ],
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 10,
                            left: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x19121212),
                                    blurRadius: 10,
                                    offset: Offset(4, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SvgPicture.asset("assets/images/heart2.svg",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ],
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

  ];
}
