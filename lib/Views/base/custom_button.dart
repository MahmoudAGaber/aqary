import 'package:flutter/material.dart';

import '../../utill/dimensions.dart';
import '../../utill/styles.dart';

class CustomButton extends StatelessWidget {
  final String? buttonText;
  final Function? onPressed;
  final double margin;
  final Color? textColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double? width;
  final double? height;
  final Color? borderColor;
  const CustomButton({Key? key, required this.buttonText, required this.onPressed, this.margin = 0,
    this.textColor, this.borderRadius = 10, this.backgroundColor, this.width, this.height,this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin),
      child: TextButton(
        onPressed: onPressed as void Function()?,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? (onPressed == null ? Theme.of(context).hintColor.withOpacity(0.6) : Theme.of(context).primaryColor),
          minimumSize: Size(width != null ? width! : Dimensions.webScreenWidth, height != null ? height! : 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius),side: BorderSide(color: borderColor ?? Theme.of(context).primaryColor )),
        ),
        child: Text(buttonText!, style: Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor)),
      ),
    );
  }
}
