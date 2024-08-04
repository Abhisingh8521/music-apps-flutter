import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/controllers/playlist/playlist_controller.dart';
import '../../../controllers/services/app_hive_db/app_hive_db_service.dart';
import '../../utils/app_colors/app_colors.dart';
import '../home/home_screen_Widgets.dart';
import '../movies/PlayVideoScreen.dart';


class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  PlaylistController controller = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    var view = HomeWidgets(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          view.searchView(
            controller: controller.playlistSearchController,
            hint: "search title.. ",
            endIcon: FontAwesomeIcons.edit,
            onFilterTap: () {
              controller.editPlaylistController.text = controller.selectedPlaylist.playlistName ?? "";
              view.showAlertDialog(
                  context: context,
                  child: view.newPlaylistDialogView(
                      controller: controller.editPlaylistController,
                      onCreateTap: () {
                        controller.selectedPlaylist.playlistName = controller.editPlaylistController.text;
                        HiveStorage.updatePlaylist(controller.selectedPlaylist);
                        showSnackBar(title: "Update Success", message: "Playlist Updated Successfully");
                      },
                      title: "Edit Playlist",
                      onCancelTap: () {
                        context.pop;
                      },));
            },
            onChange: controller.searchVideo,
          ),
          Obx(
            () => SizedBox(
                height: context.screenHeight * 0.05,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => 20.width,
                  itemCount: controller.videoPlaylists.length,
                  itemBuilder: (context, index) {
                    return Obx(() => Center(
                        child: Container(
                            height: double.minPositive,
                            constraints: const BoxConstraints(
                                minWidth: 50, minHeight: 30, maxHeight: 50),
                            child: GestureDetector(
                              onTap: () {
                                controller.updateCurrentPlaylist(index);
                                controller.getAllVideos();
                              },
                              child: PhysicalModel(
                                  color: controller.isSelectedIndex(index)
                                      ? AppColor.blueAccent
                                      : AppColor.soft,
                                  borderRadius: 9.borderRadius,
                                  shape: BoxShape.rectangle,
                                  elevation: 0,
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.playlist_play,
                                          color: AppColor.white,
                                        ),
                                        10.width,
                                        Text(controller.videoPlaylists[index]
                                                .playlistName ??
                                            ""),
                                      ],
                                    ),
                                  ))),
                            ))));
                  },
                )),
          ),
          Obx(() => SizedBox(
                height: context.screenHeight * 0.9,
                child: ListView.separated(
                  itemCount: controller.allVideoList.length,
                  separatorBuilder: (context, index) => 10.height,
                  itemBuilder: (context, index) {
                    return Obx(() => view.videoItem(
                          video: controller.allVideoList[index],
                          onVideoTap: () {
                            context.push(PlayVideoScreen(
                                medium: controller.allVideoList[index]));
                          },
                        ));
                  },
                ),
              ))
          // FutureBuilder<List<PlaylistModel>?>(
          //   initialData: null,
          //
          //   future: HiveStorage.getAllPlayLists(),
          //   builder: (context, snapshot) {
          //     var playlists = snapshot.data ?? List<PlaylistModel>.empty();
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(child: progressIndicator);
          //     }
          //     if (playlists.isEmpty) {
          //       return const Center(child: Text("no playlists exists.."));
          //     }
          //     return ListView.separated(
          //       physics: const BouncingScrollPhysics(),
          //       shrinkWrap: true,
          //       separatorBuilder: (context, index) => 20.height,
          //       itemCount: playlists.length,
          //       itemBuilder: (context, index) {
          //         return Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 10),
          //             child: ListTile(
          //               leading:
          //                   Icon(Icons.folder_rounded, color: AppColor.white),
          //               trailing: IconButton(
          //                 icon: Icon(Icons.edit, color: AppColor.white),
          //                 onPressed: () {
          //                   _editPlaylistController.text = playlists[index].playlistName ?? "";
          //                   view.showAlertDialog(
          //                       context: context,
          //                       child: view.newPlaylistDialogView(
          //                           controller: _editPlaylistController,
          //                           onCreateTap: () {
          //                           if(_editPlaylistController.text.trim().isEmpty) {
          //                             showSnackBar(title: "Empty Field !", message: "Please fill name..");
          //                           }else{
          //                             playlists[index].playlistName = _editPlaylistController.text;
          //                             HiveStorage.addNewPlaylist(playlists[index]);
          //                             setState(() {});
          //                             context.pop;
          //                           }
          //
          //                           },
          //                           onCancelTap: () {
          //                             context.pop;
          //                           },));
          //                 },
          //               ),
          //               onTap: () {
          //                 context.push(PlaylistItemsScreen(playlistModel: playlists[index]));
          //               },
          //               title: Text(
          //                 playlists[index].playlistName ?? "",
          //                 style: defaultTextStyle,
          //               ),
          //               tileColor: AppColor.soft,
          //               shape: 10.shapeBorderRadius,
          //             ));
          //       },
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
