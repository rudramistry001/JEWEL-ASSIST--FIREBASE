import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jewel_assist/api/apis.dart';
import 'package:jewel_assist/auth/home_screen.dart';
import 'package:jewel_assist/auth/signuppage.dart';
import 'package:jewel_assist/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));

      if (APIs.auth.currentUser != null) {
        // ignore: avoid_print
        print('\nUser: ${APIs.auth.currentUser}');
        //navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        //navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const SignUpPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Stack(
          children: [
            Positioned(
              top: mq.height * .25,
              right: mq.width * .25,
              width: mq.width * .5,
              child: Image.asset('assets/images/logo.png'),
            ),
            Positioned(
              bottom: mq.height * .25,
              width: mq.width * .9,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'अब Documentation 📄 ',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 28.sp, color: Colors.lightBlueAccent),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            65.horizontalSpace,
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'हुआ आसान',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.lightBlueAccent),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  50.verticalSpace,
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Made',
                            style: TextStyle(
                                fontSize: 16.sp, color: Colors.orange),
                          ),
                          Text(
                            ' In ',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.grey),
                          ),
                          Text(
                            'India',
                            style: TextStyle(
                                fontSize: 16.sp, color: Colors.lightGreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '#',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          Text(
                            'Proud',
                            style: TextStyle(
                                fontSize: 16.sp, color: Colors.orange),
                          ),
                          Text(
                            ' To be ',
                            style:
                                TextStyle(fontSize: 16.sp, color: Colors.grey),
                          ),
                          Text(
                            'Indian ',
                            style: TextStyle(
                                fontSize: 16.sp, color: Colors.lightGreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
