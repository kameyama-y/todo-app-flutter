import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Page/login//login_page.dart';
import 'Page/Task/TaskListPage.dart';
import 'Page/login//login_state_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://kukmsqwukygsaredmlts.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt1a21zcXd1a3lnc2FyZWRtbHRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYyNjMyOTEsImV4cCI6MjA3MTgzOTI5MX0.isBRZChIsWQOocDRQwc1MtLMrlBGAj7eCLp24kwquS4',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(loginStateProvider);

    if (isLoggedIn == null) {
      return MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? TaskListPage() : LoginPage(),
    );
  }
}
