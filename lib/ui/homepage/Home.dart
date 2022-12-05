import 'package:documentsuploader/ui/homepage/HomeImages.dart';
import 'package:documentsuploader/ui/homepage/sidedrawer.dart';
import 'package:documentsuploader/ui/items/documents.dart';
import 'package:documentsuploader/ui/items/images.dart';
import 'package:documentsuploader/ui/items/music.dart';
import 'package:documentsuploader/ui/items/videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../utils/spacing.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Welcome to Uploader"),
        backgroundColor: const Color(0xff00796B),
      ),
      drawer: sideDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HomeImages(
                  image:
                      "https://media.istockphoto.com/id/1179640294/vector/contract-or-document-signing-icon-document-folder-with-stamp-and-text-contract-conditions.jpg?s=612x612&w=0&k=20&c=87Bu41EuMtdXDfJbm1YrquzUmHtPjFiCb9PCsrsWP1c=",
                  insidetext: "Documents",
                  onTap: () {
                    Get.to(const Documents());
                  },
                ),
                HomeImages(
                  image:
                      "https://winaero.com/blog/wp-content/uploads/2019/11/Photos-new-icon.png",
                  insidetext: "Images",
                  onTap: () {
                    Get.to(() => const Images());
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HomeImages(
                  image:
                      "https://thumbs.dreamstime.com/b/music-background-blue-23157485.jpg",
                  insidetext: "Music",
                  onTap: () {
                    Get.to(const Music());
                  },
                ),
                HomeImages(
                  image:
                      "https://media.istockphoto.com/id/1344215933/photo/business-semiar-in-the-convention-center.jpg?b=1&s=170667a&w=0&k=20&c=HUbnk1FHAeBHVl52-TLszpF-t8xP3ckR94UGC9-GL3Q=",
                  insidetext: "Videos",
                  onTap: () {
                    Get.to(() => const Videos());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
