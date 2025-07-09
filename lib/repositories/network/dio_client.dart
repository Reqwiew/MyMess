import 'package:dio/dio.dart';

import '../../constants/BaseUrl.dart';


class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Dio get instance => _dio;
}
