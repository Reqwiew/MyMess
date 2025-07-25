import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';


class LoginRepository {
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioClient.instance.post(
        'auth/login',
        data: {
          'email': email,
          'password': password,
          'username': '',
        },
      );

      final data = response.data;

      if (response.statusCode == 200 && data['result'] != null) {
        final token = data['result']['access_token'];
        print('Токен: $token');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
      } else {
        throw Exception('Ошибка регистрации: ${data['error']}');
      }
    } on DioException catch (e) {
      print('Dio ошибка: ${e.response?.data}');
      throw Exception('Ошибка подключения: ${e.message}');
    } catch (e) {
      print('Неизвестная ошибка: $e');
      throw Exception('Произошла ошибка');
    }
  }
}
