import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/controllers/music/music_controller.dart';
import '../../utils/app_colors/app_colors.dart';

class PlayMusicScreen extends StatefulWidget {
  const PlayMusicScreen({super.key});

  @override
  State<PlayMusicScreen> createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen> {
  var musicController = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: AppColor.white,),
          backgroundColor: AppColor.dark,
        ),
        body: Obx(
              () => Container(
            width: context.screenWidth,
            height: context.screenHeight,
            decoration: BoxDecoration(

                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // Color(0xff144771),
                      // Color(0xff071a2c),
                      AppColor.dark,
                      AppColor.soft,
                    ])),
            child: Column(
              children: [
                QueryArtworkWidget(
                  id: musicController.selectSong.id,
                  type: ArtworkType.AUDIO,
                  artworkWidth: context.screenWidth * 0.85,
                  artworkHeight: context.screenHeight * 0.40,
                  artworkFit: BoxFit.cover,
                  artworkQuality: FilterQuality.high,
                  artworkBorder: 25.borderRadius,
                  nullArtworkWidget:  CircleAvatar(radius: 150,backgroundColor: AppColor.soft,child: const Icon(Icons.music_note,size: 100,),),
                )
              ],
            ),
          ),
        ));
  }
}
