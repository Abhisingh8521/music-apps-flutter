// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_video_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteVideoModelAdapter extends TypeAdapter<FavoriteVideoModel> {
  @override
  final int typeId = 2;

  @override
  FavoriteVideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteVideoModel(
      favoriteId: fields[0] as String?,
      fileName: fields[2] as String?,
      songId: fields[1] as String?,
      createdAt: fields[3] as DateTime?,
      updatedAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteVideoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.favoriteId)
      ..writeByte(1)
      ..write(obj.songId)
      ..writeByte(2)
      ..write(obj.fileName)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is FavoriteVideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
