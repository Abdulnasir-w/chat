import 'package:chat/Components/custom_snakbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  CustomSnackbar.showCustomSnackbar(context,
                      message:
                          "SnakBar is the worst thing i trying but i love it how you can also try it",
                      backgroundColor: Colors.blue,
                      alignment: Alignment.topCenter);
                },
                child: const Text("Snak Bar "),
              ),
            ),
            const Center(
              child: const Text("Home Screen",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
