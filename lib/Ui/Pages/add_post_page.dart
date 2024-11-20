import 'dart:io';
import 'package:fight_app2/Ui/Pages/top_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../Provider/providers.dart';
import '../ViewModels/post_view_model.dart';

class AddPostPage extends ConsumerWidget {
  AddPostPage({super.key});

  final postTextProvider = StateProvider<String>((ref) => '');

  Future<void> _pickImage(WidgetRef ref) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      
      if (pickedFile != null) {
        ref.read(postImageFileProvider.notifier).state = File(pickedFile.path);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final postText = ref.watch(postTextProvider);
    final postImage = ref.watch(postImageFileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('新しい投稿')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 画像選択エリア
              GestureDetector(
                onTap: () {
                  _pickImage(ref);
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: postImage != null
                      ? Image.file(postImage)
                      : const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 20),
          
              // テキスト入力フィールド
              Container(
                width: double.infinity,
                height: 230,
                child: TextField(
                  onChanged: (value) => ref.read(postTextProvider.notifier).state = value,
                  decoration: const InputDecoration(
                    hintText: 'テキストを入力してください',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  maxLines: 10,
                ),
              ),
              const SizedBox(height: 20),
          
              // 保存ボタン
              ElevatedButton(
                onPressed: () async {
                  if (postText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('エラー：テキストを入力してください'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else if (postImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('エラー：画像を選択してください'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    // テキストと画像をPostRepositoryに渡して保存処理を実行
                    await ref.read(postProvider.notifier).addPost(postText,postImage);
                    //画像をnullに設定
                    ref.read(postImageFileProvider.notifier).state = null;
                    //BottomNavigationBarをHomePageに設定
                    ref.read(currentIndexProvider.notifier).state = 0;
                    //現在のページを閉じる
                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(builder: (context) => TopPage())
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, double.infinity),
                ),
                child: const Text('保存'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}