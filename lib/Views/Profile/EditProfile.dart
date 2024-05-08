

import 'dart:io';

import 'package:aqary/ViewModel/UserViewModel.dart';
import 'package:aqary/Views/HomePage.dart';
import 'package:aqary/Views/Profile/Profile.dart';
import 'package:aqary/Views/base/custom_button.dart';
import 'package:aqary/Views/base/custom_text_field.dart';
import 'package:aqary/data/services/FiresbaseServices.dart';
import 'package:aqary/helper/Authentication.dart';
import 'package:aqary/utill/dimensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../Models/UserModel.dart';
import '../../helper/file_picker.dart';
import '../base/custom_app_bar.dart';
import '../base/custom_dialog.dart';

class EditProfile extends ConsumerStatefulWidget {
  String? userName;
  String? pic;
  EditProfile({super.key,this.userName,this.pic});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {

  FirebaseServices firebaseServices = FirebaseServices();
  AuthService auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController userNameEditController = TextEditingController();
  File? imageFile;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("OGBABY${widget.pic}");
      if(widget.userName !=null){
        userNameEditController.text = widget.userName!;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProfile = ref.watch(localImageProvider);
    var updateLoading =  ref.watch(updateUserLoadingProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "تعديل الصفحه الشخصيه",
        isBackButtonExist: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key:_formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,width: 100,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                            child: userProfile.path.isNotEmpty
                                ? Image.file(File(userProfile.path),fit: BoxFit.cover,height: 100,width: 100,)
                                : widget.pic!.isNotEmpty
                                ?Image.network(widget.pic!,fit: BoxFit.cover,height: 100,width: 100,)
                                :SizedBox(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                              ),
                            ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: InkWell(
                              onTap: ()async{
                                  List<File> files = [];
                                  files = await FilePickerHelper().pickFiles(true);
                                  ref.read(localImageProvider.notifier).state = files.first;
                              },
                              child: Container(
                                  height: 30,width: 30,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Icon(Icons.add,color: Colors.white,size: 18,))),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault,),
                  CustomTextField(
                    controller: userNameEditController,
                    hintText: "User Name",
                    isPadding: true,
                    fillColor: Colors.grey[100],
                    isShowBorder: false,
                  )
                ],
              ),
            ),
           CustomButton(
                buttonText: "حفظ التغييرات",
                textColor: Colors.white,
                onPressed: ()async{
                  ref.read(updateUserLoadingProvider.notifier).state = true;
                  if(_formKey.currentState!.validate()){
                   Map<String ,dynamic> data = {
                     "pic" : userProfile,
                     "name": userNameEditController.text,
                   };
                   ref.read(UserProvider.notifier).updateUser(data);
                    firebaseServices.updateUser(auth.auth.currentUser!.uid, userNameEditController.text);
                    ref.read(UserProvider.notifier).getUserInfo();
                   showAnimatedDialog(
                       context, dismissible: false,
                       userUpdated()
                   );
                   ref.read(updateUserLoadingProvider.notifier).state = false;
                  }
                },
            ),
          ],
        ),
      ),
    );
  }
  List<String> searchImage =[
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",
    "assets/images/estate1.png",
    "assets/images/estate2.png",

  ];

  Widget userUpdated(){
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      insetPadding: EdgeInsets.zero,
      child: Builder(
        builder: (BuildContext dialogContext){
          return  Container(
            height: MediaQuery.of(dialogContext).size.height*.38,
            width: MediaQuery.of(dialogContext).size.width*.9,
            child: Column(
              children: [
                SizedBox(
                  height: 185,
                  width: 185,
                  child: Stack(
                    children: [
                      SvgPicture.asset("assets/images/Ellipse2.svg",colorFilter: ColorFilter.linearToSrgbGamma(),),
                      Center(child: SvgPicture.asset("assets/images/Ellipse2.svg",height: 150,width: 150,)),
                      Center(child: Container(width: 80,height:80,decoration: BoxDecoration(color: Theme.of(dialogContext).primaryColor,borderRadius: BorderRadius.circular(50)),)),
                      Center(child: Text("✓",style: Theme.of(dialogContext).textTheme.titleLarge!.copyWith(fontSize: 22,color: Colors.white),)),

                    ],
                  ),),
                Text('تم تعديل البيانات',
                  textAlign: TextAlign.center,
                  style: Theme.of(dialogContext).textTheme.titleLarge!.copyWith(fontSize: 20),),
                SizedBox(height: Dimensions.paddingSizeLarge,),
                CustomButton(
                    buttonText: "تم",
                    height: 50,
                    width: 200,
                    textColor: Colors.white,
                    borderRadius: 12,
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage(page: 4,)));
                    }
                ),
              ],
            ),);
        },
      ),
    );
  }
}
