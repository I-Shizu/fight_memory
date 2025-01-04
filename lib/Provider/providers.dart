import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Data/Repository/post_repository.dart';

//ビジネスロジックの状態管理をするProvider
//Provider(定数)を管理する

//レポジトリとのプロバイダの定義
final postRepositoryProvider = Provider<PostRepository>((ref) => PostRepository());


//投稿日時プロバイダの管理
final postDateProvider = StateProvider<DateTime?>((ref){ 
  return DateTime.now();
});

//投稿のIDプロバイダを管理
final localIdProvider = StateProvider<int?>((ref) {
  return null;
});

//ページの場所を管理
final currentPageIndexProvider = StateProvider<int>((ref) => 0);

//画像のプロバイダ
final postImageFileProvider = StateProvider<File?>((ref) {
  return null;
});

//テキストのプロバイダ
final postTextProvider = StateProvider<String>((ref) => '');

//写真フォルダへのアクセス許可を管理
final permissionGrantedProvider = StateProvider<bool>((ref) => false);

//テーマプロバイダの定義
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});
// テーマ状態を管理するStateNotifier
class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false); // 初期値はライトテーマ(false)

  void toggleTheme() => state = !state;
}

//通知プロバイダの定義
final notificationProvider = StateNotifierProvider<NotificationNotifier, bool>((ref) {
  return NotificationNotifier();
});
// 通知状態を管理するStateNotifier
class NotificationNotifier extends StateNotifier<bool> {
  NotificationNotifier() : super(true); // 初期値は通知オン(true)

  void toggleNotification() => state = !state;
}