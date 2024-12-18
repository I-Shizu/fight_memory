import 'dart:io';
import 'package:fight_app2/Data/Models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../ViewModels/post_view_model.dart';

class AlbumPage extends ConsumerWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider);

    // 許可があるが投稿がない場合
    if (posts.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Album'),
        ),
        body: const Center(
          child: Text("まだ投稿はありません"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('アルバム'),
      ),
      body: posts.isEmpty
          ? const Center(child: Text("まだ投稿はありません"))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                 Post post = posts[index];

                return Card(
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (post.imageFile != null)
                          Image.file(File(post.imageFile!)),
                        Text(
                          post.text,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd').format(post.date),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}