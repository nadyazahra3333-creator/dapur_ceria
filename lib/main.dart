import 'package:flutter/material.dart';
import 'pages/app_shell.dart';
import 'theme.dart';

void main() => runApp(const DapurCeriaApp());

class DapurCeriaApp extends StatelessWidget {
  const DapurCeriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dapur Ceria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kMint,
        colorScheme: ColorScheme.fromSeed(seedColor: kYellow),
      ),
      home: const AppShell(),
    );
  }
}