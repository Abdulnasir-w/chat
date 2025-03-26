import 'package:chat/features/auth/presentation/screens/login_screen.dart';
import 'package:chat/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Home Screen,"),
          Consumer(
            builder: (context, ref, _) {
              return ElevatedButton(
                onPressed: () {
                  ref.read(authContollerProvider.notifier).signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                child: Text("Log Out"),
              );
            },
          ),
        ],
      ),
    );
  }
}
