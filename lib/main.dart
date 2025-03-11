import 'package:clean_up_code/backend_connection/view/backendConnection.dart';
import 'package:clean_up_code/firebase_message/firebase_message.dart';
import 'package:clean_up_code/setting_device_size/view/size.dart';
import 'package:clean_up_code/webview_library/view/webview.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'clean up code!',
      home: FirebaseMessage(),
    );
  }
}