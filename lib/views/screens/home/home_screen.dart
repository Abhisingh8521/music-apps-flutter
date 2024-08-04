import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/controllers/home/home_controller.dart';
import '../../utils/app_colors/app_colors.dart';
import 'home_screen_Widgets.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeController = Get.put(HomeController());
  @override
  void initState() {
    homeController.getAllAlbums;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var view = HomeWidgets(context);
    return Scaffold(
      bottomNavigationBar: Container(
          height: 60,
          padding: 10.horizontalPadding,
          decoration: BoxDecoration(color: AppColor.dark),
          child: Obx(() => Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  view.bottomBarItem(
                      onItemTap: () {homeController.selectedBottomBarIndex.value = 0;},
                      label: "Home",
                      icon: Icons.house_rounded,
                      selected: homeController.selectedBottomBarIndex.value == 0),
                  view.bottomBarItem(
                      onItemTap: () {homeController.selectedBottomBarIndex.value = 1;},
                      label: "Playlist",
                      icon: Icons.playlist_play,
                      selected: homeController.selectedBottomBarIndex.value == 1),
                  view.bottomBarItem(
                      onItemTap: () { homeController.selectedBottomBarIndex.value = 2;},
                      label: "Music",
                      icon: Icons.library_music,
                      selected: homeController.selectedBottomBarIndex.value == 2),
                ]),
          )),
      body: Obx(() => homeController.allScreensList[homeController.selectedBottomBarIndex.value]),
    );
  }
}
