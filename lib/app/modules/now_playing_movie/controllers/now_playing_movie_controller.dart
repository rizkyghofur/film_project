import 'dart:math';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../data/models/responses/now_playing_movies_response.dart';
import '../../../services/themoviedb_service.dart';

class NowPlayingMovieController extends GetxController {
  RxInt pageNumber = 1.obs;
  int totalPage = 0;
  TheMovieDBService theMovieDBService = TheMovieDBService();
  final nowPlayingMovieList = <Results>[].obs;
  RxBool isLoading = false.obs;
  Random random = Random();

  @override
  void onInit() {
    initDataNowPlayingMovie();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  initDataNowPlayingMovie() async {
    EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);
    await theMovieDBService
        .getNowPlayingMovies(pageNumber.toString())
        .then((response) {
      EasyLoading.dismiss();
      if (response.results!.isNotEmpty) {
        totalPage = response.totalPages!;
        nowPlayingMovieList.addAll(response.results!);
        update();
      }
    }).catchError((e) {
      EasyLoading.showError('Something went wrong, please try again later');
    });
  }

  loadMoreData() async {
    pageNumber.value++;
    if (pageNumber.value <= totalPage) {
      isLoading.value = true;
      await theMovieDBService
          .getNowPlayingMovies(pageNumber.toString())
          .then((response) {
        isLoading.value = false;
        if (response.results!.isNotEmpty) {
          nowPlayingMovieList.addAll(response.results!);
          update();
        }
      }).catchError((e) {
        isLoading.value = false;
        EasyLoading.showError('Something went wrong, please try again later');
      });
    }
  }
}
