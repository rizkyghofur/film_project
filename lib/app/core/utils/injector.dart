import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor_v2/dio_logging_interceptor_v2.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future baseDio() async {
  final options = BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  var dio = Dio(options);

  dio.interceptors.add(
    DioLoggingInterceptor(
      level: Level.body,
      compact: false,
    ),
  );

  locator.registerSingleton<Dio>(dio);
}
