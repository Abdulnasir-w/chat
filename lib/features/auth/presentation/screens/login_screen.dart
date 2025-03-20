import 'package:chat/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            AuthTextfield(
              label: "Email",
              hint: "Enter Your Email",
              controller: _emailController,
              type: TextInputType.emailAddress,
              action: TextInputAction.next,
              prefixIcon: Icons.email_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
