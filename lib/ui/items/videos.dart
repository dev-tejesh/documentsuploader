import 'package:documentsuploader/controllers/video_controller.dart';
import 'package:documentsuploader/ui/homepage/sidedrawer.dart';
import 'package:documentsuploader/utils/appbar.dart';
import 'package:documentsuploader/utils/buildheader.dart';
import 'package:documentsuploader/utils/buildpdffile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoController>(
        init: VideoController(),
        builder: (
          videoscontroller,
        ) {
          return Scaffold(
              appBar: appbar('Videos'),
              drawer: sideDrawer(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xff00796B),
                child: const Icon(Icons.add),
                onPressed: () {
                  videoscontroller.selectFile(context);
                },
              ),
              body: Column(
                children: [
                  buildVideoHeader(
                      videoscontroller.videos.length, videoscontroller),
                  videoscontroller.loaded
                      ? Expanded(
                          child: videoscontroller.videos.isNotEmpty
                              ? ListView.builder(
                                  itemCount: videoscontroller.videos.length,
                                  itemBuilder: (context, index) {
                                    return buildvideoFile(
                                        videoscontroller
                                            .videos[index].keys.first
                                            .toString(),
                                        videoscontroller.videos[index][
                                                videoscontroller
                                                    .videos[index].keys.first]
                                            .toString());
                                  })
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Center(
                                        child: Text(
                                          'Please click floating action button below to add videos',
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
