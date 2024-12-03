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
    final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

    return Scaffold(
      key: messengerKey, // GlobalKeyを設定
      body: Column(
        children: [
          // カレンダー
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: selectedDay,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                ref.read(postDateProvider.notifier).state = selectedDay;

                // アクセス許可がある場合のみ投稿を取得
                if (permissionGranted) {
                  ref.read(postProvider.notifier).fetchPostsForDay(selectedDay);
                } 
                // アクセス許可がない時の投稿処理
                if(!permissionGranted) {
                  messengerKey.currentState?.showSnackBar(
                    const SnackBar(content: Text('フォルダアクセスの許可が必要です')),
                  );
                }
              },
              calendarFormat: CalendarFormat.month,
            ),
          ),
          // 投稿表示
          Expanded(
            child: permissionGranted
                ? posts.isEmpty
                    ? const Center(child: Text('まだ投稿はありません'))
                    : ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          return Card(
                            child: ListTile(
                              subtitle: Column(
                                children: [
                                  if (post.imageFile != null)
                                    Image.file(File(post.imageFile!))
                                  else
                                    Container(),
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
                                            ref
                                                .read(postProvider.notifier)
                                                .deletePost(localId);
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
                      )
                : const Center(
                    child: Text('フォルダアクセスの許可が必要です'),
                  ),
          ),
        ],
      ),
    );
  }
}