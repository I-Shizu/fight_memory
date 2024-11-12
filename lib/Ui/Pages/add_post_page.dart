import 'dart:io';
import 'package:fight_app2/Provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../viewmodels/post_view_model.dart';
import 'top_page.dart';

class AddPostPage extends ConsumerWidget {
  AddPostPage({super.key});

  final postTextProvider = StateProvider<String>((ref) => '');
  final postImageProvider = StateProvider<File?>((ref) => null);

  Future<void> _pickImage(WidgetRef ref) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        ref.read(postImageProvider.notifier).state = File(pickedFile.path);
      }
    }

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final postText = ref.watch(postTextProvider);
    final postImage = ref.watch(postImageProvider);
    final postDate = ref.watch(postDateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('新しい投稿')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () => _pickImage(ref),
              child: Container(
                
              ),
            )
          ]
        ),
      ),
    );
  }
}