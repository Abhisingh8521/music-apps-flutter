import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';
import 'package:video_player/video_player.dart';

import '../../utils/app_colors/app_colors.dart';

class PlayVideoScreen extends StatefulWidget {
  const PlayVideoScreen({super.key, required this.medium});

  final Medium medium;

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  late VideoPlayerController videoController;
  late ChewieController _chewieController;
  var playPauseIconVisibility = false;

  @override
  void initState() {
    getFile();
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: InteractiveViewer(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) async {
                    var currectDuration = videoController.value.position;
                    if (details.delta.dx > 0) {
                      videoController.seekTo(
                          (currectDuration.inMilliseconds + 2000).milliseconds);
                    } else {
                      videoController.seekTo(
                          (currectDuration.inMilliseconds - 2000).milliseconds);
                    }

                  },
                
                  child: AspectRatio(
                    aspectRatio: context.screenWidth / context.screenHeight,
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fromRect(
              rect: const Rect.fromLTRB(5, 5, 95, 95),
              child: IconButton(
                onPressed: () {
                  context.pop;
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColor.white,
                ),
                iconSize: 30,
                style: IconButton.styleFrom(fixedSize: const Size(40, 40)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getFile() async {
    await widget.medium.getFile().then((file) {
      videoController = VideoPlayerController.file(file);
      videoController.initialize();
      _chewieController = ChewieController(
          videoPlayerController: videoController,
          subtitleBuilder: (context, subtitle) => Text(subtitle.toString()),
          draggableProgressBar: true,
          autoInitialize: true,
          aspectRatio: double.parse(widget.medium.width.toString()) /
              double.parse(widget.medium.height.toString()),
          playbackSpeeds: [
            0.5,
            0.75,
            1.0,
            1.5,
            2.0,
            2.5,
            3.0,
            3.5,
            4.0,
            4.5,
            5.0
          ],
          autoPlay: true,
          allowPlaybackSpeedChanging: true,
          allowedScreenSleep: true);
          _chewieController.play();

      setState(() {});
    });
  }
}
