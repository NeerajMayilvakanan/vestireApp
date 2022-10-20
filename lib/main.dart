import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vestire_app/responsive/mobile_screen_layout.dart';
import 'package:vestire_app/responsive/responsive_layout_screen.dart';
import 'package:vestire_app/responsive/web_screen_layout.dart';
import 'package:vestire_app/screens/login_screen.dart';
import 'package:vestire_app/screens/signup_screen.dart';
import 'package:vestire_app/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCJ_5GqeATdoZGynl3nqA3f55VQdBwBiuM",
            appId: "1:868687785894:web:911544e340287c87b42967",
            messagingSenderId: "868687785894",
            projectId: "vestire-apparels",
            storageBucket: "vestire-apparels.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vestire Aparells',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ));
      // home: LoginScreen(),
      home: SignupScreen(),
    );
  }
}
