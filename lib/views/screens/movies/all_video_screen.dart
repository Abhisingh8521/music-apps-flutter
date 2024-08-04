import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';


import '../../../controllers/controllers/home/home_controller.dart';
import '../../../controllers/services/app_hive_db/app_hive_db_service.dart';
import '../../../models/favorite_videos/favorite_video_model.dart';
import '../../../models/playlist/playlist_model.dart';
import '../../../models/playlist/playlist_songs.dart';
import '../../utils/app_colors/app_colors.dart';
import '../favorite_videos/favorite_videos_screen.dart';
import '../home/home_screen_Widgets.dart';
import 'PlayVideoScreen.dart';

class AllVideoScreen extends StatefulWidget {
  const AllVideoScreen({super.key});

  @override
  State<AllVideoScreen> createState() => _AllVideoScreenState();
}

class _AllVideoScreenState extends State<AllVideoScreen> {
  var homeController = Get.put(HomeController());
  final _playlistController = TextEditingController();

  @override
  void initState() {
    homeController.getAllAlbums;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var view = HomeWidgets(context);
    return Scaffold(
      body: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(
              children: [
                view.searchView(
                  controller: homeController.searchController,
                  hint: "Search title.. ",
                  onFilterTap: () {
                    view.openPopMenu(
                        context: context,
                        view: view,
                        homeController: homeController);
                  },
                  onChange: (value) async {
                    if (value == null || value.isEmpty) {
                      homeController.getAllVideos;
                    } else {
                      var data =
                          await homeController.albumList.first.listMedia();
                      homeController.videoList?.value = data.items
                          .where((element) =>
                              element.title
                                  ?.toLowerCase()
                                  .contains(value.toLowerCase().trim()) ??
                              true)
                          .toList();
                    }
                  },
                ),
                CircleAvatar(
                    backgroundColor: AppColor.soft,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: AppColor.orange,
                      ),
                      highlightColor: AppColor.darkGray,
                      onPressed: () {
                        context.push(const FavoriteVideosScreen());
                      },
                    )),
                20.width
              ],
            ),
            Obx(
              () => view.albumListView(
                albumList: homeController.albumList,
                currentIndex: homeController.currentAlbumIndex.value,
                onAlbumTap: (index) {
                  homeController.currentAlbumIndex.value = index;
                  homeController.getAllVideos;
                },
              ),
            ),
            5.height,
            Obx(
              () => view.allVideoListView(
                videoList: homeController.videoList ?? [],
                onVideoTap: (index) {
                  context.push(PlayVideoScreen(
                      medium: homeController.videoList![index]));
                },
                onMoreTap: (videoIndex) {
                  var favStatus = HiveStorage.checkFavStatus(
                      homeController.videoList![videoIndex].id ?? "");
                  view.showBottomSheetView(
                      context: context,
                      child: Column(
                        children: [
                          view.listItem(
                            title: favStatus == true
                                ? "Remove From Favorite"
                                : "Add to Favorite",
                            icon: favStatus == true
                                ? Icons.favorite_rounded
                                : Icons.favorite_border,
                            onTap: () async {
                              if (favStatus == false) {
                                HiveStorage.addToFavoriteVideo(
                                    FavoriteVideoModel(
                                        favoriteId:
                                            Random().nextInt(111111).toString(),
                                        fileName: homeController
                                            .videoList![videoIndex].title,
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                        songId: homeController
                                            .videoList![videoIndex].id));
                                context.pop;
                              } else {
                                HiveStorage.removeFromFavoriteVideo(
                                    homeController.videoList![videoIndex].id ??
                                        "");
                                context.pop;
                              }
                            },
                          ),
                          view.listItem(
                            title: "Add to playlist",
                            icon: Icons.create_new_folder,
                            onTap: () {
                              context.pop;
                              view.showBottomSheetView(
                                context: context,
                                child: Flexible(
                                  child: FutureBuilder<List<PlaylistModel>?>(
                                      future: HiveStorage.getAllPlayLists(),
                                      builder: (context, snapshot) {
                                        var playlists = snapshot.data ??
                                            List<PlaylistModel>.empty();
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (playlists.isNotEmpty) {
                                          return ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount: playlists.length,
                                            itemBuilder:
                                                (context, playlistIndex) {
                                              return view.listItem(
                                                title: "${playlists[playlistIndex].playlistName }",
                                                icon: Icons.folder_rounded,
                                                onTap: () async {
                                                  var a = await HiveStorage
                                                      .getAllPlaylistSongs(
                                                          playlists[
                                                              playlistIndex]);
                                                  var isExists = a
                                                      ?.where((element) =>
                                                          element.songId ==
                                                          homeController
                                                              .videoList?[
                                                                  videoIndex]
                                                              .id)
                                                      .isNotEmpty;
                                                  a?.forEach((element) {
                                                    element.toJson();
                                                  });
                                                  if (isExists == false) {
                                                    await HiveStorage.addNewSongToPlaylist(
                                                        PlaylistSongsModel(
                                                            playlistId: playlists[
                                                                    playlistIndex]
                                                                .playlistId,
                                                            fileName:
                                                                homeController
                                                                    .videoList![
                                                                        videoIndex]
                                                                    .title,
                                                            songId: homeController
                                                                .videoList![
                                                                    videoIndex]
                                                                .id));
                                                    showSnackBar(
                                                        title: "Success",
                                                        message: "Song Added Successfully");

                                                    context.pop;
                                                  } else {
                                                    showSnackBar(
                                                        title: "Already Exists",
                                                        message:
                                                            "This Song is Already Exists In This Playlist");
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        } else {
                                          return Center(
                                            child: Text("No Playlist Exists.."),
                                          );
                                        }
                                      }),
                                ),
                              );
                            },
                          ),
                          view.listItem(
                            title: "Create New Playlist",
                            icon: Icons.playlist_add,
                            onTap: () {
                              context.pop;
                              view.showAlertDialog(
                                context: context,
                                bgColor: AppColor.soft,
                                child: view.newPlaylistDialogView(
                                  controller: _playlistController,
                                  onCreateTap: () async {
                                    var playlists =
                                        await HiveStorage.getAllPlayLists();
                                    var isAlreadyExists = playlists
                                        ?.where((element) =>
                                            element.playlistName ==
                                            _playlistController.text)
                                        .isNotEmpty;
                                    playlists?.forEach((element) {
                                      print(element.toJson());
                                    });
                                    if (_playlistController.text
                                        .trim()
                                        .isEmpty) {
                                      showSnackBar(
                                          title: "Empty Field!",
                                          message: "Please Fill The Name");
                                    } else if (isAlreadyExists == false) {
                                      await HiveStorage.addNewPlaylist(
                                          PlaylistModel(
                                              playlistId: Random()
                                                  .nextInt(12345)
                                                  .toString(),
                                              playlistName:
                                                  _playlistController.text,
                                              createdAt: DateTime.now(),
                                              updatedAt: DateTime.now()));
                                      showSnackBar(
                                          title: "Success",
                                          message: "Playlist Added",
                                          color: AppColor.green);
                                      _playlistController.clear();

                                      context.pop;
                                    } else {
                                      showSnackBar(
                                          title: "Playlist Exists",
                                          message: "Playlist Already Exists",
                                          color: AppColor.green);
                                      _playlistController.clear();
                                    }
                                  },
                                  onCancelTap: () {
                                    context.pop;
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ));
                },
              ),
            ),
          ]),
    );
  }
}
