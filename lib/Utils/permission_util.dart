import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Provider/providers.dart';

Future<void> requestPermission(
    WidgetRef ref, BuildContext context) async {
  // アクセス許可の状態を取得
  final status = await Permission.photos.status;

  // ダイアログを表示する関数
  Future<void> showDialogMessage(
      String title, String message, List<Widget> actions) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: actions,
      ),
    );
  }

  if (status.isGranted) {
    // 既に許可済みの場合
    ref.read(permissionGrantedProvider.notifier).state = true;
    await showDialogMessage(
      'アクセス許可',
      '写真ライブラリへのアクセスが許可されています。',
      [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
    return;
  }

  // アクセス許可をリクエストするロジック
  Future<void> requestPermissionAction() async {
    final newStatus = await Permission.photos.request();

    if (newStatus.isGranted) {
      ref.read(permissionGrantedProvider.notifier).state = true;
      Navigator.of(context).pop(); // ダイアログを閉じる
      await showDialogMessage(
        'アクセス許可成功',
        '写真ライブラリへのアクセスが許可されました。',
        [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      );
    } else if (newStatus.isPermanentlyDenied) {
      ref.read(permissionGrantedProvider.notifier).state = false;
      await showDialogMessage(
        'アクセスが拒否されました',
        '設定から写真ライブラリへのアクセスを許可してください。',
        [
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
      );
    } else {
      ref.read(permissionGrantedProvider.notifier).state = false;
      Navigator.of(context).pop(); // ダイアログを閉じる
      await showDialogMessage(
        'アクセス拒否',
        '写真ライブラリへのアクセスが拒否されました。',
        [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      );
    }
  }

  // 初回ダイアログ表示
  await showDialogMessage(
    'アクセス許可が必要',
    'このアプリでは写真ライブラリへのアクセスが必要です。「許可」を押してください。',
    [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('閉じる'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(); // 最初のダイアログを閉じる
          requestPermissionAction(); // 再リクエストを実行
        },
        child: const Text('許可'),
      ),
    ],
  );
}