import 'package:dio/dio.dart';
import 'package:messengerr/repositories/network/dio_client.dart';

class ResetPaswordRepository {
  Future<void> resetPassword({
    required String email,
    required String password,
    required String reset_token,
  }) async {
    try {
      await DioClient.instance.post(
        'auth/update_password',
        data: {'email': email, 'password': password, 'reset_token': reset_token},
      );
    } on DioException catch (e) {
      print('Dio ошибка: ${e.response?.data}');
      throw Exception('Ошибка подключения: ${e.message}');
    } catch (e) {
      print('неизвестная ошибка ${e}');
      throw Exception('произошла ошибка');
    }
  }
}
