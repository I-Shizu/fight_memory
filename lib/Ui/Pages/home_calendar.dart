import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Provider/providers.dart';
import 'list_page.dart';
import '../ViewModels/post_view_model.dart';

class CalendarPage extends ConsumerWidget {
  const CalendarPage({super.key});

  Future<void> _checkAndRequestPermission(BuildContext context, WidgetRef ref) async {
    final permissionGranted = ref.read(permissionGrantedProvider);

    if (!permissionGranted) {
      final status = await Permission.photos.status;

      if (status.isDenied || status.isPermanentlyDenied) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('アクセス許可が必要'),
            content: const Text('写真フォルダへのアクセス許可が必要です。許可しますか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false), // 拒否
                child: const Text('拒否'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(true); // 許可リクエスト実行
                  final newStatus = await Permission.photos.request();
                  if (newStatus.isGranted) {
                    ref.read(permissionGrantedProvider.notifier).state = true;
                  } else {
                    ref.read(permissionGrantedProvider.notifier).state = false;
                    if (newStatus.isPermanentlyDenied) {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('アクセスが拒否されました'),
                          content: const Text('設定画面からアクセスを許可してください。'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('閉じる'),
                            ),
                            TextButton(
                              onPressed: () {
                                openAppSettings();
                                Navigator.of(context).pop();
                              },
                              child: const Text('設定を開く'),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                child: const Text('許可'),
              ),
            ],
          ),
        );
      }
      if (status.isGranted) {
        ref.read(permissionGrantedProvider.notifier).state = true;
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(postDateProvider) ?? DateTime.now();
    final posts = ref.watch(postProvider);
    final permissionGranted = ref.watch(permissionGrantedProvider);

    // アクセス許可を確認（画面が開かれたとき）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndRequestPermission(context, ref);
    });

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
      
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
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

                    if (permissionGranted) {
                      ref.read(postProvider.notifier).fetchPostsForDay(selectedDay);
                    }
                    if (!permissionGranted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('アクセス許可が必要'),
                          content: const Text('写真フォルダへのアクセスが許可されていません。設定を確認してください。'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('閉じる'),
                            ),
                          ],
                        ),
                      );
                    }
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

                if (!permissionGranted) {
                  return const Center(
                    child: Text('フォルダアクセスの許可が必要です'),
                  );
                }

                if (posts.isEmpty) {
                  return const Center(
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