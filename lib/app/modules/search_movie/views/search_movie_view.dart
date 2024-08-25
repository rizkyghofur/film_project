import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:get/get.dart';

import '../../../widgets/poster_movie_widget.dart';
import '../controllers/search_movie_controller.dart';

class SearchMovieView extends GetView<SearchMovieController> {
  const SearchMovieView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (query) => controller.fetchSearchMovie(query),
          onSubmitted: (query) => controller.fetchSearchMovie(query),
          decoration: const InputDecoration(
            hintText: "Search Movie",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
          ),
        ),
        centerTitle: Platform.isIOS,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Obx(
          () => controller.isLoading.value
              ? ListView(
                  children: [
                    for (int i = 0; i < 10; i++) const ProfileShimmer(),
                  ],
                )
              : controller.hasError.value
                  ? const Center(
                      child:
                          Text('Something went wrong, please try again later'),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 2 / 3,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      itemCount: controller.searchMovieList.length,
                      itemBuilder: (context, index) {
                        int randomNumber = controller.random.nextInt(9999);
                        int idMovie = controller.searchMovieList[index].id! +
                            randomNumber;
                        return PosterMovieWidget(
                          idMovie: idMovie,
                          movieData: controller.searchMovieList[index],
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
