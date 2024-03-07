import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jewel_assist/auth/loginscreen.dart';
import 'package:jewel_assist/auth/splashscreen.dart';
import 'firebase_options.dart';

// global object for accessing device screen size
late Size mq;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initialiseFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jewel Assist',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        });
  }
}

_initialiseFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
