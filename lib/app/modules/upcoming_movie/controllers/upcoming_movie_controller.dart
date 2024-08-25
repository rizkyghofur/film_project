import 'dart:math';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../data/models/responses/upcoming_movies_response.dart';
import '../../../services/themoviedb_service.dart';

class UpcomingMovieController extends GetxController {
  RxInt pageNumber = 1.obs;
  int totalPage = 0;
  TheMovieDBService theMovieDBService = TheMovieDBService();
  final upcomingMovieList = <Results>[].obs;
  RxBool isLoading = false.obs;
  Random random = Random();

  @override
  void onInit() {
    initDataUpcomingMovie();
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

  initDataUpcomingMovie() async {
    EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false);
    await theMovieDBService
        .getUpcomingMovies(pageNumber.toString())
        .then((response) {
      EasyLoading.dismiss();
      if (response.results!.isNotEmpty) {
        totalPage = response.totalPages!;
        upcomingMovieList.addAll(response.results!);
        update();
      }
    }).catchError((e) {
      EasyLoading.showError('Something went wrong, please try again later');
    });
  }

  loadMoreData() async {
    pageNumber++;
    if (pageNumber.value <= totalPage) {
      isLoading.value = true;
      await theMovieDBService
          .getUpcomingMovies(pageNumber.toString())
          .then((response) {
        isLoading.value = false;
        if (response.results!.isNotEmpty) {
          upcomingMovieList.addAll(response.results!);
          update();
        }
      }).catchError((e) {
        isLoading.value = false;
        EasyLoading.showError('Something went wrong, please try again later');
      });
    }
  }
}