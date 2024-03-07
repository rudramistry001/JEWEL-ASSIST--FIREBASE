import 'package:flutter/material.dart';
import 'package:jewel_assist/api/apis.dart';
import 'package:jewel_assist/auth/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SingleChildScrollView(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                        user: APIs.me,
                      )),
            );
            print('Button pressed');
          },
          child: const Text('Profile Screen'),
        ),
      ),
    );
  }
}
