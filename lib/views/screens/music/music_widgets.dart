import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../utils/app_colors/app_colors.dart';

class MusicWidgets {
  BuildContext context;

  MusicWidgets(this.context);

  Widget musicItem(
      {required SongModel songModel,
      required bool isSelected,
      void Function()? onItemTap,
      required void Function()? onPlayTap,
      required bool isPlaying}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: AnimatedContainer(
        duration: const Duration(microseconds: 500),
        child: ListTile(
          selectedTileColor: AppColor.orange,
          selected: isSelected,
          shape: 10.shapeBorderRadius,
          tileColor: AppColor.soft,
          title: Text(
            songModel.title,
            style: TextStyle(color: AppColor.lineDark, fontSize: 12),
            maxLines: 2,
          ),
          subtitle: Text(
            songModel.artist ?? "",
            maxLines: 1,
            style: TextStyle(color: AppColor.gray),
          ),
          // leading: CircleAvatar(backgroundColor:isSelected  ?AppColor.soft:AppColor.blueAccent,child:const Icon(Icons.music_note)),
          leading: QueryArtworkWidget(id: songModel.id, type: ArtworkType.AUDIO,artworkFit: BoxFit.cover,format: ArtworkFormat.PNG,artworkQuality: FilterQuality.high,artworkBorder: 10.borderRadius,),

          trailing: CircleAvatar(
              backgroundColor: AppColor.soft,
              child: IconButton(
                onPressed: onPlayTap,
                icon: Icon(
                  isPlaying && isSelected ? Icons.pause : Icons.play_arrow,
                  color: AppColor.blueAccent,
                ),
                highlightColor: AppColor.gray,
              )),
          onTap: onItemTap,
        ),
      ),
    );
  }
}
