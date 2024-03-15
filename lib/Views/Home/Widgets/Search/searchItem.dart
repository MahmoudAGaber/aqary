

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utill/dimensions.dart';
import '../EstateDetails.dart';

class SearchItem extends StatelessWidget {
   SearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>EstateDetails()));

                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/estate1.png",
                              width: 154,
                              height: 122,
                              fit: BoxFit.cover ,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("شقه للايجار في الشامخه", style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600)),
                              Row(
                                children: [
                                  Text("1", style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                                  SizedBox(width: 4,),
                                  SvgPicture.asset("assets/images/bathroom.svg",color: Colors.grey,height: 16,),
                                  SizedBox(width: Dimensions.paddingSizeDefault,),
                                  Text("2", style: Theme.of(context).textTheme.bodySmall!.copyWith()),
                                  SizedBox(width: 4,),
                                  SvgPicture.asset("assets/images/bed.svg",color: Colors.grey,height: 16,),

                                ],
                              ),
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
        });
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
