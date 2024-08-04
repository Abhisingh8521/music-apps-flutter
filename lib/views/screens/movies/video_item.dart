import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import 'package:video_player/video_player.dart';

import '../../utils/app_colors/app_colors.dart';

class VideoItem extends StatefulWidget {
  VideoItem({super.key, required this.movieItem});

  PlatformFile? movieItem;

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController?  videoController;
  @override
  void initState() {
    videoController = VideoPlayerController.file(File(widget.movieItem?.path?? ""),videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true,mixWithOthers: false));
    videoController!.initialize();
    super.initState();
  }
  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: AppColor.darkGray,
      shape: BoxShape.rectangle,
      borderRadius: 15.borderRadius,
      child: Center(
        child: GestureDetector(onTap: () {
          videoController!.value.isPlaying ? videoController!.pause(): videoController!.play();
        },child: ClipRRect(borderRadius: 20.borderRadius,child: SizedBox(width:150,height:230,child: VideoPlayer(videoController!,)))),
      ),
    );
  }
}
