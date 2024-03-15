import 'package:aqary/helper/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Views/base/custom_button.dart';
import '../localization/language_constraints.dart';
import '../main.dart';
import '../utill/dimensions.dart';
import '../utill/styles.dart';

class AddressHelper {
  static void checkPermission(Function callback) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }else if(permission == LocationPermission.deniedForever) {
      showDialog(context: Get.context!, barrierDismissible: false, builder: (context) => const PermissionDialog());
    }else {
      callback();
    }
  }


}


class PermissionDialog extends StatelessWidget {
  const PermissionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: SizedBox(
          width: 300,
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Icon(Icons.add_location_alt_rounded, color: Theme.of(context).primaryColor, size: 100),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            Text(
              getTranslated('you_denied_location_permission', context), textAlign: TextAlign.center,
              style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),

            Row(children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(width: 2, color: Theme.of(context).primaryColor)),
                    minimumSize: const Size(1, 50),
                  ),
                  child: Text(getTranslated('no', context)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(child: CustomButton(buttonText: getTranslated('yes', context), onPressed: () async {
                if(ResponsiveHelper.isMobilePhone()) {
                  await Geolocator.openAppSettings();
                }
                Navigator.pop(Get.context!);
              })),
            ]),

          ]),
        ),
      ),
    );
  }
}