
import 'package:permission_handler/permission_handler.dart';

class AppPermissionHandler{
 static Future<bool> get requestStoragePermission async {
    var status = await Permission.storage.request();
   var video = await Permission.videos.request();
    if(status.isGranted){
      return true;
    }
    else if(status.isGranted == false){
     await Permission.storage.request();
     return true;
    }else if(status.isDenied){
      await openAppSettings();
      return false;
    }else if(status.isPermanentlyDenied){
      await openAppSettings();
      return true;
    }
    return true;
  }
}