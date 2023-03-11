import 'package:dart_knights/controllers/auth_controller/g_sign_in.dart';
import 'package:dart_knights/views/auth/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    child: Text("Logout"),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
                    },
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("An Error Ocurred! "),
              );
            } else {
              return LoginPage();
            }
          }),
    );
  }
}
