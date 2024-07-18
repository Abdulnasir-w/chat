import 'package:chat/Utils/messenger.dart';
import 'package:chat/Utils/web_view.dart';
import 'package:chat/Utils/whatsapp.dart';
import 'package:chat/Widgets/custom_button.dart';
import 'package:chat/Widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                  title: 'Whatsapp',
                  onPressed: () {
                    launchWhatsapp(phone: "923439030787");
                  },
                  asset: 'assets/whatsapp.svg',
                ),
                CustomButton(
                  title: 'Messenger',
                  onPressed: () {
                    launchMessenger(
                        messengerUrl:
                            "https://www.messenger.com/t/104562529074116");
                  },
                  asset: 'assets/messenger.svg',
                ),
                CustomButton(
                  title: 'Profile',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyWebView(
                          url: 'https://flutter.dev',
                        ),
                      ),
                    );
                  },
                  asset: 'assets/link.svg',
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove shadow
          highlightElevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: SvgPicture.asset(
            "assets/chat.svg",
            width: 70,
            height: 70,
          ),
        ),
      ),
    );
  }
}
