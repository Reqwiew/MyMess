import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';

class RegisterRepository {
  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await DioClient.instance.post(
        'auth/register',
        data: {
          'email': email,
          'nickname': name,
          'password': password,
        },
      );

      final data = response.data;

      if (response.statusCode == 200 && data['result'] != null) {
        final token = data['result']['access_token'];
        print('Токен: $token');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
      } else {
        final errorMessage = data['error']?['message'] ??
            data['error']?.toString() ??
            data['message'] ??
            'Неизвестная ошибка регистрации';
        throw Exception(errorMessage);
      }
    } on DioException catch (e) {
      print('Dio ошибка: ${e.response?.data}');

      if (e.response != null && e.response!.data != null) {
        final errorData = e.response!.data;
        final errorMessage = errorData['error']?['message'] ??
            errorData['error']?.toString() ??
            errorData['message'] ??
            'Ошибка сервера: ${e.response!.statusCode}';
        throw Exception(errorMessage);
      } else {
        throw Exception('Ошибка подключения: ${e.message}');
      }
    } catch (e) {
      print('Неизвестная ошибка: $e');
      throw Exception('Произошла неизвестная ошибка');
    }
  }
}