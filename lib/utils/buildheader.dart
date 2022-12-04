import 'package:documentsuploader/controllers/documents_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

Widget buildHeader(int length, DocumentsController controller) => ListTile(
      tileColor: Colors.blue[200],
      leading: Container(
        width: 52,
        height: 52,
        child: Icon(
          Icons.file_copy,
          color: Colors.white,
        ),
      ),
      subtitle: GetX<DocumentsController>(builder: (a) {
        return controller.upprogress != 0
            ? Text(
                "Uploading - ${controller.upprogress} %",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Container();
      }),
      title: Text(
        '$length Files',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
