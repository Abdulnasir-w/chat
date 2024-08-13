import 'package:chat/Components/custom_snakbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Nasir"),
            subtitle: Text("Software Engineering"),
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
          );
        },
      ),
    );
  }
}
