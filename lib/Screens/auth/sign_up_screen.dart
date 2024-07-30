import 'package:chat/Components/custom_text_form.dart';
import 'package:chat/Screens/auth/login_screen.dart';
import 'package:chat/Theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../Components/custom_button.dart';
import '../../Utils/validation.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController userNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
                      label: 'User Name',
                      hint: 'Enter Your User Name',
                      controller: userNameController,
                      prefixIcon: Icons.person_2_outlined,
                      keyBoardType: TextInputType.name,
                      validator: (value) => Validator.validateField(value),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyCustomButton(
                title: 'Sign Up',
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
                    "Already Have an Account? ",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                        splashFactory: InkSparkle.splashFactory),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      "Login",
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
