import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/constants/url_constants.dart';
import '../modules/movie_detail/controllers/movie_detail_controller.dart';
import '../routes/app_pages.dart';

class PosterMovieWidget extends StatelessWidget {
  final int idMovie;
  final dynamic movieData;
  final bool? isRecommended;
  const PosterMovieWidget(
      {super.key,
      required this.movieData,
      required this.idMovie,
      this.isRecommended});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isRecommended ?? false) {
          Get.delete<MovieDetailController>();
          Get.offNamedUntil(Routes.MOVIE_DETAIL, (route) => true, arguments: {
            'randId': idMovie,
            'id': movieData.id,
            'title': movieData!.title,
            'posterUrl':
                UrlConstants.imageMovieTheMovieDB(movieData!.posterPath)
          });
          return;
        }
        Get.toNamed(Routes.MOVIE_DETAIL, arguments: {
          'randId': idMovie,
          'id': movieData.id,
          'title': movieData!.title,
          'posterUrl': UrlConstants.imageMovieTheMovieDB(movieData!.posterPath)
        });
      },
      child: Hero(
        tag: idMovie,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: UrlConstants.imageMovieTheMovieDB(movieData!.posterPath),
            placeholder: (context, url) => const SizedBox(
              height: 50,
              width: 50,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.error, size: 32),
            ),
          ),
        ),
      ),
    );
  }
}
