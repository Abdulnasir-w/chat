import 'package:chat/core/theme/theme.dart';
import 'package:chat/core/utils/helpers/snakbar_helper.dart';
import 'package:chat/features/auth/presentation/screens/login_screen.dart';
import 'package:chat/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabaseUrl = "https://pbsvmluxomiwdolukbrb.supabase.co";
  final supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBic3ZtbHV4b21pd2RvbHVrYnJiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIyNDA3NjAsImV4cCI6MjA1NzgxNjc2MH0.bZLBKNkayhHyX6TUhEVJvf7v09nuGbyQVhlkOYCjVUw";

  try {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  } catch (e) {
    throw Exception('Failed to initialize Supabase: $e');
  }

  runApp(const ProviderScope(child: ChatApp()));
}

class ChatApp extends ConsumerWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final scaffoldKey = ref.watch(scaffoldMessengerKeyProvider);

    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      title: 'Flutter Chat App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      home: const LoginScreen(), // Add your initial screen
    );
  }
}
