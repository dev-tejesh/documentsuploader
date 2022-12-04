import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataDocuments {
  final String uid;
  DataDocuments({required this.uid});

  final CollectionReference documentscollection =
      FirebaseFirestore.instance.collection('documents');
  

  // Future updateUserData(String )

}
