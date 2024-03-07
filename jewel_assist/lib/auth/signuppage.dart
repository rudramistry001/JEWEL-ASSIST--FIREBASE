// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewel_assist/auth/firebase_auth_servies.dart';
import 'package:jewel_assist/auth/formcontainerwidgets.dart';
import 'package:jewel_assist/auth/loginscreen.dart';
import 'package:jewel_assist/auth/register_step_2.dart';
import 'package:jewel_assist/auth/toast.dart';
import 'package:jewel_assist/custom%20widgets/custom_elevated_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign Up",
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
                controller: _emailController,
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
                controller: _passwordController,
                obscureText: true,
                validator: (val) =>
                    val != null && val.isNotEmpty ? null : 'Required Field',
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password_outlined,
                        color: Colors.yellow),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'ex: Your Password',
                    label: const Text('Password')),
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () {
                  _signUp();
                },
                child: Container(
                  height: 55.sp,
                  width: 200.sp,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isSigningUp
                          ? const CircularProgressIndicator(
                              color: Colors.yellow,
                            )
                          : const CustomElevatedButton(
                              text: 'Sign Up',
                              backgroundColor: Colors.yellow,
                            )),
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.yellow, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      isSigningUp = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      showToast(message: "User Credentials Registered");
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => UserRegistrationScreen(
      //       user: user,
      //     ),
      //   ),
      // );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => UserRegistrationScreen(
                    user: user,
                  )),
          (route) => false);
    } else {
      showToast(message: "Some error happend");
    }
  }
}
