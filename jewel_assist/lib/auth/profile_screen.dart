import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jewel_assist/api/apis.dart';
import 'package:jewel_assist/api/chat_user_model.dart';
import 'package:jewel_assist/auth/dialogs.dart';
import 'package:jewel_assist/auth/home_screen.dart';
import 'package:jewel_assist/auth/loginscreen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Screen',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.yellowAccent,
        leading: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          child: const Icon(
            CupertinoIcons.chevron_back,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 70,
        width: 110,
        padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
        child: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () async {
            Dialogs.showProgressBar(context);

            await APIs.auth.signOut().then((value) async {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false);
            });
          },
          child: const Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Text('LogOut'),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              children: [
                20.verticalSpace,
                Text(
                  widget.user.Email,
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  initialValue: widget.user.Name,
                  onSaved: (val) => APIs.me.Name = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'ex: Your Full Name',
                      label: const Text('Name')),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: widget.user.VendorName,
                  onSaved: (val) => APIs.me.VendorName = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.info_outline, color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'ex: About Yourself',
                      label: const Text('Vendor Name')),
                ),
                20.verticalSpace,
                TextFormField(
                  initialValue: widget.user.ContactNumber,
                  onSaved: (val) => APIs.me.ContactNumber = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.call, color: Colors.blue),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'ex: Your Contact Number',
                      label: const Text('Contact Number')),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      APIs.updateUserInfo().then((value) {
                        Dialogs.showSnackbar(
                            context, 'Profile Updated Successfully!');
                      });
                    }
                  },
                  icon: const Icon(Icons.edit, size: 28),
                  label: const Text('UPDATE', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
