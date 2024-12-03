import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Ui/Pages/top_page.dart';

// データベースの初期化をシミュレーションする関数
Future<void> initializeDatabase() async {
  // データベースの初期化処理
  await Future.delayed(Duration(seconds: 2)); // 仮の遅延処理
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: MyApp(),
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
    return FutureBuilder(
      future: initializeDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // データベース初期化中
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // 初期化エラー時
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('エラーが発生しました: ${snapshot.error}'),
              ),
            ),
          );
        } else {
          // 初期化完了後にメイン画面を表示
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
      },
    );
  }
}