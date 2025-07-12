
import 'package:dio/dio.dart';
import 'package:messengerr/repositories/network/dio_client.dart';

class ForgotPasswordRepository{
  Future<void> forgotPassword({
    required String email,
}) async{
    try{
      final response = await DioClient.instance.post(
        'auth/send_otp',
        data: {
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