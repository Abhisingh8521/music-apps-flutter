import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';

import '../../../models/playlist/playlist_model.dart';
import '../../services/app_hive_db/app_hive_db_service.dart';
import '../../services/app_storage_services/videos/app_storage_service.dart';

class PlaylistController extends GetxController {
  RxList<PlaylistModel> videoPlaylists = <PlaylistModel>[].obs;
  RxInt selectedPlaylistIndex = 0.obs;
  RxList<Medium> allVideoList = <Medium>[].obs;

  PlaylistModel get selectedPlaylist =>
      videoPlaylists[selectedPlaylistIndex.value];
  TextEditingController playlistSearchController = TextEditingController();
  TextEditingController editPlaylistController = TextEditingController();

  @override
  void onInit() {
    getAllPlayList();
    super.onInit();
  }

  void getAllPlayList() async {
    var data = await HiveStorage.getAllPlayLists();
    if (data != null) {
      videoPlaylists.value = data;
      getAllVideos();
    }
  }

  updateCurrentPlaylist(int index) {
    selectedPlaylistIndex.value = index;
  }

  getAllVideos() async {
    var data = await HiveStorage.getAllPlaylistSongs(selectedPlaylist);
    allVideoList.clear();
    data?.forEach((playlistVideo) async {
      var video = await AppStorageService.getMedium(playlistVideo!.songId ?? "");
      allVideoList.add(video);
    });
  }

  bool isSelectedIndex(int index) {
    if (index == selectedPlaylistIndex.value) {
      return true;
    }
    return false;
  }

  searchVideo(queryText) async {
    if (queryText.toString().isEmpty) {
      getAllVideos();
    } else {
      allVideoList.value = allVideoList
          .where((element) => element.title
              .toString()
              .toLowerCase()
              .contains(queryText.toString().toLowerCase()))
          .toList();
    }
  }

  onEditTap(BuildContext context) {}
}
