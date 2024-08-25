import 'package:get/get.dart';

import '../controllers/popular_movie_controller.dart';

class PopularMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PopularMovieController>(
      () => PopularMovieController(),
    );
  }
}
