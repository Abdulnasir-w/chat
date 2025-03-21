import 'package:chat/core/utils/helpers/validator.dart';
import 'package:chat/core/utils/widgets/custom_button.dart';
import 'package:chat/features/auth/presentation/screens/forgot_screen.dart';
import 'package:chat/features/auth/presentation/screens/register_screen.dart';
import 'package:chat/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 40),
                AuthTextfield(
                  label: "Email",
                  hint: "Enter Your Email",
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  action: TextInputAction.next,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) => validateEmail(value),
                ),
                const SizedBox(height: 20),

                AuthTextfield(
                  label: "Password",
                  hint: "Enter Your Password",
                  controller: passwordController,
                  type: TextInputType.text,
                  action: TextInputAction.done,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) => validateNotEmpty(value),
                  isPassField: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ForgotScreen()),
                      );
                    },
                    child: Text(
                      "Forgot Password",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Consumer(
                  builder: (context, ref, _) {
                    final authState = ref.watch(authContollerProvider);

                    return CustomButton(
                      title: "Login",
                      onPressed: () {},
                      state: authState,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        "Register",
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
    );
  }
}
