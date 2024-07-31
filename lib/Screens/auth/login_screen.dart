import 'package:chat/Components/custom_button.dart';
import 'package:chat/Components/custom_text_form.dart';
import 'package:chat/Screens/auth/forgot_screen.dart';
import 'package:chat/Screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Theme/app_theme.dart';
import '../../Utils/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              SvgPicture.asset(
                'assets/login.svg',
                width: 450.0,
                height: 450.0,
              ),
              Form(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 15,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: const ButtonStyle(
                            splashFactory: InkSparkle.splashFactory,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotScreen()));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyCustomButton(
                title: 'Login',
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: .5,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't Have an Account? ",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "fonts/Roboto-Regular.ttf"),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        splashFactory: InkSparkle.splashFactory),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
