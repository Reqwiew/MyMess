import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messengerr/repositories/auth/forgot_password_repository.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordRepository _forgotPasswordRepository = ForgotPasswordRepository();

  void _forgotPassword() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await _forgotPasswordRepository.forgotPassword(
          email: _emailController.text.trim());
      Navigator.pushNamed(
        context,
        '/sendOtp',
        arguments: _emailController.text.trim(),
      );
    }catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
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
                        'Сброс Пароля',
                        style: TextStyle(
                          color: Color(0xFF5852CB),
                          fontSize: 62,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Введите email' : null,
                      ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                TextButton(
                                  onPressed: () => Navigator.pushNamed(context, '/login'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Color(0xFF5852CB),
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(0, 0),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Вспомнили пароль? Войти',
                                    style: TextStyle(height: 2.0),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          onPressed: _forgotPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5852CB),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Получить код'),
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