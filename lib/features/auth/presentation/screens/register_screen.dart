import 'package:chat/core/utils/helpers/validator.dart';
import 'package:chat/core/utils/widgets/custom_button.dart';
import 'package:chat/features/auth/presentation/screens/login_screen.dart';
import 'package:chat/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Add this to allow resizing when the keyboard appears
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 7.5,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Register",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 30),

                    AuthTextfield(
                      label: "Name",
                      hint: "Enter your Name",
                      controller: userNameController,
                      type: TextInputType.name,
                      action: TextInputAction.next,
                      prefixIcon: Icons.person_outline,
                      validator: (value) => validateNotEmpty(value),
                    ),
                    const SizedBox(height: 20),

                    AuthTextfield(
                      label: "Email",
                      hint: "Enter your Email",
                      controller: emailController,
                      type: TextInputType.name,
                      action: TextInputAction.next,
                      prefixIcon: Icons.email_outlined,
                      validator: (value) => validateEmail(value),
                    ),
                    const SizedBox(height: 20),

                    AuthTextfield(
                      label: "Phone Number",
                      hint: "Enter your Phone Number",
                      controller: phoneController,
                      type: TextInputType.phone,
                      action: TextInputAction.next,
                      prefixIcon: Icons.lock_outline,
                      validator: (value) => validateNotEmpty(value),
                    ),
                    const SizedBox(height: 20),

                    AuthTextfield(
                      label: "Password",
                      hint: "Enter your Password",
                      controller: passwordController,
                      type: TextInputType.name,
                      action: TextInputAction.next,
                      prefixIcon: Icons.lock_outline,
                      isPassField: true,
                      validator: (value) => validateNotEmpty(value),
                    ),
                    const SizedBox(height: 40),

                    Consumer(
                      builder: (context, ref, _) {
                        final authState = ref.watch(authContollerProvider);
                        return CustomButton(
                          title: "Register",
                          onPressed: () {},
                          state: authState,
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Alread have an account?",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
