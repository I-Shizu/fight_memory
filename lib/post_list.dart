import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostList extends Notifier<List<Map>> {
  @override
  List<Map> build() {
    //ビルドメソッド内は初期値を設定
    return [];
  }
  void update(List<Map> postList){
    state = postList;
  }
}