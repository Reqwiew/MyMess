
import 'package:dio/dio.dart';
import 'package:messengerr/repositories/network/dio_client.dart';

class SendOtpRepository{
  Future<void> sendOtp({
    required int code,
    required String email,
  }) async{
    try{
      final response = await DioClient.instance.post(
        'auth/reset_password',
        data: {
          'code' : code,
          'email' : email,
        },
      );
    } on DioException catch (e){
      print('Dio ошибка: ${e.response?.data}');
      throw Exception('Ошибка подключения: ${e.message}');
    } catch (e){
      print('неизвестная ошибка ${e}');
      throw Exception('произошла ошибка');
    }
  }
}