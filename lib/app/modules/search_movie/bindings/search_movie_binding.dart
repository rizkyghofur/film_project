import 'package:get/get.dart';

import '../controllers/search_movie_controller.dart';

class SearchMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchMovieController>(
      () => SearchMovieController(),
    );
  }
}
