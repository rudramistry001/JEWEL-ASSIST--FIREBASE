import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jewel_assist/api/apis.dart';
import 'package:jewel_assist/api/chat_user_model.dart';
import 'package:jewel_assist/auth/home_screen.dart';
import 'package:jewel_assist/custom%20widgets/custom_elevated_button.dart';

class UserRegistrationScreen extends StatefulWidget {
  final User user;
  const UserRegistrationScreen({super.key, required this.user});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  TextEditingController role = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController vendorName = TextEditingController();
  TextEditingController contact = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "User Registration Screen",
      //     style: GoogleFonts.dancingScript(
      //       fontSize: 24.sp,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.grey,
      //     ),
      //   ),
      //   backgroundColor: Colors.yellowAccent,
      // ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              children: [
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "User Registration Screen",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                35.verticalSpace,
                Text(
                  'This is the email that will be used every time you login to the system.',
                  style: GoogleFonts.quicksand(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.user.email.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  initialValue: widget.user.email
                      .toString(), // Set the initial value to the user's email
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined,
                        color: Colors.yellowAccent),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                20.verticalSpace,
                TextFormField(
                  controller: name,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.person, color: Colors.yellowAccent),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'ex: Your Full Name',
                      label: const Text('Name')),
                ),
                20.verticalSpace,
                TextFormField(
                  controller: role,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.person, color: Colors.yellowAccent),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'ex: Your Role in Organization',
                      label: const Text('Role')),
                ),
                20.verticalSpace,
                TextFormField(
                  controller: vendorName,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.info_outline,
                          color: Colors.yellowAccent),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'ex: About Yourself',
                      label: const Text('Vendor Name')),
                ),
                20.verticalSpace,
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: contact,
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.call, color: Colors.yellowAccent),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'ex: Your Contact Number',
                      label: const Text('Contact Number')),
                ),
                10.verticalSpace,
                Text(
                  'NOTE :-This user details will be used throughout every functionality of the app.Request you to enter them correctly.',
                  style: GoogleFonts.quicksand(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                40.verticalSpace,
                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //     shape: const StadiumBorder(),
                //   ),
                //   icon: const Icon(Icons.edit, size: 28),
                //   label: const Text('UPDATE', style: TextStyle(fontSize: 16)),
                // ),
                SizedBox(
                  height: 55.sp,
                  width: 200.sp,
                  child: CustomElevatedButton(
                    text: 'Register User',
                    backgroundColor: Colors.yellow,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final time =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        ChatUser chatUser = ChatUser(
                            Email: widget.user.email.toString(),
                            Id: widget.user.uid,
                            Name: name.text,
                            CreatedAt: time,
                            VendorName: vendorName.text,
                            Role: role.text,
                            ContactNumber: contact.text);

                        await APIs.createUser(chatUser).then((value) {});
                        Navigator.pushAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
