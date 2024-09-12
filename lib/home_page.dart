import 'package:flutter/material.dart';
import 'auth_provider.dart';
import 'login_page.dart';
import 'trading_page.dart';

class HomePage extends StatelessWidget {
  final AuthProvider _authProvider = AuthProvider();

  void _logout(BuildContext context) async {
    await _authProvider.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: _authProvider.getUsername(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final username = snapshot.data ?? 'User';
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Welcome, $username!'), 
              const SizedBox(height: 12,),
              TextButton(
                  onPressed: () {
                     Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const TradingPage()),
      );
                  },
                  child: Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: const Text(
                      'Real-Time Trading Now',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                ),],);
          },
        ),
      ),
    );
  }
}
