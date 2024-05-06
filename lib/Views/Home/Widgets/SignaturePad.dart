

import 'package:aqary/Views/base/custom_app_bar.dart';
import 'package:aqary/Views/base/custom_button.dart';
import 'package:aqary/helper/payment_helper.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:signature/signature.dart';

import '../../../ViewModel/ContractViewModel.dart';
import '../../../utill/Utils.dart';
import 'SignatureDetailScreen.dart';

class SignaturePad extends ConsumerStatefulWidget {
  const SignaturePad({super.key});

  @override
  ConsumerState<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends ConsumerState<SignaturePad> {
  SignatureController signatureController = SignatureController();

  @override
  void initState() {
    signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
    );
    super.initState();
  }

  Future listenController() async {
    signatureController.addListener(() {
      if (signatureController.isNotEmpty || signatureController.isEmpty) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: CustomAppBar(
        title: "توقيع رقمي",
      ),
      body: FutureBuilder(
        future: listenController(),
        builder: (context, snapshot) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  color: Colors.grey[100],
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Signature(
                        height: !isPortrait
                            ? MediaQuery.of(context).size.height * 0.4
                            : 250,
                        width: MediaQuery.of(context).size.width - 32,
                        controller: signatureController,
                        backgroundColor: Colors.transparent,
                      ),
                      if (signatureController.isEmpty) ...[
                        Column(
                          children: [
                            Icon(
                              Icons.draw,
                              size: 50,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "يرجى رسم التوقيع الرقمي هنا",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    ],
                  ),
                ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: isPortrait
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.end,
                children: [
                  if (!isPortrait) ...[
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: ButtonAction(
                      title: 'مسح',
                      icon: Icons.delete,
                      onPressed: () => signatureController.clear(),
                    ),
                  ),
                  if (!isPortrait) ...[
                    const SizedBox(width: 10),
                  ],
                  SizedBox(width: Dimensions.paddingSizeDefault,),
                  Expanded(
                    child: ButtonAction(
                      title: 'تم',
                      icon: Icons.done,
                      onPressed: () async {
                        final isLanscape = MediaQuery.of(context).orientation ==
                            Orientation.landscape;

                        if (signatureController.isNotEmpty) {
                          final signature = await Utils.exportSignature(
                            signatureController: signatureController,
                            penColor: Colors.grey[900]!,
                          );
                          if (isLanscape) {
                            // Set orientation to potrait Up
                            SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp],
                            );
                          }
                        //  PaymentHelper.uint8ListToFile(signature);
                          ref.read(signatureProvider.notifier).getSignature(signature);
                         // Navigator.push(context, MaterialPageRoute(builder: (context)=> SignatureDetailScreen(signature: ref.watch(signatureProvider).data!)));

                           Navigator.pop(context);

                          signatureController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: SafeArea(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       buildButtons(context),
      //       buildSwapOrientation(),
      //     ],
      //   ),
      // ),
    );
  }

  Widget buildButtons(BuildContext context) => Container(
    color: Theme.of(context).primaryColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildCheck(context),
        Container(
          height: 50,
          width: 2,
          color: Colors.white,
        ),
        buildClear(),
      ],
    ),
  );

  Widget buildCheck(BuildContext context) => IconButton(
    iconSize: 36,
    icon: const Icon(Icons.check_box_outline_blank, color: Colors.green),
    onPressed: () async {
      final isLanscape =
          MediaQuery.of(context).orientation == Orientation.landscape;

      if (signatureController.isNotEmpty) {
        // final signature = await Utils.exportSignature(
        //   signatureController: signatureController,
        // );

        if (isLanscape) {
          // Set orientation to potrait Up
          SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp],
          );
        }

        // await Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         SignatureDetailScreen(signature: signature),
        //   ),
        // );

        signatureController.clear();
      }
    },
  );

  Widget buildClear() => IconButton(
    iconSize: 36,
    icon: const Icon(Icons.theater_comedy, color: Colors.red),
    onPressed: () => signatureController.clear(),
  );

  Widget buildSwapOrientation() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final newOrientation =
        isPortrait ? Orientation.landscape : Orientation.portrait;

        signatureController.clear();
       // Utils.setOrientation(orientation: newOrientation);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPortrait
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
              size: 40,
            ),
            const SizedBox(width: 12),
            const Text(
              'Tap to change signature orientation',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonAction extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonAction({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        buttonText: title,
        textColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: onPressed);
  }
}