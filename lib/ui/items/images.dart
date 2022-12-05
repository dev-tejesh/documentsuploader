import 'dart:ui';

import 'package:documentsuploader/ui/homepage/sidedrawer.dart';
import 'package:documentsuploader/utils/appbar.dart';
import 'package:documentsuploader/utils/buildheader.dart';
import 'package:documentsuploader/utils/buildpdffile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controllers/images_controller.dart';

class Images extends StatefulWidget {
  const Images({Key? key}) : super(key: key);

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImagesController>(
        init: ImagesController(),
        builder: (
          imagescontroller,
        ) {
          return Scaffold(
              appBar: appbar('Images'),
              drawer: sideDrawer(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xff00796B),
                child: const Icon(Icons.add),
                onPressed: () {
                  imagescontroller.selectFile(context);
                },
              ),
              body: Column(
                children: [
                  buildImageHeader(
                      imagescontroller.images.length, imagescontroller),
                  imagescontroller.loaded
                      ? Expanded(
                          child: imagescontroller.images.length != 0
                              ? ListView.builder(
                                  itemCount: imagescontroller.images.length,
                                  itemBuilder: (context, index) {
                                    return buildImageFile(
                                        imagescontroller
                                            .images[index].keys.first
                                            .toString(),
                                        imagescontroller.images[index][
                                            imagescontroller
                                                .images[index].keys.first]);
                                  })
                              : 
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Center(
                                        child: Text(
                                          'Please click floating action button below to add images',
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                      : Container()
                ],
              ));
        });
  }
}
