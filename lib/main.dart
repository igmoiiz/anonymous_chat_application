import 'package:chat_complete/Splash/splash.dart';
import 'package:chat_complete/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Black Chat',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        useMaterial3: true,
        textTheme: GoogleFonts.openSansTextTheme(),
        fontFamily: GoogleFonts.montaga().fontFamily,
      ),
      home: const SplashScreen(),
    );
  }
}
