import 'package:documentsuploader/controllers/music_controller.dart';
import 'package:documentsuploader/ui/homepage/sidedrawer.dart';
import 'package:documentsuploader/utils/appbar.dart';
import 'package:documentsuploader/utils/buildheader.dart';
import 'package:documentsuploader/utils/buildpdffile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicController>(
        init: MusicController(),
        builder: (
          musiccontroller,
        ) {
          return Scaffold(
              appBar: appbar('Music'),
              drawer: sideDrawer(),
              floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xff00796B),
                child: const Icon(Icons.add),
                onPressed: () {
                  musiccontroller.selectFile(context);
                },
              ),
              body: Column(
                children: [
                  buildMusicHeader(
                      musiccontroller.music.length, musiccontroller),
                  musiccontroller.loaded
                      ? Expanded(
                          child: musiccontroller.music.isNotEmpty
                              ? ListView.builder(
                                  itemCount: musiccontroller.music.length,
                                  itemBuilder: (context, index) {
                                    return buildMusicFile(
                                        musiccontroller.music[index].keys.first
                                            .toString(),
                                        musiccontroller.music[index][
                                                musiccontroller
                                                    .music[index].keys.first]
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
                                          'Please click floating action button below to add music',
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
