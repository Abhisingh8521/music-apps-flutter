import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/services/app_hive_db/app_hive_db_service.dart';
import '../../../controllers/services/app_storage_services/videos/app_storage_service.dart';
import '../../../models/favorite_videos/favorite_video_model.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_constants/text_constants.dart';
import '../../utils/app_styles/app_styles.dart';
import '../home/home_screen_Widgets.dart';
import '../movies/PlayVideoScreen.dart';

class FavoriteVideosScreen extends StatefulWidget {
  const FavoriteVideosScreen({super.key});

  @override
  State<FavoriteVideosScreen> createState() => _FavoriteVideosScreenState();
}

class _FavoriteVideosScreenState extends State<FavoriteVideosScreen> {
  @override
  Widget build(BuildContext context) {
    var view = HomeWidgets(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: AppColor.white),
        backgroundColor: AppColor.soft,
        title: const Text(favoriteVideoScreenTitle,style: defaultTextStyle,),
      ),
      body: FutureBuilder<List<FavoriteVideoModel>?>(
        future: HiveStorage.getAllFavoriteVideos(),
        builder: (context, snapshot) {
          var favVideoModelList =
              snapshot.data ?? List<FavoriteVideoModel>.empty();
          if (snapshot.data == null) {
            return Center(
              child: progressIndicator,
            );
          }
          if (favVideoModelList.isEmpty) {
            return const Center(
              child: Text("No Videos in your Favorites"),
            );
          }
          return ListView.builder(
            itemCount: favVideoModelList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return FutureBuilder<Medium>(
                  future: AppStorageService.getMedium(
                      favVideoModelList[index].songId ?? ""),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text(""),
                      );
                    }
                    var video = snapshot.data;
                    return view.videoItem(
                      video: video!,
                      onVideoTap: () {
                        context.push(PlayVideoScreen(medium: video));
                      },
                      onMoreTap: () {
                        view.showBottomSheetView(
                            context: context,
                            child: Column(
                              children: [
                                view.listItem(
                                  title: "Remove From Favorite",
                                  icon: Icons.favorite_rounded ,
                                  onTap: () async {
                                      HiveStorage.removeFromFavoriteVideo(video.id);
                                      setState(() {});
                                      context.pop;},),

                              ],
                            ));
                      },
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
