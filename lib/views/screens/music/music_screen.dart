import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_p/views/screens/music/play_music_screen.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/controllers/music/music_controller.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_styles/app_styles.dart';
import 'music_widgets.dart';


class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with TickerProviderStateMixin {
  var controller = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    var view = MusicWidgets(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Obx(
            () => SizedBox(
              width: context.screenWidth,
              height: context.screenHeight * 0.05,
              child: ListView.separated(
                separatorBuilder: (context, index) => 10.width,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.albumList.length,
                itemBuilder: (context, index) {
                  return Obx(() => Center(
                        child: GestureDetector(
                          onTap: () {
                            controller.selectedAlbumIndex.value = index;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                                color: index == controller.selectedAlbumIndex.value
                                    ? AppColor.blueAccent
                                    : AppColor.soft,
                              borderRadius: 10.borderRadius,
                            ),
                            child: Text(
                              "${controller.albumList[index].album}",
                              style: defaultTextStyle,
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ),
          ),
          Obx(() => SizedBox(
                width: context.screenWidth,
                height: context.screenHeight * 0.85,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => 10.height,
                  itemCount: controller.musicList.length,
                  itemBuilder: (context, index) {
                    return Obx(() => view.musicItem(
                          songModel: controller.musicList[index],
                          isSelected:
                              index == controller.selectedMusicIndex.value
                                  ? true
                                  : false,
                          isPlaying: controller.isPlaying.value,
                          onPlayTap: () {
                            controller.selectedMusicIndex.value = index;
                            controller.playPauseTap;
                          },
                          onItemTap: () {
                            controller.selectedMusicIndex.value = index;
                            // print(controller.musicList[index].getMap);
                            // controller.initializeMusic;
                            context.push(const PlayMusicScreen());
                          },
                        ));
                  },
                ),
              )),
        ],
      ),
    );
  }
}
