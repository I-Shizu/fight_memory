import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Ui/Pages/top_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( 
    ProviderScope(
      child: MyApp()
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Observerを登録
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Observerを解除
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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