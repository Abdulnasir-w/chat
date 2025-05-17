import 'package:chat/core/theme/theme.dart';
import 'package:chat/core/utils/helpers/snakbar_helper.dart';
import 'package:chat/features/auth/presentation/screens/login_screen.dart';
import 'package:chat/home_screen.dart';
import 'package:chat/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabaseUrl = "https://rekqmcppdyqsescyqekq.supabase.co";
  final supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJla3FtY3BwZHlxc2VzY3lxZWtxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI5MzI3MzYsImV4cCI6MjA1ODUwODczNn0.sq5pDoK20iPhtIsuOyxZMpp7zwdsCos_J6gGojXsxI8";

  try {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
      realtimeClientOptions: RealtimeClientOptions(eventsPerSecond: 40),
    );
  } catch (e) {
    throw Exception('Failed to initialize Supabase: $e');
  }
  runApp(ProviderScope(child: ChatApp()));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final themeMode = ref.watch(themeProvider);
        final scaffoldKey = ref.watch(scaffoldMessengerKeyProvider);
        return MaterialApp(
          scaffoldMessengerKey: scaffoldKey,

          title: 'Flutter Chat App',
          debugShowCheckedModeBanner: false,

          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeMode,
          themeAnimationStyle: AnimationStyle(
            curve: Curves.bounceIn,
            duration: Duration(seconds: 3),
          ),

          home: AuthWrapper(),
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) {
      return const LoginScreen(); // Redirect to login if not authenticated
    }
    return const HomeScreen(); // Proceed to home if authenticated
  }
}
