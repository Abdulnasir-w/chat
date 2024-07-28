import 'package:chat/Components/custom_text_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: MyCustomTextFormField(
                label: 'Email',
                prefixIcon: Icons.email_outlined,
                keyBoardType: TextInputType.emailAddress,
                hint: 'Enter Your Email',
              ),
            )
          ],
        ),
      ),
    );
  }
}
