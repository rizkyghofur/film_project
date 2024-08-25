import 'dart:math';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../data/models/responses/top_rated_movies_response.dart';
import '../../../services/themoviedb_service.dart';

class TopratedMovieController extends GetxController {
  int pageNumber = 1;
  int totalPage = 1;
  TheMovieDBService theMovieDBService = TheMovieDBService();
  final topratedMovieList = <Results>[].obs;
  RxBool isLoading = false.obs;
  Random random = Random();

  @override
  void onInit() {
    initDataTopRatedMovie();
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

  initDataTopRatedMovie() async {
    EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);
    await theMovieDBService
        .getTopRatedMovies(pageNumber.toString())
        .then((response) {
      EasyLoading.dismiss();
      if (response.results!.isNotEmpty) {
        totalPage = response.totalPages!;
        topratedMovieList.addAll(response.results!);
        update();
      }
    }).catchError((e) {
      EasyLoading.showError('Something went wrong, please try again later');
    });
  }

  loadMoreData() async {
    pageNumber++;
    if (pageNumber <= totalPage) {
      isLoading.value = true;
      await theMovieDBService
          .getTopRatedMovies(pageNumber.toString())
          .then((response) {
        isLoading.value = false;
        if (response.results!.isNotEmpty) {
          topratedMovieList.addAll(response.results!);
          update();
        }
      }).catchError((e) {
        isLoading.value = false;
        EasyLoading.showError('Something went wrong, please try again later');
      });
    }
  }
}
