import '../data/models/responses/movie_detail_response.dart';
import '../data/models/responses/now_playing_movies_response.dart';
import '../data/models/responses/popular_movies_response.dart';
import '../data/models/responses/recommended_movies_response.dart';
import '../data/models/responses/search_result_movies_response.dart';
import '../data/models/responses/top_rated_movies_response.dart';
import '../data/models/responses/upcoming_movies_response.dart';
import '../repositories/themoviedb_repository.dart';

class TheMovieDBService {
  TheMovieDBRepository theMovieDBRepository = TheMovieDBRepository();

  Future<NowPlayingMoviesResponse> getNowPlayingMovies(String page) async {
    return await theMovieDBRepository.getNowPlayingMovies(page);
  }

  Future<PopularMoviesResponse> getPopularMovies(String page) async {
    return await theMovieDBRepository.getPopularMovies(page);
  }

  Future<TopRatedMovieResponse> getTopRatedMovies(String page) async {
    return await theMovieDBRepository.getTopRatedMovies(page);
  }

  Future<UpcomingMovieResponse> getUpcomingMovies(String page) async {
    return await theMovieDBRepository.getUpcomingMovies(page);
  }

  Future<RecommendedMoviesResponse> getRecommendedMovies(String movieId) async {
    return await theMovieDBRepository.getRecommendedMovies(movieId);
  }

  Future<MovieDetailResponse> getDetailMovie(String movieId) async {
    return await theMovieDBRepository.getMovieDetail(movieId);
  }

  Future<SearchResultMoviesResponse> searchMovies(String query) async {
    return await theMovieDBRepository.searchMovies(query);
  }
}
