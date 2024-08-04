// To parse this JSON data, do
//
//     final playlistSongsModel = playlistSongsModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'playlist_songs.g.dart';
PlaylistSongsModel playlistSongsModelFromJson(String str) => PlaylistSongsModel.fromJson(json.decode(str));

String playlistSongsModelToJson(PlaylistSongsModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class PlaylistSongsModel {
  @HiveField(0)
  String? songId;
  @HiveField(1)
  String? fileName;
  @HiveField(2)
  String? playlistId;
  PlaylistSongsModel({
    this.songId,
    this.fileName,
    this.playlistId,
  });
  factory PlaylistSongsModel.fromJson(Map<String, dynamic> json) => PlaylistSongsModel(
    songId: json["songId"],
    fileName: json["fileName"],
    playlistId: json["playlistId"],
  );
  Map<String, dynamic> toJson() => {
    "songId": songId,
    "fileName": fileName,
    "playlistId": playlistId,
  };
}
