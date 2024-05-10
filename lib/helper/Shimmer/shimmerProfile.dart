import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../utill/dimensions.dart';

class shimmerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ShimmerProfileLayout(),
        ));
  }
}

class ShimmerProfileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(50)),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                  ),
                )),
          ),
        ),
        SizedBox(height: Dimensions.paddingSizeDefault,),
        Container(
          height: 10,
          width: 150,
          color: Colors.grey,
        ),
        SizedBox(height: 6,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 10, width: 120, color: Colors.grey,),
          ],
        ),
        SizedBox(height: Dimensions.paddingSizeLarge,),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .9,
              height: 45,
              decoration: ShapeDecoration(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
      ],
    );
  }
}
