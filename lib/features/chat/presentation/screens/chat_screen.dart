import 'package:chat/core/utils/extensions/theme_extension.dart';
import 'package:chat/features/chat/presentation/widgets/pop_menu.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String conversationId;
  const ChatScreen({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder:
                (context) => [
                  menu(title: "Setting", onPressed: () {}),
                  menu(title: "Profile", onPressed: () {}),
                ],
          ),
        ],
        iconTheme: IconThemeData(
          color: context.primary, // Change the color of the back button
        ),
      ),
      body: SafeArea(child: Column()),
    );
  }
}
