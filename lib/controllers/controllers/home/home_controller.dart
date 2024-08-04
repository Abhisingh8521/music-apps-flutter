import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:photo_gallery/photo_gallery.dart';

import '../../../views/screens/movies/all_video_screen.dart';
import '../../../views/screens/music/music_screen.dart';
import '../../../views/screens/playlists/playlist_screen.dart';
import '../../services/app_storage_services/videos/app_storage_service.dart';

class HomeController extends GetxController {

  RxList<Album> albumList = <Album>[].obs;
  RxList<Medium>? videoList = <Medium>[].obs;
  TextEditingController searchController = TextEditingController();
  Rx<int> currentAlbumIndex = 0.obs;
  Rx<int> selectedBottomBarIndex = 0.obs;
  Rx<int> sliderCurrentIndex = 0.obs;
  RxList<Widget> allScreensList = [const AllVideoScreen(),const PlaylistScreen(),const MusicScreen()].obs;

  get getAllAlbums async {
    albumList.value = await AppStorageService.getAllVideoAlbums();
    await getAllVideos;
  }

  get getAllVideos async {
    var mediaPage = await albumList[currentAlbumIndex.value].listMedia();
      mediaPage.items.sort((a, b) => b.modifiedDate!.compareTo(a.modifiedDate!) ,);
    videoList?.value = mediaPage.items;
  }
}
