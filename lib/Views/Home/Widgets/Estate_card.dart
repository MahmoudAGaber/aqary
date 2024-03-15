

import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'EstateDetails.dart';

class EstateCard extends StatefulWidget {
  const EstateCard({super.key});

  @override
  State<EstateCard> createState() => _EstateCardState();
}

class _EstateCardState extends State<EstateCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*.28,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: searchImage.length,
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(),
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Container(
                width: 260,
                child: Card(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EstateDetails()));

                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              child: Image.asset(
                                searchImage[index],
                                width: 232,
                                height: 144,
                                fit: BoxFit.cover ,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("شقه للايجار في الشامخه", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
                                SizedBox(height: 4,),
                                Text("30,000 درهم / سنويا", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize:10, color: Theme.of(context).primaryColor),),
                                SizedBox(height: 4,),
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
                                )

                              ],
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 65,
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
