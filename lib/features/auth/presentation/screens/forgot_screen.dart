import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/core/utils/extensions/snakbar_extension.dart';
import 'package:chat/core/utils/helpers/validator.dart';
import 'package:chat/core/utils/widgets/custom_button.dart';
import 'package:chat/features/auth/presentation/screens/login_screen.dart';
import 'package:chat/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotScreen extends ConsumerWidget {
  ForgotScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authContollerProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 250),
                AuthTextfield(
                  label: "Email",
                  hint: "Enter Your Email",
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  action: TextInputAction.go,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) => validateEmail(value),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Back to Login",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  title: "Send Reset Eamil",
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      await ref
                          .read(authContollerProvider.notifier)
                          .resetPassword(email: emailController.text.trim());

                      ref.listen(authContollerProvider, (prevous, next) {
                        next.whenOrNull(
                          data: (data) {
                            if (data == null && context.mounted) {
                              context.showSuccessSnackbar(
                                'Password reset email sent successfully!',
                              );
                              Navigator.pop(context);
                            }
                          },
                          error: (error, _) {
                            final message =
                                error is AppAuthException
                                    ? error.message
                                    : 'Failed to send reset email';
                            if (context.mounted) {
                              context.showErrorSnackbar(message);
                            }
                          },
                        );
                      });
                    }
                  },
                  state: authState,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
