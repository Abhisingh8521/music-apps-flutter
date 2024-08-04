import 'package:flutter/material.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/services/api_services/movie_api_service.dart';
import '../../../models/movies/movie_data_model.dart';
import 'movie_item.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child:const Icon(Icons.get_app),
      ),
      body: FutureBuilder<ApiMovieDataModel>(
                future: MovieApi.getMovieByPage(),
                builder: (context, snapshot) {
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
                  itemCount: snapshot.data!.results?.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    childAspectRatio: 200 / 300,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return MovieItem(movieItem: snapshot.data!.results?[index]);
                  },
                ),
              );
            }
                  return Center(
                      child: progressIndicator,
            );
                }),);

  }
}
