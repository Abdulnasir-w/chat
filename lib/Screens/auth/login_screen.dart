import 'package:chat/Components/custom_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Theme/app_theme.dart';
import '../../Utils/validation.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    final TextEditingController passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset('assets/login.svg'),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyCustomTextFormField(
                      label: 'Email',
                      hint: 'Enter Your Email',
                      controller: emailController,
                      prefixIcon: Icons.email_outlined,
                      keyBoardType: TextInputType.emailAddress,
                      validator: (value) => Validator.validateEmail(value),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCustomTextFormField(
                      label: 'Password',
                      hint: 'Enter Your Password',
                      controller: passwordController,
                      prefixIcon: Icons.lock_outline,
                      keyBoardType: TextInputType.text,
                      isPassField: true,
                      validator: (value) => Validator.validateField(value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
