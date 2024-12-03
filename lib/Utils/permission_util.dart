import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Provider/providers.dart';

Future<void> requestPermission(
    WidgetRef ref, GlobalKey<ScaffoldMessengerState> messengerKey) async {
  final status = await Permission.photos.request();

  if (status.isGranted) {
    ref.read(permissionGrantedProvider.notifier).state = true;
    messengerKey.currentState?.showSnackBar(
      const SnackBar(content: Text('写真ライブラリへのアクセスが許可されました'))
    );
  }
  if (status.isDenied) {
    ref.read(permissionGrantedProvider.notifier).state = false;
    messengerKey.currentState?.showSnackBar(
      const SnackBar(content: Text('写真ライブラリへのアクセスが拒否されました')),
    );
  } 
  if (status.isPermanentlyDenied) {
    ref.read(permissionGrantedProvider.notifier).state = false;
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: const Text('設定から写真ライブラリへのアクセスを許可してください'),
        action: SnackBarAction(
          label: '設定を開く',
          onPressed: () => openAppSettings(),
        ),
      ),
    );
  }
}