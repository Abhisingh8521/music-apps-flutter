
import 'package:hive/hive.dart';

part 'favorite_video_model.g.dart';
@HiveType(typeId: 2)
class FavoriteVideoModel{
  @HiveField(0)
 String? favoriteId;
  @HiveField(1)
 String? songId;
  @HiveField(2)
 String? fileName;
  @HiveField(3)
 DateTime? createdAt;
  @HiveField(4)
 DateTime? updatedAt;

  FavoriteVideoModel({this.favoriteId,this.fileName,this.songId,this.createdAt,this.updatedAt});

}