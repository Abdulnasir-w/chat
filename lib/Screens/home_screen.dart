import 'package:chat/Widgets/custom_button.dart';
import 'package:chat/Widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Chat",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,

        iconTheme: const IconThemeData(color: Colors.white),
        // automaticallyImplyLeading: false,
      ),
      drawer: const CustomNavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  title: 'Profile',
                  onPressed: () {},
                  asset: 'assets/whatsapp.svg',
                ),
                CustomButton(
                  title: 'Profile',
                  onPressed: () {},
                  asset: 'assets/messenger.svg',
                ),
                CustomButton(
                  title: 'Profile',
                  onPressed: () {},
                  asset: 'assets/link.svg',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
