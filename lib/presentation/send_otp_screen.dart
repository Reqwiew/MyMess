import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messengerr/repositories/auth/forgot_password_repository.dart';
import 'package:messengerr/repositories/auth/send_otp_repository.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SendOtpScreen extends StatefulWidget {
  final String email;

  const SendOtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<SendOtpScreen> createState() => _SendOtpScreen();
}

class _SendOtpScreen extends State<SendOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final SendOtpRepository _sendOtpRepository = SendOtpRepository();
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();  // Добавляем FocusNode для управления фокусом

  void _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;

    int? otpCode = int.tryParse(otpController.text);

     if (otpCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, введите правильный код OTP')),
      );
      return;
    }

    try {

      await _sendOtpRepository.sendOtp(
        code: otpCode,
        email: widget.email,
      );
      //TODO: Навигация после успешного получения OTP
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  void dispose() {
    otpFocusNode.dispose();  // Очистить ресурсы при закрытии экрана
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFE0EBF4),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: screenHeight / 2 - 300,
                  left: -screenWidth * 0.25,
                  child: Container(
                    width: screenWidth * 1.5,
                    height: screenWidth * 1.4,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Введите код',
                            style: TextStyle(
                              color: Color(0xFF5852CB),
                              fontSize: 62,
                              height: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Введите код из Вашего почтового ящика. Проверьте папку “Спам”',
                            style: TextStyle(
                              color: Color(0xFF807BE4),
                              fontSize: 12,
                              height: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          PinCodeTextField(
                            appContext: context,
                            length: 6,
                            controller: otpController,
                            focusNode: otpFocusNode,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(8),
                              fieldHeight: 50,
                              fieldWidth: 35,
                              inactiveColor: Color(0xFFE0EBF4),
                              activeColor: Color(0xFF807BE4),
                              selectedColor: Color(0xFF5852CB),
                            ),
                            onChanged: (value) {},
                            onCompleted: (value) {
                              print("OTP entered: $value");
                            },
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton(
                              onPressed: _sendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF5852CB),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Создать пароль'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
