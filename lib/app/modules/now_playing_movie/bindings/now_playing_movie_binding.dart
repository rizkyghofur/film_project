import 'package:get/get.dart';

import '../controllers/now_playing_movie_controller.dart';

class NowPlayingMovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NowPlayingMovieController>(
      () => NowPlayingMovieController(),
    );
  }
}
