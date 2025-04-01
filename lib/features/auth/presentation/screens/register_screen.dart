import 'dart:io';

import 'package:chat/core/exceptions/app_exceptions.dart';
import 'package:chat/core/utils/extensions/snakbar_extension.dart';
import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/core/utils/helpers/validator.dart';
import 'package:chat/core/utils/widgets/avatar_picker.dart';
import 'package:chat/core/utils/widgets/custom_button.dart';
import 'package:chat/features/auth/presentation/screens/login_screen.dart';
import 'package:chat/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  File? _selectAvatar;

  Future<String?> _uploadAvatar() async {
    if (_selectAvatar == null) {
      return null;
    }

    try {
      final extension = _selectAvatar!.path.split('.').last;
      final fileName =
          'avatar_${DateTime.now().millisecondsSinceEpoch}.$extension';
      final storage = Supabase.instance.client.storage;

      final uploadResponse = await storage
          .from('avatars')
          .upload(fileName, _selectAvatar!);

      final publicUrl = storage.from('avatars').getPublicUrl(uploadResponse);

      return publicUrl;
    } catch (e) {
      if (mounted) {
        context.showErrorSnackbar('Avatar upload failed: ${e.toString()}');
      }
      rethrow;
    }
  }
  //   Future<void> deleteAvatar(String url) async {
  //   try {
  //     final path = url.split('avatars/').last;
  //     await _supabase.storage
  //       .from('avatars')
  //       .remove([path]);
  //   } on StorageException catch (e) {
  //     throw AppException(message: 'Delete failed: ${e.message}');
  //   }
  // }

  Future<void> _register(WidgetRef ref) async {
    final email = emailController.text.trim().toLowerCase();
    final password = passwordController.text.trim();
    final userName = userNameController.text.trim();
    final phone = phoneController.text.trim();

    if (formKey.currentState!.validate()) {
      try {
        final avatarUrl = await _uploadAvatar();
        print(avatarUrl);

        await ref
            .read(authContollerProvider.notifier)
            .signUpWithEmailAndPassword(
              email: email,
              password: password,
              userName: userName,
              phone: phone,
              avatar: avatarUrl.toString(),
            );
      } catch (e) {
        print(e.toString());
        if (mounted) {
          context.showErrorSnackbar('Registration failed: ${e.toString()}');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    Text("Register", style: context.headlineMedium),
                    const SizedBox(height: 30),
                    AvatarPicker(
                      image: _selectAvatar,
                      onImageSelected: (file) {
                        setState(() {
                          _selectAvatar = file;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    AuthTextfield(
                      label: "Name",
                      hint: "Enter your Name",
                      controller: userNameController,
                      capitalization: TextCapitalization.words,
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
                      type: TextInputType.emailAddress,
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
                      prefixIcon: Icons.numbers_outlined,
                      validator: (value) => validateNotEmpty(value),
                    ),
                    const SizedBox(height: 20),

                    AuthTextfield(
                      label: "Password",
                      hint: "Enter your Password",
                      controller: passwordController,
                      type: TextInputType.name,
                      action: TextInputAction.go,
                      prefixIcon: Icons.lock_outline,
                      isPassField: true,
                      validator: (value) => validateNotEmpty(value),
                    ),
                    const SizedBox(height: 40),

                    Consumer(
                      builder: (context, ref, _) {
                        final authState = ref.watch(authContollerProvider);
                        ref.listen(authContollerProvider, (previous, next) {
                          next.whenOrNull(
                            data: (user) {
                              user != null
                                  ? Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoginScreen(),
                                    ),
                                  )
                                  : null;

                              context.showSuccessSnackbar(
                                'Account created successfully',
                              );
                            },
                            error: (error, _) {
                              final message =
                                  error is AppAuthException
                                      ? error.message
                                      : 'Failed to create account Please TryAgain later!';
                              if (context.mounted) {
                                context.showErrorSnackbar(message);
                              }
                            },
                          );
                        });
                        return CustomButton(
                          title: "Register",
                          onPressed: () => _register(ref),
                          state: authState,
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Alread have an account?",
                          style: context.bodyMedium.copyWith(
                            color: context.onSurface,
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
