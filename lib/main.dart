import 'package:demo1/providers/user_provider.dart';
import 'package:demo1/routes.dart';
import 'package:demo1/services/auth_service.dart';
import 'package:demo1/utils/zdrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const LoginApp()));
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.grtUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Walls',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home:const ZDrawer(),
      onGenerateRoute: (setting) => generateRoute(setting),
    );
  }
}
