import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';
import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';

import '../../../core/utils/format_duration.dart';
import '../../../data/constants/url_constants.dart';
import '../../../widgets/poster_movie_widget.dart';
import '../controllers/movie_detail_controller.dart';

class MovieDetailView extends GetView<MovieDetailController> {
  const MovieDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        centerTitle: Platform.isIOS,
      ),
      bottomSheet: InteractiveBottomSheet(
        options: InteractiveBottomSheetOptions(
          backgroundColor: AdaptiveTheme.of(context).mode.isDark
              ? Colors.black
              : Colors.white,
          initialSize: 0.25,
          maxSize: 0.75,
          snapList: [0.25, 0.5],
        ),
        draggableAreaOptions: DraggableAreaOptions(
          backgroundColor: AdaptiveTheme.of(context).mode.isDark
              ? Colors.black
              : Colors.white,
          topBorderRadius: 10,
          height: 40,
          indicatorColor: AdaptiveTheme.of(context).mode.isDark
              ? Colors.white
              : Colors.grey,
          indicatorWidth: 50,
          indicatorHeight: 10,
          indicatorRadius: 10,
        ),
        child: FutureBuilder(
          future: controller.fGetDetailMovie,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 40,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const SizedBox(
                  height: 40,
                  child: Center(
                    child: Text("Something went wrong, please try again later"),
                  ),
                );
              }

              var detailMovie = snapshot.data!;
              var dur = Duration(
                minutes: detailMovie.runtime!,
              );

              String genres = detailMovie.genres!.map((e) => e.name).join(", ");
              String releaseYear = detailMovie.releaseDate!.substring(0, 4);
              String duration = FormatDuration.formatDuration(dur);
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      detailMovie.title!,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          "$releaseYear ",
                          softWrap: true,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          duration,
                          softWrap: true,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (detailMovie.adult!)
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            color: Colors.red,
                            child: const Text(
                              "A",
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ],
                    ),
                    Text(
                      genres,
                      softWrap: true,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: detailMovie.voteAverage! / 2,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          itemSize: 25,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            // do nothing here
                          },
                        ),
                        Text((detailMovie.voteAverage! / 2).toStringAsFixed(2))
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Overview",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      detailMovie.overview!,
                      softWrap: true,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Recommended For You",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder(
                      future: controller.fGetRecommendedMovies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return VideoShimmer(
                            isRectBox: true,
                            hasBottomBox: true,
                            isDarkMode: AdaptiveTheme.of(context).mode.isDark,
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                    "Something went wrong, please try again later"),
                              ),
                            );
                          }
                          var recommendedMovies = snapshot.data!.results;
                          if (recommendedMovies!.isEmpty) {
                            return const SizedBox(
                              height: 40,
                              child: Center(
                                child:
                                    Text("No recommendation for you right now"),
                              ),
                            );
                          }
                          return SizedBox(
                            width: Get.width,
                            height: Get.height / 4,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: recommendedMovies.length,
                              itemBuilder: (context, index) {
                                int randomNumber =
                                    controller.random.nextInt(9999);
                                int idMovie =
                                    recommendedMovies[index].id! + randomNumber;
                                return PosterMovieWidget(
                                  idMovie: idMovie,
                                  isRecommended: true,
                                  movieData: recommendedMovies[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(width: 10);
                              },
                            ),
                          );
                        } else {
                          return const SizedBox(
                            height: 40,
                            child: Center(
                              child: Text(
                                  "Something went wrong, please try again later"),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              );
            } else {
              return const SizedBox(
                height: 40,
                child: Center(
                  child: Text("Something went wrong, please try again later"),
                ),
              );
            }
          },
        ),
      ),
      body: Hero(
        tag: controller.randId,
        child: CachedNetworkImage(
          imageUrl: UrlConstants.imageMovieTheMovieDB(controller.imagePoster),
          placeholder: (context, url) => const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(Icons.error, size: 32),
          ),
        ),
      ),
    );
  }
}
