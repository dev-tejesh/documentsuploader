import 'package:documentsuploader/controllers/documents_controller.dart';
import 'package:documentsuploader/controllers/images_controller.dart';
import 'package:documentsuploader/controllers/music_controller.dart';
import 'package:documentsuploader/controllers/video_controller.dart';
import 'package:documentsuploader/ui/items/music.dart';
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


Widget buildImageHeader(int length, ImagesController controller) => ListTile(
      tileColor: Colors.blue[200],
      leading: Container(
        width: 52,
        height: 52,
        child: Icon(
          Icons.file_copy,
          color: Colors.white,
        ),
      ),
      subtitle: GetX<ImagesController>(builder: (a) {
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


Widget buildMusicHeader(int length, MusicController controller) => ListTile(
      tileColor: Colors.blue[200],
      leading: Container(
        width: 52,
        height: 52,
        child: Icon(
          Icons.file_copy,
          color: Colors.white,
        ),
      ),
      subtitle: GetX<MusicController>(builder: (a) {
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



Widget buildVideoHeader(int length, VideoController controller) => ListTile(
      tileColor: Colors.blue[200],
      leading: Container(
        width: 52,
        height: 52,
        child: Icon(
          Icons.file_copy,
          color: Colors.white,
        ),
      ),
      subtitle: GetX<VideoController>(builder: (a) {
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
