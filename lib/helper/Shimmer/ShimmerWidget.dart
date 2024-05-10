import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  String type;
  ShimmerList(this.type);
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 1000;

    return type == "Grid"
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row
                mainAxisSpacing: 2.0, // spacing between rows
                crossAxisSpacing: 2.0, // spacing between columns
                mainAxisExtent: 250),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              offset += 5;
              time = 800 + offset;

              print(time);

              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Shimmer.fromColors(
                    highlightColor: Colors.white,
                    baseColor: Colors.grey[350]!,
                    child: ShimmerLayout("Grid"),
                    period: Duration(milliseconds: time),
                  ));
            },
          )
        : type == "List"
            ? ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  offset += 5;
                  time = 800 + offset;

                  print(time);

                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: Colors.grey[350]!,
                        child: ShimmerLayout("List"),
                        period: Duration(milliseconds: time),
                      ));
                })
            : type == "Banner"
                ? CarouselSlider.builder(
                    itemCount: 10,
                    options: CarouselOptions(
                      initialPage: 4,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 8),
                      height: 120,
                      viewportFraction: .82,
                      enableInfiniteScroll: true,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Shimmer.fromColors(
                            highlightColor: Colors.white,
                            baseColor: Colors.grey[350]!,
                            child: ShimmerLayout("Banner"),
                            period: Duration(milliseconds: time),
                          ));
                    },
                  )
                : SizedBox();
  }
}

class ShimmerLayout extends StatelessWidget {
  String type;
  ShimmerLayout(this.type);

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * .6;
    double containerHeight = 15;

    return type == "Grid"
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: SizedBox(
              child: Card(),
            ),
          )
        : type == "List"
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 7.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: containerHeight,
                          width: containerWidth,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: containerHeight,
                          width: containerWidth,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Container(
                          height: containerHeight,
                          width: containerWidth * 0.6,
                          color: Colors.grey,
                        )
                      ],
                    )
                  ],
                ))
            : type == "Banner"
                ? Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey,
                    )
                : Container(
                    height: 80,
                    width: containerWidth,
                    color: Colors.grey,
                  );
  }
}
