import 'package:flutter/material.dart';
import 'auth_provider.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthProvider _authProvider = AuthProvider();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: _authProvider.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final isLoggedIn = snapshot.data ?? false;
          return isLoggedIn ? HomePage() : LoginPage();
        },
      ),
    );
  }
}
