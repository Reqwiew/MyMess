import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messengerr/repositories/auth/forgot_password_repository.dart';
import 'package:messengerr/repositories/auth/send_otp_repository.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../repositories/auth/reset_pasword_repository.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String reset_token;

  const ResetPasswordScreen({Key? key, required this.email, required this.reset_token}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final ResetPaswordRepository _resetPaswordRepository = ResetPaswordRepository();
  bool _obscurePassword = true;

  void _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    try {

      await _resetPaswordRepository.resetPassword(
        email: widget.email,
        password: _passwordController.text,
          reset_token: widget.reset_token
      );
      Navigator.pushNamed(
        context,
        '/login',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Создать Пароль',
                            style: TextStyle(
                              color: Color(0xFF5852CB),
                              fontSize: 62,
                              height: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Введите новый пароль и подтвердите его',
                            style: TextStyle(
                              color: Color(0xFF807BE4),
                              fontSize: 12,
                              height: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Пароль',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                color: Color(0xFF5852CB),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) =>
                            value != null && value.length < 6
                                ? 'Минимум 6 символов'
                                : null,
                          ),
                          TextFormField(
                            controller: _rePasswordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'Повторите пароль',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                color: Color(0xFF5852CB),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Повторите пароль';
                              }
                              if (value != _passwordController.text) {
                                return 'Пароли не совпадают';
                              }
                              return null;
                            },

                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: ElevatedButton(
                              onPressed: _resetPassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF5852CB),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Войти в аккаунт'),
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
