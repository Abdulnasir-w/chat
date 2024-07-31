import 'package:chat/Provider/auth_provider.dart';
import 'package:chat/Screens/auth/login_screen.dart';
import 'package:chat/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zpzujkqbwrvjgxfufavi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpwenVqa3Fid3J2amd4ZnVmYXZpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjIyMDM2MDEsImV4cCI6MjAzNzc3OTYwMX0.etMHwOdWR2Cnch9zqSx42UwW7Cbz-7o2p_g3j8syoyE',
  );
  runApp(ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
