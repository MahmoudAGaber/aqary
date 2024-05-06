import 'package:aqary/data/services/FiresbaseServices.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../ViewModel/AuthViewModel.dart';
import '../helper/Authentication.dart';
import 'OtpVerf.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {

  FirebaseServices firebaseServices  = FirebaseServices();
  final key = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();
  var phone = TextEditingController();
  final pinController = TextEditingController();
  var countryCode = CountryCode(code: '+971',name: 'AE',dialCode: '+971');
  String? verfication;
  AuthService? auth = AuthService();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lodaing = ref.watch(loadingState);
    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
       // backgroundColor: AppColors.LightThemeStyle.colorScheme.surface,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50,bottom: 70),
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Text("تسجيل الدخول",
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset("assets/images/loginLogo.png",color: Theme.of(context).primaryColor,height: 160,),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 65),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text("رقم الهاتف",style:  Theme.of(context).textTheme.titleMedium,),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: phone,
                                    textInputAction: TextInputAction.done,
                                    style: TextStyle(height: 1.1),
                                    keyboardType: TextInputType.phone,
                                    textDirection: TextDirection.ltr,
                                    cursorColor: Colors.grey,
                                    focusNode: _focusNode,
                                    validator: _validatePhoneNumber,
                                    decoration: InputDecoration(
                                        hintTextDirection: TextDirection.ltr,
                                        hintText: "00 000 0000",
                                        hintStyle: TextStyle(color: Colors.grey,),
                                        suffixIcon: Icon(Icons.phone,color: Colors.grey,),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                                color: Theme.of(context).primaryColor
                                            )
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8,),
                                Container(
                                  decoration: BoxDecoration(
                                    //  color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.grey)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: CountryCodePicker(
                                      onChanged: (value){
                                        setState(() {
                                          countryCode = value;
                                        });
                                      },
                                      initialSelection: 'AE',
                                      favorite: ['+971','AE',],
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: false,
                                      showDropDownButton: false,
                                      showFlagMain: false,
                                      boxDecoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: EdgeInsets.zero,
                                      textStyle: Theme.of(context).textTheme.labelMedium,
                                      flagDecoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),


                                    ),
                                  ),
                                ),
                              ],
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
                                          onPressed: () async{
                                            if (key.currentState!.validate()){
                                              ref.read(loadingState.notifier).state = true;
                                              AuthService.shared.auth.verifyPhoneNumber(
                                                phoneNumber: "$countryCode${phone.text}",
                                                verificationCompleted:(AuthCredential credential) {},
                                                  verificationFailed: (FirebaseAuthException e) {
                                                  print("HIIII${e.code}");
                                                    if (e.code == 'invalid-phone-number' || e.code =='missing-client-identifier') {
                                                      ref.read(loadingState.notifier).state = false;
                                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("رقم الهاتف غير صحيح. الرجاء التحقق من صحة الرقم المدخل",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),)));
                                                    } else {
                                                    }
                                                  },
                                                codeSent: (String verificationID, int? forceResendingToken) {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerf(verificationID,"$countryCode${phone.text}",pinController)));
                                                  ref.read(loadingState.notifier).state = false;

                                                },
                                                codeAutoRetrievalTimeout: (String verificationId) {
                                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerf(verificationId,"$countryCode${phone.text}",pinController)));
                                                   ref.read(loadingState.notifier).state = false;
                                                   print("HelloBYNAme");
                                                },
                                                timeout: Duration(seconds: 45)
                                              );
                                            }

                                          },
                                          child:
                                          lodaing
                                              ? Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: Container(
                                                  height: 30, width: 30,
                                                    child: CircularProgressIndicator(color: Colors.white,)),
                                              )
                                              :
                                          Text("تسجيل دخول",
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 18,color: Colors.white),
                                          ),
                                          style: TextButton.styleFrom(
                                            fixedSize: Size.fromHeight(50),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            backgroundColor: Theme.of(context).primaryColor,
                                          ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          // Row(
                          //     children: [
                          //       Expanded(
                          //         child: TextButton(
                          //           onPressed: (){},
                          //           child: Text("الدعم الفني", style: AppColors.LightThemeStyle.textTheme.labelMedium,),
                          //           style: TextButton.styleFrom(
                          //             fixedSize: Size.fromHeight(48),
                          //             shape: RoundedRectangleBorder(
                          //                 borderRadius: BorderRadius.circular(10),
                          //               side: BorderSide(
                          //                 color: Theme.of(context).primaryColor
                          //               ),
                          //             ),
                          //           ),),
                          //       ),
                          //     ]
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePhoneNumber(String? value) {
    final numericValue = value?.replaceAll(RegExp(r'[^0-9+]'), '');

    if (numericValue == null || numericValue.isEmpty) {
      return 'الرقم الهاتفي مطلوب';
    } else if (numericValue.length < 8) {
      return 'يجب أن يكون رقم الهاتف على الأقل ١٠ أرقام';
    }

    return null;
  }
}
