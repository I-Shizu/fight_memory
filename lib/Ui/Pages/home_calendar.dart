import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Provider/providers.dart';
import '../ViewModels/post_view_model.dart';
import 'list_page.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(postDateProvider) ?? DateTime.now();
    final posts = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.list,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ListPage()),
              );
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: selectedDay,
                  calendarFormat: CalendarFormat.month,
                  selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    ref.read(postDateProvider.notifier).state = selectedDay;
                    ref.read(postProvider.notifier).fetchPostsForDay(selectedDay);
                  },
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: posts.length,
              (BuildContext context, int index) {
                final post = posts[index];

                if (posts.isEmpty) {
                  return Center(
                    child: Text('まだ投稿はありません'),
                  );
                }

                return Card(
                  child: ListTile(
                    subtitle: Column(
                      children: [
                        if (post.imageFile != null)
                          Image.file(File(post.imageFile!))
                        else
                          Row(
                            children: [
                              Text(
                                '${post.date.year}/${post.date.month}/${post.date.day}',
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  final localId = post.localId;
                                  final bool? confirmDelete = await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('削除の確認'),
                                        content: const Text('この投稿を削除してもよろしいですか？'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text('キャンセル'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: const Text('削除'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (confirmDelete == true) {
                                    ref.read(postProvider.notifier).deletePost(localId!);
                                  }
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}