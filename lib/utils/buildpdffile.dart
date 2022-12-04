import 'package:documentsuploader/ui/items/image_viewer.dart';
import 'package:documentsuploader/ui/items/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_file_view/power_file_view.dart';
import 'package:share_plus/share_plus.dart';

import '../model/firebase_file.dart';

Widget buildpdfFile(String title, String link) => Column(
      children: [
        ListTile(
            trailing: InkWell(
                onTap: () {
                  final weburl = link;
                  // print('weburl' + weburl);
                  // getshortenurlapi(weburl);
                  Share.share('check out this pdf $weburl',
                      subject: 'Look what I share!');
                },
                child: const Icon(Icons.share)),
            title: InkWell(
              onTap: () {
                Get.to(PdfViewer(link: link));
              },
              child: Text(
                // 'kkk'
                title.toString().length > 20
                    ? '${title.toString().substring(0, 10)}....${title.toString().substring(title.toString().length - 10, title.toString().length)}'
                    : title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )),
        const Divider(
          height: 1,
          thickness: 0.5,
          color: Colors.grey,
        )
      ],
    );

Widget buildImageFile(String title, String link) => Column(
      children: [
        ListTile(
            trailing: InkWell(
                onTap: () {
                  final weburl = link;
                  // print('weburl' + weburl);
                  // getshortenurlapi(weburl);
                  Share.share('check out this pdf $weburl',
                      subject: 'Look what I share!');
                },
                child: const Icon(Icons.share)),
            title: InkWell(
              onTap: () {
                Get.to(ImageViewer(link: link));
              },
              child: Text(
                // 'kkk'
                title.toString().length > 20
                    ? '${title.toString().substring(0, 10)}....${title.toString().substring(title.toString().length - 10, title.toString().length)}'
                    : title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )),
        const Divider(
          height: 1,
          thickness: 0.5,
          color: Colors.grey,
        )
      ],
    );
