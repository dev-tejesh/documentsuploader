import 'package:audioplayers/audioplayers.dart';
import 'package:documentsuploader/utils/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart';

class MusicViewer extends StatefulWidget {
  final String link;
  final String title;
  const MusicViewer({Key? key, required this.link, required this.title})
      : super(key: key);

  @override
  State<MusicViewer> createState() => _MusicViewerState();
}

class _MusicViewerState extends State<MusicViewer> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool loading = true;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  String? time(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
  }

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  //for network audio
  Future setAudio() async {
    player.setReleaseMode(ReleaseMode.loop);
    String url = widget.link;
    await player.setSourceUrl(url);
    loading = false;
  }

  @override
  void initState() {
    super.initState();
    setAudio();
    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Music"),
      body: !loading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                      "https://thumbs.dreamstime.com/b/music-background-blue-23157485.jpg"),
                ),
                Text(widget.title.toString()),
                Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: ((value) async {
                      final position = Duration(seconds: value.toInt());
                      print('position');
                      print(position);
                      await player.seek(position);

                      await player.resume();
                      setState(() {});
                    })),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatTime(position.inSeconds)),
                      Text(formatTime((duration - position).inSeconds))
                      // Text(time(position) ?? ""),
                      // Text(time(duration - position) ?? "")
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    print('clicked');
                    if (isPlaying) {
                      await player.pause();
                    } else {
                      await player.resume();
                    }
                  },
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 50,
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Color(0xff00796B),
              ),
            ),
    );
  }
}
