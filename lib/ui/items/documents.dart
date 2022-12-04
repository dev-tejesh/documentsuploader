import 'package:documentsuploader/api/firebase_api.dart';
import 'package:documentsuploader/controllers/documents_controller.dart';
import 'package:documentsuploader/model/firebase_file.dart';
import 'package:documentsuploader/ui/homepage/sidedrawer.dart';
import 'package:documentsuploader/ui/items/pdf_viewer.dart';
import 'package:documentsuploader/utils/appbar.dart';
import 'package:documentsuploader/utils/buildpdffile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              body: Column(
                children: [
                  buildHeader(
                      _documentscontroller.links.length, _documentscontroller),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _documentscontroller.links.length,
                        itemBuilder: (context, index) {
                          return buildpdfFile(
                              _documentscontroller.links[index].keys.first
                                  .toString(),
                              _documentscontroller.links[index][
                                      _documentscontroller
                                          .links[index].keys.first]
                                  .toString());
                        }),
                  )
                ],
              ));
        });
  }
}
