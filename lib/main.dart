import 'package:dart_knights/controllers/auth_controller/g_sign_in.dart';
import 'package:dart_knights/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context)=> GoogleSignInProvider(),
    child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily
    ),
    home: HomePage(),
    ));
  }
}

