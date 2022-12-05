import 'package:chewie/chewie.dart';
import 'package:documentsuploader/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends StatefulWidget {
//   final VideoPlayerController videoPlayerController;
// final bool looping;
// final bool autoplay;
  final String link;

  const VideoViewer({Key? key, required this.link}) : super(key: key);

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late VideoPlayerController _controller;
  ChewieController? chewieController;
  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(widget.link)
      ..initialize().then((_) {
        setState(() {});
      });
    chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () {
              final weburl = widget.link;
              // print('weburl' + weburl);
              // getshortenurlapi(weburl);
              Share.share('check out this pdf $weburl',
                  subject: 'Look what I share!');
            },
            iconData: Icons.share,
            title: 'Share',
          ),
        ];
      },
    );
    super.initState();
  }

  void dispose() {
    _controller.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: appbar('Video'),
      body: chewieController != null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Chewie(
                controller: chewieController!,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xff00796B),
              ),
            ),
    );
  }
}
