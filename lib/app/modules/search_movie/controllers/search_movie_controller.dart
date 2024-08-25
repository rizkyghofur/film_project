import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../data/models/responses/search_result_movies_response.dart';
import '../../../services/themoviedb_service.dart';

class SearchMovieController extends GetxController {
  TextEditingController searchMovieController = TextEditingController();
  TheMovieDBService theMovieDBService = TheMovieDBService();
  RxList<Results> searchMovieList = <Results>[].obs;
  RxBool isLoading = false.obs, hasError = false.obs;
  Random random = Random();

  @override
  void onInit() {
    //
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

  fetchSearchMovie(String query) async {
    isLoading.value = true;
    await theMovieDBService.searchMovies(query).then((response) {
      isLoading.value = false;
      if (hasError.value) {
        hasError.value = false;
      }
      searchMovieList.value = response.results!;
      update();
    }).catchError((e) {
      isLoading.value = false;
      hasError.value = true;
      EasyLoading.showError('Something went wrong, please try agai later');
    });
  }
}
