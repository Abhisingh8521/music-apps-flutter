import 'package:flutter/material.dart';
import 'package:test_p/views/utils/app_extensions/app_extensions.dart';

import '../../../models/movies/movie_data_model.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_constants/image_constants.dart';

class MovieItem extends StatelessWidget {
  MovieItem({super.key, required this.movieItem});

  Result? movieItem;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: AppColor.darkGray,
      shape: BoxShape.rectangle,
      borderRadius: 15.borderRadius,
      child: ClipRRect( borderRadius: 15.borderRadius, child: networkImage(path:movieItem?.primaryImage?.url ?? defaultMovieImage,fit: BoxFit.cover,width: 150,height: 250)),
    );
  }
}
