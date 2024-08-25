import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/movie_detail/bindings/movie_detail_binding.dart';
import '../modules/movie_detail/views/movie_detail_view.dart';
import '../modules/now_playing_movie/bindings/now_playing_movie_binding.dart';
import '../modules/now_playing_movie/views/now_playing_movie_view.dart';
import '../modules/popular_movie/bindings/popular_movie_binding.dart';
import '../modules/popular_movie/views/popular_movie_view.dart';
import '../modules/search_movie/bindings/search_movie_binding.dart';
import '../modules/search_movie/views/search_movie_view.dart';
import '../modules/toprated_movie/bindings/toprated_movie_binding.dart';
import '../modules/toprated_movie/views/toprated_movie_view.dart';
import '../modules/upcoming_movie/bindings/upcoming_movie_binding.dart';
import '../modules/upcoming_movie/views/upcoming_movie_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_DETAIL,
      page: () => const MovieDetailView(),
      binding: MovieDetailBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_MOVIE,
      page: () => const SearchMovieView(),
      binding: SearchMovieBinding(),
    ),
    GetPage(
      name: _Paths.NOW_PLAYING_MOVIE,
      page: () => const NowPlayingMovieView(),
      binding: NowPlayingMovieBinding(),
    ),
    GetPage(
      name: _Paths.POPULAR_MOVIE,
      page: () => const PopularMovieView(),
      binding: PopularMovieBinding(),
    ),
    GetPage(
      name: _Paths.TOPRATED_MOVIE,
      page: () => const TopratedMovieView(),
      binding: TopratedMovieBinding(),
    ),
    GetPage(
      name: _Paths.UPCOMING_MOVIE,
      page: () => const UpcomingMovieView(),
      binding: UpcomingMovieBinding(),
    ),
  ];
}
