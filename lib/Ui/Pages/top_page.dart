import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'album_page.dart';
import 'home_page.dart';
import 'add_post_page.dart';

// 現在のインデックスを管理するStateProvider
final currentIndexProvider = StateProvider<int>((ref) => 0);

class TopPage extends ConsumerWidget {
  final _pageWidgets = [
    const HomePage(),
    AddPostPage(),
    const AlbumPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      body: _pageWidgets.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ほーむ'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'にゅー'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: 'あるばむ'),
        ],
        currentIndex: currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: (index) => ref.read(currentIndexProvider.notifier).state = index,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}