import 'package:flutter/material.dart';
import '../../utill/dimensions.dart';

class CustomShadowView extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final bool isActive;
  final Color? color;
  const CustomShadowView({
    Key? key, required this.child, this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.borderRadius = Dimensions.radiusSizeDefault,
    this.isActive = true,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isActive ? Container(
      padding: padding ,
      margin:  margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius!),
        boxShadow: [
          BoxShadow(offset: const Offset(0, 5), blurRadius: 15, spreadRadius: 6, color: Theme.of(context).primaryColor.withOpacity(0.2)),
          BoxShadow(offset: const Offset(0, 0), blurRadius: 10,spreadRadius: -6, color:Colors.white),
        ],
      ),
      child: child,
    ) : child;
  }
}
