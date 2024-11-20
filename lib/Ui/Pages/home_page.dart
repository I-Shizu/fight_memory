import 'package:flutter/material.dart';
import '../home_calendar.dart';
import 'list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.list,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ListPage())
              );
            },
          )
        ],
      ),
      body: const Calendar(),//columnするとエラーになる
    );
  }
}
