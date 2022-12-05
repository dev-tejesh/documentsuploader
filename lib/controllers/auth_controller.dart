import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:documentsuploader/ui/authentication/loginpage.dart';
import 'package:documentsuploader/ui/homepage/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  String email = "";
  String password = "";

  void login(context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.to(const Home());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message.toString(),
          messageText: Text(
            e.message.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black12,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void resetPassword(context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      const snackBar =
          SnackBar(content: Text("Reset Password is sent to your email"));
      Get.to(LoginPage());
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      var snackBar = SnackBar(content: Text(e.message.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void register(context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set({"links": []});
      await FirebaseFirestore.instance
          .collection("images")
          .doc(uid)
          .set({"images": []});
      await FirebaseFirestore.instance
          .collection("music")
          .doc(uid)
          .set({"music": []});
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(uid)
          .set({"videos": []});
      Get.to(Home());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message.toString(),
          messageText: Text(
            e.message.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black12,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
