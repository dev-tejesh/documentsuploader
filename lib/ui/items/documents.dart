import 'package:documentsuploader/api/firebase_api.dart';
import 'package:documentsuploader/controllers/documents_controller.dart';
import 'package:documentsuploader/model/firebase_file.dart';
import 'package:documentsuploader/ui/homepage/sidedrawer.dart';
import 'package:documentsuploader/ui/items/pdf_viewer.dart';
import 'package:documentsuploader/utils/appbar.dart';
import 'package:documentsuploader/utils/buildpdffile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/buildfile.dart';
import '../../utils/buildheader.dart';

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  // Future<List<FirebaseFile>> futureFiles = /*  */
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocumentsController>(
        init: DocumentsController(),
        builder: (
          _documentscontroller,
        ) {
          return Scaffold(
            appBar: appbar('Documents'),
            drawer: sideDrawer(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff00796B),
              child: const Icon(Icons.add),
              onPressed: () {
                _documentscontroller.selectFile(context);
              },
            ),
            body: FutureBuilder<List<FirebaseFile>>(
              future: FirebaseApi.listAll('files/'),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Color(0xff00796B),
                    ));
                  default:
                    if (snapshot.hasError) {
                      return const Center(child: Text('Some error occurred!'));
                    } else {
                      final files = snapshot.data!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildHeader(files.length, _documentscontroller),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ListView.builder(
                              itemCount: files.length,
                              itemBuilder: (context, index) {
                                final file = files[index];
                                  
                                return buildpdfFile(context, file);

                              },
                            ),
                          ),
                        ],
                      );
                    }
                }
              },
            ),
          );
        });
  }

  // void searchFile(String query, List files) {
  //   final suggestions = files.where((file) {
  //     final fileTitle = file.name.toLowercase();
  //     final input = query.toLowerCase();
  //     return fileTitle.contains(input);
  //   }).toList();
  //   setState(() {
  //     files = suggestions;
  //   });
  // }
}
