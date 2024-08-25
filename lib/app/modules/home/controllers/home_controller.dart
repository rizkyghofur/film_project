import 'dart:math';

import 'package:get/get.dart';

import '../../../data/models/responses/now_playing_movies_response.dart';
import '../../../data/models/responses/popular_movies_response.dart';
import '../../../data/models/responses/top_rated_movies_response.dart';
import '../../../data/models/responses/upcoming_movies_response.dart';
import '../../../services/themoviedb_service.dart';

class HomeController extends GetxController {
  TheMovieDBService theMovieDBService = TheMovieDBService();
  Future<NowPlayingMoviesResponse>? fGetNowPlayingMovies;
  Future<PopularMoviesResponse>? fGetPopularMovies;
  Future<TopRatedMovieResponse>? fGetTopRatedMovies;
  Future<UpcomingMovieResponse>? fGetUpcomingMovies;
  Random random = Random();

  @override
  void onInit() {
    fGetNowPlayingMovies = theMovieDBService.getNowPlayingMovies('1');
    fGetPopularMovies = theMovieDBService.getPopularMovies('1');
    fGetTopRatedMovies = theMovieDBService.getTopRatedMovies('1');
    fGetUpcomingMovies = theMovieDBService.getUpcomingMovies('1');
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

  Future<void> refreshAllData() async {
    fGetNowPlayingMovies = theMovieDBService.getNowPlayingMovies('1');
    fGetPopularMovies = theMovieDBService.getPopularMovies('1');
    fGetTopRatedMovies = theMovieDBService.getTopRatedMovies('1');
    fGetUpcomingMovies = theMovieDBService.getUpcomingMovies('1');
    update();
  }
}
