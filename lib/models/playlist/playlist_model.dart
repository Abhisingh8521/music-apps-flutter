import 'dart:convert';
import 'package:hive/hive.dart';

part 'playlist_model.g.dart';

PlaylistModel playlistModelFromJson(String str) =>
    PlaylistModel.fromJson(json.decode(str));

// List<String> playlistModelToJson(List<PlaylistModel> data) => data.map((e) => json.encode(e.toJson()).toString()).toList();

@HiveType(typeId: 0)
class PlaylistModel {
  @HiveField(0)
  String? playlistId;
  @HiveField(1)
  String? playlistName;
  @HiveField(2)
  DateTime? createdAt;
  @HiveField(3)
  DateTime? updatedAt;

  PlaylistModel({
    this.playlistId,
    this.playlistName,
    this.createdAt,
    this.updatedAt,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
        playlistId: json["playlistId"],
        playlistName: json["playlistName"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "playlistId": playlistId,
        "playlistName": playlistName,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
