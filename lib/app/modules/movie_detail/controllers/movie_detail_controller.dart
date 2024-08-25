import 'dart:math';

import 'package:get/get.dart';

import '../../../data/models/responses/movie_detail_response.dart';
import '../../../data/models/responses/recommended_movies_response.dart';
import '../../../services/themoviedb_service.dart';

class MovieDetailController extends GetxController {
  TheMovieDBService theMovieDBService = TheMovieDBService();
  Future<MovieDetailResponse>? fGetDetailMovie;
  Future<RecommendedMoviesResponse>? fGetRecommendedMovies;
  String imagePoster = "", title = "";
  int id = 0, randId = 0;
  Random random = Random();

  @override
  void onInit() {
    final args = Get.arguments;
    imagePoster = args['posterUrl'];
    title = args['title'];
    id = args['id'];
    randId = args['randId'];

    fGetDetailMovie = theMovieDBService.getDetailMovie(id.toString());
    fGetRecommendedMovies =
        theMovieDBService.getRecommendedMovies(id.toString());

    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
}
