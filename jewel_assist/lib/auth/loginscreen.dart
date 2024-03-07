// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewel_assist/api/apis.dart';
import 'package:jewel_assist/auth/firebase_auth_servies.dart';
import 'package:jewel_assist/auth/home_screen.dart';
import 'package:jewel_assist/auth/signuppage.dart';
import 'package:jewel_assist/custom%20widgets/custom_elevated_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSignIn = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Log In",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dancingScript(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              190.verticalSpace,
              TextFormField(
                controller: emailController,
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : 'Required Field',
                decoration: InputDecoration(
                    prefixIcon:
                        const Icon(Icons.email_outlined, color: Colors.yellow),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'ex: Your Email',
                    label: const Text('Email')),
              ),
              10.verticalSpace,
              TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : 'Required Field',
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password_outlined,
                        color: Colors.yellow),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'ex: Your Password',
                    label: const Text('Pass')),
              ),
              const SizedBox(height: 32.0),
              isSignIn
                  ? const CircularProgressIndicator(
                      color: Colors.yellow,
                    )
                  : SizedBox(
                      height: 55.sp,
                      width: 200.sp,
                      child: CustomElevatedButton(
                        text: 'Log In',
                        backgroundColor: Colors.yellow,
                        onPressed: () {
                          print('Email: ${emailController.text}');
                          print('Password: ${passwordController.text}');
                          _signIn();
                        },
                      ),
                    ),
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New User?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()),
                            (route) => false);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.yellow, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      isSignIn = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isSignIn = false;
    });

    if (user != null) {
      print("User sign in successfully");

      if (await (APIs.userExists())) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } else {
        // await APIs.createUser().then((value) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
        // });
      }
    } else {
      print("Error occurred in Sign In");
    }
  }
}
