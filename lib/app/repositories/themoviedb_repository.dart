import 'package:dio/dio.dart';

import '../data/constants/url_constants.dart';
import '../data/models/responses/movie_detail_response.dart';
import '../data/models/responses/now_playing_movies_response.dart';
import '../data/models/responses/popular_movies_response.dart';
import '../data/models/responses/recommended_movies_response.dart';
import '../data/models/responses/search_result_movies_response.dart';
import '../data/models/responses/top_rated_movies_response.dart';
import '../data/models/responses/upcoming_movies_response.dart';

class TheMovieDBRepository {
  final Dio dio = Dio();

  Future<NowPlayingMoviesResponse> getNowPlayingMovies(String page) async {
    try {
      Response response =
          await dio.get(UrlConstants.nowPlayingTheMovieDB(page));
      var data = Map<String, dynamic>.from(response.data);
      var fetchedResponse = NowPlayingMoviesResponse.fromJson(data);
      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<PopularMoviesResponse> getPopularMovies(String page) async {
    try {
      Response response = await dio.get(UrlConstants.popularTheMovieDB(page));
      var data = Map<String, dynamic>.from(response.data);
      var fetchedResponse = PopularMoviesResponse.fromJson(data);
      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<RecommendedMoviesResponse> getRecommendedMovies(String movieId) async {
    try {
      Response response =
          await dio.get(UrlConstants.recommendationTheMovieDB(movieId));
      var data = Map<String, dynamic>.from(response.data);
      var fetchedResponse = RecommendedMoviesResponse.fromJson(data);
      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<TopRatedMovieResponse> getTopRatedMovies(String page) async {
    try {
      Response response = await dio.get(UrlConstants.topRatedTheMovieDB(page));
      var data = Map<String, dynamic>.from(response.data);
      var fetchedResponse = TopRatedMovieResponse.fromJson(data);
      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<UpcomingMovieResponse> getUpcomingMovies(String page) async {
    try {
      Response response = await dio.get(UrlConstants.upcomingTheMovieDB(page));
      var data = Map<String, dynamic>.from(response.data);
      var fetchedResponse = UpcomingMovieResponse.fromJson(data);
      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieDetailResponse> getMovieDetail(String movieId) async {
    try {
      Response response =
          await dio.get(UrlConstants.detailMovieTheMovieDB(movieId));
      var data = Map<String, dynamic>.from(response.data);
      var fetchedResponse = MovieDetailResponse.fromJson(data);
      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<SearchResultMoviesResponse> searchMovies(String query) async {
    try {
      Response response =
          await dio.get(UrlConstants.searchMovieTheMovieDB(query));
      var data = Map<String, dynamic>.from(response.data);
      var fetchedResponse = SearchResultMoviesResponse.fromJson(data);
      return fetchedResponse;
    } catch (e) {
      rethrow;
    }
  }
}
