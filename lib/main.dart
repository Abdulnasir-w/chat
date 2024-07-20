import 'package:chat/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wemewzjuhivldiicwpgl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndlbWV3emp1aGl2bGRpaWN3cGdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjE1MTQwNDAsImV4cCI6MjAzNzA5MDA0MH0.SZZjefVYiUcgEQXTHe-w6B3qYTfOFKcTN_a8HSEcbq4',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
