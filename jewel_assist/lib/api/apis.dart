import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jewel_assist/api/chat_user_model.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud  firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //for accessing cloud  firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  //for storing self information
  static late ChatUser me;

//for returning current user
  static User get user => auth.currentUser!;

  //for checking if user exists or not??
  static Future<bool> userExists() async {
    return (await firestore.collection('Users').doc(user.uid).get()).exists;
  }

// for getting self info in profile screen
  static Future<void> getSelfInfo() async {
    await firestore.collection('Users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        // await createUser().then((value) => getSelfInfo());
      }
    });
  }

  //for creating a new user
  static Future<void> createUser(ChatUser chatUser) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    // final chatuser = ChatUser(
    //   Id: user.uid,
    //   Name: user.displayName.toString(),
    //   Email: user.email.toString(),
    //   VendorName: "",
    //   Role: "",
    //   ContactNumber: '',
    //   CreatedAt: time,
    // );
    return await firestore
        .collection('Users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('Users')
        .where('Id',
            isNotEqualTo: user.uid) //because empty list throws an error
        // .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // for updating user information
  static Future<void> updateUserInfo() async {
    await firestore.collection('Users').doc(user.uid).update({
      'Name': me.Name,
      'Vendor_Name': me.VendorName,
      'Contact_Number': me.ContactNumber,
    });
  }
}
