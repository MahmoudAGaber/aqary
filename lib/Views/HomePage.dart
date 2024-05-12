
import 'package:aqary/Views/Aqary.dart';
import 'package:aqary/Views/Chat/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../ViewModel/ChatViewModel.dart';
import 'Favourites/Favourites.dart';
import 'Home/Home.dart';
import 'Profile/Profile.dart';

class Homepage extends ConsumerStatefulWidget {
  int page;
   Homepage({super.key,required this.page});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  int? _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.page;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {



    });
    super.initState();
  }
  final List<Widget> _tabs = [
    Home(),
    Favourites(),
    Aqary(),
    Chat(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 4.5,color: Colors.white,strokeAlign: 0.09),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withGreen(180), // Set the color of the shadow
              offset: Offset(0, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            onTabTapped(2);
            },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Theme.of(context).primaryColor,
          child: SvgPicture.asset("assets/images/aqary.svg"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: _currentIndex,
          children: _tabs,),
      bottomNavigationBar:BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex!,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/home2.svg",height: 22,color: _currentIndex== 0 ? Theme.of(context).primaryColor : Colors.black,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(left: 0),
                child:SvgPicture.asset("assets/images/heart.svg",color: _currentIndex== 1 ? Theme.of(context).primaryColor : Colors.black),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(right: 15,left: 15),
                child: Container(
                  width: 100,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Stack(children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Align(
                              alignment: Alignment.center,
                                child: SvgPicture.asset("assets/images/messageminus.svg",color: _currentIndex== 3 ? Theme.of(context).primaryColor : Colors.black)),
                          ),
                        ref.watch(isChatNotSeenProvider)
                            ?Padding(
                          padding: const EdgeInsets.only(left: 10,right:10,bottom: 14),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height:8,width: 8,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100)
                              ),

                            ),
                          ),
                        ):SizedBox(),
                      ],
                      ),
                    ],
                  ),
                )),
              label: '',
              ),

            BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/Profile.svg",color: _currentIndex== 4 ? Theme.of(context).primaryColor : Colors.black),
              label: '',
            ),



          ],
        ),
      );
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
