import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Ui/Pages/top_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( 
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.hachiMaruPopTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: TopPage(),
    );
  }
}