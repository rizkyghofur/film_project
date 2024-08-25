import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';

import '../../../data/models/responses/now_playing_movies_response.dart';
import '../../../data/models/responses/popular_movies_response.dart';
import '../../../data/models/responses/top_rated_movies_response.dart';
import '../../../data/models/responses/upcoming_movies_response.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/poster_movie_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text('Switch Theme'),
                trailing: Switch(
                  activeColor: Colors.grey,
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  value: AdaptiveTheme.of(context).mode.isDark,
                  onChanged: (value) {
                    if (value) {
                      AdaptiveTheme.of(context).setDark();
                    } else {
                      AdaptiveTheme.of(context).setLight();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Film Project'),
        centerTitle: Platform.isIOS,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.SEARCH_MOVIE);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshAllData(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Now Playing',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.NOW_PLAYING_MOVIE);
                      },
                      child: const Text(
                        ">> See more",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: FutureBuilder(
                    future: controller.fGetNowPlayingMovies,
                    builder: (context,
                        AsyncSnapshot<NowPlayingMoviesResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return VideoShimmer(
                          isRectBox: true,
                          hasBottomBox: true,
                          isDarkMode: AdaptiveTheme.of(context).mode.isDark,
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasData) {
                          var nowPlayingMovieData = snapshot.data!.results;
                          if (nowPlayingMovieData!.isEmpty) {
                            return const Center(
                              child: Text(
                                  'The Movie is empty for now, please try again later'),
                            );
                          }
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: nowPlayingMovieData.length,
                            itemBuilder: (context, index) {
                              int randomNumber =
                                  controller.random.nextInt(9999);
                              int idMovie =
                                  nowPlayingMovieData[index].id! + randomNumber;
                              return PosterMovieWidget(
                                idMovie: idMovie,
                                movieData: nowPlayingMovieData[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 10);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                                'Something went wrong, please try again later'),
                          );
                        }
                      } else {
                        return const Center(
                          child: Text(
                              'Something went wrong, please try again later'),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.POPULAR_MOVIE);
                      },
                      child: const Text(
                        ">> See more",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: FutureBuilder(
                    future: controller.fGetPopularMovies,
                    builder: (context,
                        AsyncSnapshot<PopularMoviesResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return VideoShimmer(
                          isRectBox: true,
                          hasBottomBox: true,
                          isDarkMode: AdaptiveTheme.of(context).mode.isDark,
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasData) {
                          var popularMovieData = snapshot.data!.results;
                          if (popularMovieData!.isEmpty) {
                            return const Center(
                              child: Text(
                                  'The Movie is empty for now, please try again later'),
                            );
                          }
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: popularMovieData.length,
                            itemBuilder: (context, index) {
                              int randomNumber =
                                  controller.random.nextInt(9999);
                              int idMovie =
                                  popularMovieData[index].id! + randomNumber;
                              return PosterMovieWidget(
                                idMovie: idMovie,
                                movieData: popularMovieData[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 10);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                                'Something went wrong, please try again later'),
                          );
                        }
                      } else {
                        return const Center(
                          child: Text(
                              'Something went wrong, please try again later'),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Rated',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.TOPRATED_MOVIE);
                      },
                      child: const Text(
                        ">> See more",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: FutureBuilder(
                    future: controller.fGetTopRatedMovies,
                    builder: (context,
                        AsyncSnapshot<TopRatedMovieResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return VideoShimmer(
                          isRectBox: true,
                          hasBottomBox: true,
                          isDarkMode: AdaptiveTheme.of(context).mode.isDark,
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasData) {
                          var topRatedMovieData = snapshot.data!.results;
                          if (topRatedMovieData!.isEmpty) {
                            return const Center(
                              child: Text(
                                  'The Movie is empty for now, please try again later'),
                            );
                          }
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: topRatedMovieData.length,
                            itemBuilder: (context, index) {
                              int randomNumber =
                                  controller.random.nextInt(9999);
                              int idMovie =
                                  topRatedMovieData[index].id! + randomNumber;
                              return PosterMovieWidget(
                                idMovie: idMovie,
                                movieData: topRatedMovieData[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 10);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                                'Something went wrong, please try again later'),
                          );
                        }
                      } else {
                        return const Center(
                          child: Text(
                              'Something went wrong, please try again later'),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upcoming',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.UPCOMING_MOVIE);
                      },
                      child: const Text(
                        ">> See more",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 250,
                  child: FutureBuilder(
                    future: controller.fGetUpcomingMovies,
                    builder: (context,
                        AsyncSnapshot<UpcomingMovieResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return VideoShimmer(
                          isRectBox: true,
                          hasBottomBox: true,
                          isDarkMode: AdaptiveTheme.of(context).mode.isDark,
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasData) {
                          var upcomingMovieData = snapshot.data!.results;
                          if (upcomingMovieData!.isEmpty) {
                            return const Center(
                              child: Text(
                                  'The Movie is empty for now, please try again later'),
                            );
                          }
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: upcomingMovieData.length,
                            itemBuilder: (context, index) {
                              int randomNumber =
                                  controller.random.nextInt(9999);
                              int idMovie =
                                  upcomingMovieData[index].id! + randomNumber;
                              return PosterMovieWidget(
                                idMovie: idMovie,
                                movieData: upcomingMovieData[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 10);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                                'Something went wrong, please try again later'),
                          );
                        }
                      } else {
                        return const Center(
                          child: Text(
                              'Something went wrong, please try again later'),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
