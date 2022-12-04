// import 'dart:html';

import 'package:documentsuploader/ui/items/image_page.dart';
import 'package:documentsuploader/ui/items/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../model/firebase_file.dart';

// final isImage = ['.jpeg', '.jpg', '.png',].any(file.name.contains)
Widget buildFile(BuildContext context, FirebaseFile file) => Column(
      children: [
        ListTile(
            // Container(
            //     height: 60,
            //     width: double.infinity,
            //     child: Center(
            //         child: Text(
            //       _documentscontroller.title,
            //       style: TextStyle(color: Colors.red),
            //     ))),
            // const Divider(
            //   height: 1,
            //   thickness: 0.5,
            //   color: Colors.grey,
            // )
            // leading: ClipOval(
            //   child: Image.network(
            //     file.url,
            //     width: 52,
            //     height: 52,
            //     fit: BoxFit.cover,
            //   ),
            // ),

            title: Text(
              file.name.toString().length > 20
                  ? file.name.toString().substring(0, 10) +
                      '....' +
                      file.name.toString().substring(
                          file.name.toString().length - 10,
                          file.name.toString().length)
                  : file.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // decoration: TextDecoration.underline,
                color: Colors.black,
              ),
            ),
            onTap: () => {
                  if (['.jpeg', '.jpg', '.png', '.pdf'].any(file.name.contains))
                    {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImagePage(file: file),
                      )),
                    }
                  else
                    {
                      PDFView(
                        filePath: file.url,
                        enableSwipe: true,
                        swipeHorizontal: true,
                        autoSpacing: false,
                        pageFling: false,
                        // onRender: (_pages) {
                        //   setState(() {
                        //     pages = _pages;
                        //     isReady = true;
                        //   });
                        // },
                        onError: (error) {
                          print(error.toString());
                        },
                        onPageError: (page, error) {
                          print('$page: ${error.toString()}');
                        },
                        // onViewCreated: (PDFViewController pdfViewController) {
                        //   _controller.complete(pdfViewController);
                        // },
                        // onPageChanged: (int page, int total) {
                        //   print('page change: $page/$total');
                        // },
                      ),
                      const Divider(
                        height: 1,
                        thickness: 0.5,
                        color: Colors.grey,
                      )
                    }
                }),
        const Divider(
          height: 1,
          thickness: 0.5,
          color: Colors.grey,
        )
      ],
    );
