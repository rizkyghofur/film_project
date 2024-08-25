import 'constants.dart';

class UrlConstants {
  static const urlTheMovieDB = "https://api.themoviedb.org/3";

  static String nowPlayingTheMovieDB(String page) =>
      "$urlTheMovieDB/movie/now_playing?page=$page&api_key=${Constants.apiKeyTheMovieDB}";
  static String popularTheMovieDB(String page) =>
      "$urlTheMovieDB/movie/popular?page=$page&api_key=${Constants.apiKeyTheMovieDB}";
  static String topRatedTheMovieDB(String page) =>
      "$urlTheMovieDB/movie/top_rated?page=$page&api_key=${Constants.apiKeyTheMovieDB}";
  static String upcomingTheMovieDB(String page) =>
      "$urlTheMovieDB/movie/upcoming?page=$page&api_key=${Constants.apiKeyTheMovieDB}";
  static String recommendationTheMovieDB(String movieId) =>
      "$urlTheMovieDB/movie/$movieId/recommendations?api_key=${Constants.apiKeyTheMovieDB}";
  static String detailMovieTheMovieDB(String movieId) =>
      "$urlTheMovieDB/movie/$movieId?api_key=${Constants.apiKeyTheMovieDB}";
  static String searchMovieTheMovieDB(query) =>
      "$urlTheMovieDB/search/movie?query={{$query}}&api_key=${Constants.apiKeyTheMovieDB}";
  static String imageMovieTheMovieDB(pathImage) =>
      "https://image.tmdb.org/t/p/w500$pathImage";
}
