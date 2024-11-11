import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../viewmodels/post_view_model.dart';
import 'top_page.dart';

class NewPostPage extends ConsumerStatefulWidget {
  const NewPostPage({super.key});

  @override
  ConsumerState<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends ConsumerState<NewPostPage> with AutomaticKeepAliveClientMixin {
  final TextEditingController _postTextController = TextEditingController(text: '');
  File? _imageFile;
  String? _postImageUrl;
  final formatter = DateFormat('yyyy-MM-dd');
  final _postTime = DateTime.now();

  @override
  bool get wantKeepAlive => true;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _postImageUrl = _imageFile!.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              formatter.format(_postTime),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await _pickImage();
                    },
                    child: _postImageUrl != null
                        ? Image.file(File(_postImageUrl!))
                        : const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('がんばったこと'),
                            content: TextField(
                              controller: _postTextController,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                                child: const Text('おけ'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _postTextController.text.isNotEmpty
                            ? _postTextController.text
                            : 'テキストを入力してください',
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_postTextController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('エラー：テキストを入力してください'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else if (_imageFile == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('エラー：画像を選択してください'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  // textとimageFileをViewModelに渡してaddPostを呼び出す
                  /*await ref.read(postProvider.notifier).addPost(
                        _postTextController.text,
                      );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => TopPage()),
                  );*/
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, double.infinity),
              ),
              child: const Text('ほぞん'),
            ),
          ],
        ),
      ),
    );
  }
}