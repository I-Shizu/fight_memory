import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Provider/providers.dart';
import 'ViewModels/post_view_model.dart';

class Calendar extends ConsumerWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(postDateProvider) ?? DateTime.now();
    final posts = ref.watch(postProvider);
    final permissionGranted = ref.watch(permissionGrantedProvider);

    return Scaffold(
      body: Column(
        children: [
          //カレンダー
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: selectedDay,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                ref.watch(postDateProvider.notifier).state = selectedDay;
                ref.watch(postProvider.notifier).fetchPostsForDay(selectedDay);
              },
              calendarFormat: CalendarFormat.month,
            ),
          ),
          //投稿表示
          Expanded(
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {

                if(!permissionGranted){
                  return Center(
                    child: Text('まだ投稿はありません'),
                  );
                }

                if (posts.isEmpty) {
                  return Center(
                    child: Text('まだ投稿はありません'),
                  );
                }

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                
                    return Card(
                      child: ListTile(
                        subtitle: Column(
                          children: [
                            if (post.imageFile != null) Image.file(File(post.imageFile!))
                            else Container(),
                            Row(
                              children: [
                                Text(
                                  '${post.date.year}/${post.date.month}/${post.date.day}',
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () async {
                                    final localId = post.localId;
                                    
                                    if (localId != null) {
                                      final bool? confirmDelete = await showDialog<bool>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('削除の確認'),
                                            content: Text('この投稿を削除してもよろしいですか？'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(false); // キャンセル
                                                },
                                                child: Text('キャンセル'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(true); // 削除実行
                                                },
                                                child: Text('削除'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      if (confirmDelete == true) {
                                        ref.read(postProvider.notifier).deletePost(localId);
                                      }
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}