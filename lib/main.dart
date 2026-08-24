import 'package:dochouda/features/auth/presentation/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Docteur Houda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff0a5ad0),
          dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Color(0xfff3f8ff),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff0a5ad0),
          brightness: Brightness.dark,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
