import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/services/app_hive_db/app_hive_db_service.dart';
import '../../../models/playlist/playlist_model.dart';
import '../../../models/playlist/playlist_songs.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_styles/app_styles.dart';
import '../home/home_screen_Widgets.dart';
import '../movies/PlayVideoScreen.dart';

class PlaylistItemsScreen extends StatefulWidget {
  PlaylistItemsScreen({super.key, required this.playlistModel});

  PlaylistModel playlistModel;

  @override
  State<PlaylistItemsScreen> createState() => _PlaylistItemsScreenState();
}

class _PlaylistItemsScreenState extends State<PlaylistItemsScreen> {
  List<PlaylistSongsModel>? songs = [];

  @override
  void initState() {
    getAllSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var view = HomeWidgets(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColor.white),
        backgroundColor: AppColor.dark,
        title: Text(
          widget.playlistModel.playlistName ?? "",
          style: defaultTextStyle,
        ),
      ),
      body: FutureBuilder<List<Medium>>(
        future: getAllSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: progressIndicator);
          }
          var videoList = snapshot.data ?? List<Medium>.empty();
          if (videoList.isEmpty) {
            return const Center(
                child: Text("no videos available in this playlist"));
          }
          return view.allVideoListView(
            videoList: videoList,
            onVideoTap: (index) {
              context.push(PlayVideoScreen(medium: videoList[index]));
            },
            onMoreTap: (index) {
              view.showBottomSheetView(
                  context: context,
                  child: Column(
                    children: [
                      view.listItem(
                        title: "remove from playlist",
                        onTap: () {
                          HiveStorage.removeSongFromPlaylist(
                              songs?[index].songId ?? "");
                          setState(() {});
                          context.pop;
                        },
                      )
                    ],
                  ));
            },
          );
        },
      ),
    );
  }

  Future<List<Medium>> getAllSongs() async {
    var dataList = <Medium>[];
    songs = await HiveStorage.getAllPlaylistSongs(widget.playlistModel);
    for (var element in songs ?? []) {
      var data = await PhotoGallery.getMedium(mediumId: element.songId ?? "");
      dataList.add(data);
    }
    ;
    print(dataList.length);
    return dataList;
  }
}
