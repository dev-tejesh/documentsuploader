import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';
import 'package:path/path.dart' as Path;

class ImagesController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getimages();
    super.onInit();
  }

  RxInt upprogress = 0.obs;
  File? file;
  List images = [];
  Future addImage(String url, String name) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    images.add({name: url});
    await FirebaseFirestore.instance
        .collection("images")
        .doc(uid)
        .set({"images": images}, SetOptions(merge: true));

    print("done");
    getimages();
    update();
  }

  bool loading = true;
  Future getimages() async {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show();

    String uid = FirebaseAuth.instance.currentUser!.uid;
    print(uid);
    DocumentSnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection("images").doc(uid).get();
    images = data['images'];
    loading = false;
    EasyLoading.dismiss();
    update();
  }

  Future selectFile(context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: [
          'jpeg',
          'jpg',
          'png',
        ],
      );
      if (result == null) return;
      final path = result.files.single.path;
      file = File(path.toString());
      if (file == null) return;
      final fileName = Path.basename(file!.path);
      // title = fileName;
      final destination = 'files/$fileName';
      final ref = FirebaseStorage.instance.ref(destination);
      final uploadtask = ref.putFile(file!);

      uploadtask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            final progress = 100.0 *
                (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
            int percentage = progress.round();
            upprogress.value = percentage;
            // final snackBar =
            //     SnackBar(content: Text("Upload is $percentage% complete."));
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);

            break;
          case TaskState.paused:
            const snackBar = SnackBar(content: Text("Upload is paused."));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;
          case TaskState.canceled:
            const snackBar = SnackBar(content: Text("Upload is cancelled."));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;
          case TaskState.error:
            // Handle unsuccessful uploads
            const snackBar = SnackBar(content: Text("Error in uploading"));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;
          case TaskState.success:
            const snackBar = SnackBar(content: Text("Succesfully Uploaded"));
            String url = await ref.getDownloadURL();
            await addImage(url, fileName);

            // futureFiles = FirebaseApi.listAll('files/');
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;
        }
      });
      final snapshot = await uploadtask.whenComplete(() => {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      
      print('Download-Link:$urlDownload');
      upprogress.value = 0;
      update();
    } on FirebaseException catch (e) {
      print("expe");
      return null;
    }
  }
}
