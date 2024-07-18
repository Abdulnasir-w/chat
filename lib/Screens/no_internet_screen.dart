import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: SvgPicture.asset(
              "nointernet.svg",
              width: 100,
              height: 100,
            ),
          ),
          Text("No Internet Connection")
        ],
      ),
    );
  }
}
