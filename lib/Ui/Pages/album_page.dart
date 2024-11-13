import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../ViewModels/post_view_model.dart';

class AlbumPage extends ConsumerWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Album'),
      ),
      body: posts.isEmpty
          ? const Center(child: Text("まだ投稿はありません"))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  child: ListTile(
                    subtitle: Column(
                      children: [
                        post.imageFile != null
                            ? Image.file(File(post.imageFile!))
                            : Container(),
                        Text(
                          post.text,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(DateFormat('yyyy-MM-dd').format(post.date)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}