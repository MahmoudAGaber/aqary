import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int itemCount = 4;

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ShimmerChatItem(),
          ),
        );
      },
    );
  }
}

class ShimmerChatItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 12.0,
                color: Colors.yellow,
              ),
              const SizedBox(height: 8),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 12.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}