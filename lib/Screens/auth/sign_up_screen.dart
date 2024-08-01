import 'package:chat/Components/custom_text_form.dart';
import 'package:chat/Provider/auth_provider.dart';
import 'package:chat/Screens/auth/login_screen.dart';
import 'package:chat/Theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../Components/custom_button.dart';
import '../../Utils/validation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
  }

  void signUp(userProvider) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        String userName = userNameController.text.trim();
        String email = emailController.text.trim();
        String password = passwordController.text;
        await userProvider.signUpWithEmailAndPassword(
            userName, email, password, context);
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        throw Exception(e);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
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
                onPressed: () => signUp(userProvider),
                isLoading: isLoading,
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
