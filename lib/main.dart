import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Ui/Pages/top_page.dart';

Future<void> initializeDatabase() async {
  try {
    // データベースパスを取得
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    print('Database path: $path');

    // データベースを開くまたは作成
    await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // 必要なテーブルを作成
        await db.execute(
          'CREATE TABLE IF NOT EXISTS items (id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
    );
  } catch (e) {
    print('Error initializing database: $e');
    throw Exception('Database initialization failed');
  }
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