import 'dart:ui';

import 'package:documentsuploader/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageViewer extends StatefulWidget {
  String link;
  ImageViewer({Key? key, required this.link}) : super(key: key);

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar('Image'),
        body:
            Center(child: InteractiveViewer(child: Image.network(widget.link))),
      ),
    );
  }
}
