import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:clean_up_code/common/component/custom_elevatedButton.dart';
import 'package:clean_up_code/common/function/navigator.dart';
import 'package:clean_up_code/move_screen/view/secondScreen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "firstScreen",
        showLeading: false,
      ),
      body: Center(
        child: customElevatedButton(
          context,
          text: "button",
          onPressed: () {
            navigatorFn(context, const SecondScreen());
          },
        ),
      ),
    );
  }
}
