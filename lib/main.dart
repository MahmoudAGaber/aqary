import 'package:aqary/Views/SplachScreen.dart';
import 'package:aqary/firebase_options.dart';
import 'package:aqary/utill/styles.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
  import 'package:easy_localization/easy_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';



import 'ViewModel/ThemeViewModel.dart';
import 'helper/address_helper.dart';


//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

 Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  requestLocationPermission().then((value){
    runApp(
        ProviderScope(
            child: EasyLocalization(
                supportedLocales: [Locale("ar", "AR"), Locale("en", "US")],
                path: "assets/language",
                startLocale: Locale("ar","AR"),
                fallbackLocale: Locale("en", "US"),
                saveLocale: true,
                child: const MyApp())));
  });
}

Future<void> requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
  }

  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await Geolocator.openLocationSettings();
    if (!serviceEnabled) {
      return;
    }
  }
}



class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
   @override
  void initState() {
     AddressHelper.checkPermission((){});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var darkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode ? Styles.DarkThemeStyle : Styles.LightThemeStyle,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplachScreen(),
    );
  }
}


class Get {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}

