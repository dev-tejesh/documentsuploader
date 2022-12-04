import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:documentsuploader/api/firebase_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

import '../model/firebase_file.dart';

class DocumentsController extends GetxController {
  // file
  File? file;
  String title = "";
  RxInt upprogress = 0.obs;
  late Future<List<FirebaseFile>> futureFiles;
  final FirebaseAuth auth = FirebaseAuth.instance;

// void inputData() {
//   final User? user = auth.currentUser;
//   final uid = user!.uid;
//   // here you write the codes to input the data into firestore
// }
  Future selectFile(context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc'],
      );
      if (result == null) return;
      final path = result.files.single.path;
      file = File(path.toString());
      if (file == null) return;
      final fileName = Path.basename(file!.path);
      title = fileName;
      final destination = 'files/$fileName';
      final ref = FirebaseStorage.instance.ref(destination);
      final uploadtask = ref.putFile(file!);
      

      uploadtask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
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
            futureFiles = FirebaseApi.listAll('files/');
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            break;
        }
      });
      final snapshot = await uploadtask.whenComplete(() => {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      // String? uid = FirebaseAuth.instance.currentUser?.uid.toString();

      //  await FirebaseFirestore.instance.collection("pdfs").doc().set({
      //       "uid": uid, 
            

        
      // });

      print('Download-Link:$urlDownload');
      upprogress.value = 0;
      update();
    } on FirebaseException catch (e) {
      print("expe");
      return null;
    }
  }
}
