import 'package:chat/core/theme/theme.dart';
import 'package:chat/core/utils/helpers/snakbar_helper.dart';
import 'package:chat/providers/theme_provider.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var env = DotEnv()..load(['.env']);
  await Supabase.initialize(
    url: env["SUPABASE_URL"] ?? "",
    anonKey: env["SUPABASE_KEY"] ?? "",
  );
  runApp(ProviderScope(child: const ChatApp()));
}

class ChatApp extends ConsumerWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = ref.watch(scaffoldMessengerKeyProvider);

    return Consumer(
      builder: (context, ref, _) {
        final themeMode = ref.watch(themeProvider);
        return MaterialApp(
          scaffoldMessengerKey: scaffoldKey,
          title: 'Flutter Chat App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),

          themeMode: themeMode,
          //home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}
