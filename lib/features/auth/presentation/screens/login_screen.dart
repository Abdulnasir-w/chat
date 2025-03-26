import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/core/utils/extensions/snakbar_extension.dart';
import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/core/utils/helpers/validator.dart';
import 'package:chat/core/utils/widgets/custom_button.dart';
import 'package:chat/features/auth/presentation/screens/forgot_screen.dart';
import 'package:chat/features/auth/presentation/screens/register_screen.dart';
import 'package:chat/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:chat/home_screen.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> _login(WidgetRef ref) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (formKey.currentState!.validate()) {
      await ref
          .read(authContollerProvider.notifier)
          .signInWithEmailAndPassword(email: email, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Text("Login", style: context.headlineMedium),
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
                  action: TextInputAction.go,
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
                      style: context.bodyMedium.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Consumer(
                  builder: (context, ref, _) {
                    final authState = ref.watch(authContollerProvider);
                    ref.listen(authContollerProvider, (previous, next) {
                      next.whenOrNull(
                        data: (user) {
                          user != null
                              ? Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => HomeScreen()),
                              )
                              : null;
                          context.showSuccessSnackbar('Login successful');
                        },
                        error: (error, _) {
                          final message =
                              error is AppAuthException
                                  ? error.message
                                  : 'Failed to Login Please TryAgain later!';
                          if (context.mounted) {
                            context.showErrorSnackbar(message);
                          }
                        },
                      );
                    });

                    return CustomButton(
                      title: "Login",
                      onPressed: () => _login(ref),
                      state: authState,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: context.bodyMedium.copyWith(
                        color: context.onSurface,
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
                          color: context.primary,
                          fontFamily: 'Poppins',
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
