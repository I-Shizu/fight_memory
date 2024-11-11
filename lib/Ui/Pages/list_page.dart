import 'package:fight_app2/Ui/Pages/top_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('リストページ'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // ボタンを押すとログインページに遷移
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => TopPage()),
              (route) => false,
            );
          },
          child: const Text('ログアウト'),
        ),
      ),
    );
  }
}