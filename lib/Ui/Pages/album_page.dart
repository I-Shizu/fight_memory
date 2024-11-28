import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../Provider/providers.dart';
import '../ViewModels/post_view_model.dart';

class AlbumPage extends ConsumerWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider);
    final permissionGranted = ref.watch(permissionGrantedProvider);

    if (!permissionGranted) {
      // 許可がない場合
      return Scaffold(
        appBar: AppBar(
          title: const Text('Album'),
        ),
        body: const Center(
          child: Text(
            "写真ライブラリの許可が必要です。\n設定から許可してください。",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    if (posts.isEmpty) {
      // 許可があるが投稿がない場合
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