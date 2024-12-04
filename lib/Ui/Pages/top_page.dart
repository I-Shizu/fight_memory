import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Provider/providers.dart';
import 'home_calendar.dart';
import 'album_page.dart';
import 'add_post_page.dart';

class TopPage extends ConsumerWidget {
  final List<Widget> _pageWidgets = [
    const CalendarPage(),
    AddPostPage(),
    const AlbumPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(currentPageIndexProvider);

    return Scaffold(
      body: _pageWidgets.elementAt(currentPageIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ほーむ'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'にゅー'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_album), label: 'あるばむ'),
        ],
        currentIndex: currentPageIndex,
        fixedColor: Colors.blueAccent,
        onTap: (index) => ref.read(currentPageIndexProvider.notifier).state = index,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}