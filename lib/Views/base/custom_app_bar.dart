import 'package:flutter/material.dart';

import '../../utill/dimensions.dart';
import '../../utill/styles.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function? onBackPressed;
  final bool isCenter;
  final bool isElevation;
  final bool fromcategoriescreen;
  final Widget? actionView;
  final Widget? leadingView;

  const CustomAppBar({
    Key? key, required this.title, this.isBackButtonExist = true, this.onBackPressed,
    this.isCenter = true, this.isElevation = false,this.fromcategoriescreen = false, this.actionView,this.leadingView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!, style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20, color: Theme.of(context).textTheme.bodyLarge!.color)),
      centerTitle: isCenter?true:false,
      iconTheme: IconThemeData(color: Colors.black),
      leading: isBackButtonExist ? IconButton(
        icon: Icon(Icons.arrow_back_ios,color: Colors.black),
        color: Colors.black,
        onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
      ) :  leadingView,
      backgroundColor: Theme.of(context).cardColor,
      elevation: isElevation ? 2 : 0,
      actions: [
        actionView != null ? actionView! : const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}
