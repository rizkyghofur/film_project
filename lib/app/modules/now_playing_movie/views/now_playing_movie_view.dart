import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../widgets/poster_movie_widget.dart';
import '../controllers/now_playing_movie_controller.dart';

class NowPlayingMovieView extends GetView<NowPlayingMovieController> {
  const NowPlayingMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Movies'),
        centerTitle: Platform.isIOS,
      ),
      body: Obx(
        () => LazyLoadScrollView(
          isLoading: controller.isLoading.value,
          onEndOfPage: () => controller.loadMoreData(),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 2 / 3,
            ),
            padding: const EdgeInsets.all(8.0),
            itemCount: controller.nowPlayingMovieList.length,
            itemBuilder: (context, index) {
              int randomNumber = controller.random.nextInt(9999);
              int idMovie =
                  controller.nowPlayingMovieList[index].id! + randomNumber;
              return PosterMovieWidget(
                idMovie: idMovie,
                movieData: controller.nowPlayingMovieList[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
