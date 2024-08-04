import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_p/views/screens/movies/video_item.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/services/app_storage_services/videos/app_storage_service.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  @override
  void initState() {
    AppStorageService.getVideosPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {

          });
          print("data".toString());
        },
        child: const Icon(Icons.get_app),
      ),
      body: FutureBuilder<List<PlatformFile>?>(
          initialData: [],
          future: AppStorageService.pickVideoFiles(),
          builder: (context, snapshot) {
            print(snapshot.data?.toList());

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: progressIndicator,
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('no movies exists'),
              );
            }
            if (snapshot.hasData && snapshot.data != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: snapshot.data?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    childAspectRatio: 200 / 300,
                    mainAxisSpacing: 15,),
                  itemBuilder: (context, index) {
                    return VideoItem(movieItem: snapshot.data?[index]);
                  },
                ),
              );
            }
            return Center(child: progressIndicator,);
          }),
    );
  }
}
