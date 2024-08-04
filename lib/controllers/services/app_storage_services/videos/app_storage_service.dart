import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_gallery/photo_gallery.dart';

class AppStorageService {
  static Future<List<PlatformFile>?> pickVideoFiles() async {
    var res = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.video,
    );
    return res?.files;
  }

  static Future<Medium> getMedium(String id) async{
    return PhotoGallery.getMedium(mediumId: id);
  }
  static Future getVideosPath() async {
    var a = await getExternalStorageDirectory();
    var res = a
        ?.listSync(recursive: true)
        .toList()
        .where((element) => element.path.endsWith('.mp4'))
        .toList();
    return res;
  }

  static Future<List<Album>> getAllVideoAlbums() async {
    return PhotoGallery.listAlbums(
        hideIfEmpty: false, mediumType: MediumType.video);
  }

  static Future<List<Medium>?> getAllVideosFromAlbum(
      {required Album album}) async {
    var allMedia = await album.listMedia();
    var allVideos = allMedia.items;
    return allVideos;
  }
}
