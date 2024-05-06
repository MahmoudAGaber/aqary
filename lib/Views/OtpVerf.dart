import 'dart:async';

import 'package:aqary/Views/Home/Home.dart';
import 'package:aqary/Views/HomePage.dart';
import 'package:aqary/data/services/FiresbaseServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import '../ViewModel/AuthViewModel.dart';
import '../ViewModel/UserViewModel.dart';
import '../helper/Authentication.dart';

class OtpVerf extends ConsumerStatefulWidget {
  String verficationId;
  String phone;
  TextEditingController pinController;

  OtpVerf(this.verficationId,this.phone,this.pinController);

  @override
  ConsumerState<OtpVerf> createState() => _OtpVerfState();
}

class _OtpVerfState extends ConsumerState<OtpVerf> {

  FirebaseServices firebaseServices = FirebaseServices();
  AuthViewModel authViewModel = AuthViewModel();
  Timer? _timer;
  int _seconds = 45;

  var key = GlobalKey<FormState>();
  final focusNode = FocusNode();


  var cellOne =  TextEditingController();
  var cellTwo =  TextEditingController();
  var cellThree =  TextEditingController();
  var cellFour =  TextEditingController();
  var cellFive =  TextEditingController();
  var cellSix =  TextEditingController();

  bool? otpValid = true;
  bool? optSuccess = false;

  final FocusNode? _focusNode1 = FocusNode();
  final FocusNode? _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _startTimer();
    });
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {

      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  void _resetTimer() {
    if (_seconds > 0 && !_timer!.isActive) {
      setState(() {
        _seconds = 45;
      });
      _startTimer();
    }
  }



  void dispose() {
    _focusNode1!.dispose();
    _focusNode2!.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();

    _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(UserProvider);
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 65,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: Colors.grey),
      ),
    );
    final lodaing = ref.watch(loadingState);
    return Scaffold(
     // backgroundColor: AppColors.LightThemeStyle.colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50,bottom: 20),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text("التحقق من الرمز",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
                          ),
                        ),
                        // SvgPicture.asset("assets/images/vector.svg"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 65),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width*.5,
                            child: Text("أدخل رمز ال OTP الذي ارسلناه إلي رقم هاتفك *********911 للتأكيد",
                              //style:AppColors.LightThemeStyle.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("أدخل رمز التحقق",
                                //style: AppColors.LightThemeStyle.textTheme.bodyMedium,
                              ),
                              Text("0:${_seconds}",
                              //  style: AppColors.LightThemeStyle.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),

                        Form(
                          key: key,
                          child: Directionality(
                            // Specify direction if desired
                            textDirection: TextDirection.ltr,
                            child: Pinput(
                              controller: widget.pinController,
                              focusNode: focusNode,
                              length: 6,
                              androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
                              listenForMultipleSmsOnAndroid: true,
                              defaultPinTheme: defaultPinTheme,

                              separatorBuilder: (index) => const SizedBox(width: 8),
                              // validator: (value) {
                              //   AuthService.shared.verifyCode(
                              //       pinController.text,
                              //       widget.verficationId).then((value){
                              //     if(value!=null){
                              //         return null;
                              //     }
                              //   });
                              //   return 'برجاء التحقق من الرمز';
                              // },

                              // onClipboardFound: (value) {
                              //   debugPrint('onClipboardFound: $value');
                              //   pinController.setText(value);
                              // },

                              hapticFeedbackType: HapticFeedbackType.lightImpact,
                              onCompleted: (pin) {
                                debugPrint('onCompleted: $pin');
                              },
                              onChanged: (value) {
                                debugPrint('onChanged: $value');
                              },

                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 9),
                                    width: 22,
                                    height: 1,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration!.copyWith(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                ),
                              ),
                              submittedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration!.copyWith(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(19),
                                  border: Border.all(color: Theme.of(context).primaryColor,),
                                ),
                              ),
                              errorPinTheme: defaultPinTheme.copyBorderWith(
                                border: Border.all(color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Container(
                  child:
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: ()async{
                                    if(key.currentState!.validate()){
                                      ref.read(loadingState.notifier).state = true;
                                      AuthService.shared.verifyCode(
                                          widget.pinController.text,
                                          widget.verficationId).then((value){
                                        if(value!=null){
                                          setState(() {
                                            optSuccess = true;
                                          });
                                          // String userName;
                                          // if(user.data!.name.isNotEmpty || user.data!.name != null){
                                          //    userName = user.data!.name;
                                          // }
                                          // else{
                                          //   userName = "userName";
                                          // }

                                          authViewModel.login(widget.phone, AuthService.shared.auth.currentUser!.uid);

                                          firebaseServices.addUser(AuthService.shared.auth.currentUser!.uid, "${widget.phone}");

                                          Timer.periodic(Duration(seconds: 2), (timer) {
                                            try {
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex) => Homepage(page: 0,)));
                                              ref.read(loadingState.notifier).state = false;
                                              optSuccess = false;
                                            }catch(e){
                                              print(e);
                                            }
                                          });


                                        }else {
                                          ref.read(loadingState.notifier).state = false;
                                          setState(() {
                                            otpValid = false;
                                          });  
                                        }
                                      });

                                    }
                                  },
                                  child:
                                  lodaing
                                      ? Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      height: 30,width: 30,
                                        child: CircularProgressIndicator(color: Colors.white,)),
                                  ):
                                      Text("تحقق من الرمز",
                                   style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                                  ),
                                  style: TextButton.styleFrom(
                                    fixedSize: Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    backgroundColor: Theme.of(context).primaryColor,
                                  ),),
                              ),
                            ]
                        ),
                      ),
                      AbsorbPointer(
                        absorbing: _seconds>0,
                        child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: (){
                                    AuthService.shared.resendCode(widget.verficationId, widget.phone);
                                    setState(() {
                                      _seconds = 45;
                                      _startTimer();
                                    });

                                  },
                                  child: Text("إعاداة إرسال الرمز",
                                    style:  Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).primaryColor),
                                  ),
                                  style: TextButton.styleFrom(
                                    fixedSize: Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: Theme.of(context).primaryColor
                                      ),
                                    ),
                                  ),),
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
