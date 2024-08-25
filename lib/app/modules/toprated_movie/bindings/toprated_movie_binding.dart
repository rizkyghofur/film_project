import 'package:get/get.dart';

import '../controllers/toprated_movie_controller.dart';

class TopratedMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopratedMovieController>(
      () => TopratedMovieController(),
    );
  }
}
