import 'package:clean_up_code/move_screen/view/firstScreen.dart';
import 'package:clean_up_code/setting_device_size/view/size.dart';
import 'package:clean_up_code/slide_img/view/slideImg.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'clean up code!',
      home: FirstScreen(),
    );
  }
}