import 'package:chat/Screens/home_screen.dart';
import 'package:chat/Screens/no_internet_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CheckConectivity extends StatefulWidget {
  const CheckConectivity({super.key});

  @override
  State<CheckConectivity> createState() => _CheckConectivityState();
}

class _CheckConectivityState extends State<CheckConectivity> {
  void initState() {
    super.initState();
    setState(() {
      _checkInternetAndLoadWebsite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Future<void> _checkInternetAndLoadWebsite() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No internet connection, navigate to another page or show an error message.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoInternetPage(),
        ),
      );
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }
}
