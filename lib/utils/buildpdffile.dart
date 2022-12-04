
import 'package:documentsuploader/ui/items/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../model/firebase_file.dart';

Widget buildpdfFile(BuildContext context, FirebaseFile file) => Column(
      children: [
        ListTile(
          trailing: InkWell(
              onTap: () {
                final weburl = file.url;
                // print('weburl' + weburl);
                // getshortenurlapi(weburl);
                Share.share('check out this pdf $weburl',
                    subject: 'Look what I share!');
              },
              child: const Icon(Icons.share)),
          title: InkWell(
            onTap: () {
              Get.to(PdfViewer(file: file));
            },
            child: Text(
              file.name.toString().length > 20
                  ? '${file.name.toString().substring(0, 10)}....${file.name.toString().substring(file.name.toString().length - 10, file.name.toString().length)}'
                  : file.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const Divider(
          height: 1,
          thickness: 0.5,
          color: Colors.grey,
        )
      ],
    );
