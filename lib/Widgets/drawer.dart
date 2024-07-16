import 'package:chat/Screens/home_screen.dart';
import 'package:chat/Screens/privacy_policy_screen.dart';
import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.lightBlueAccent,
        child: ListView(
          children: [
            DrawerHeader(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.shade400,
                  borderRadius: BorderRadius.circular(13),
                ),
                accountName: const Text("Nasir"),
                accountEmail: const Text("abdulNasir@gmail.con"),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: const Text(
                "Home",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              iconColor: Colors.white,
              horizontalTitleGap: 50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 40),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text(
                "Privacy Policy",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
              iconColor: Colors.white,
              horizontalTitleGap: 50,
              contentPadding: EdgeInsets.symmetric(horizontal: 40),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen())),
            )
          ],
        ));
  }
}
