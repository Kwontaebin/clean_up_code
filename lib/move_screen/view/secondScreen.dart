import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:clean_up_code/move_screen/view/thirdScreen.dart';
import 'package:flutter/material.dart';

import '../../common/component/custom_elevatedButton.dart';
import '../../common/function/navigator.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "secondScreen"),
      body: Center(
        child: customElevatedButton(
          context,
          text: "button",
          onPressed: () {
            navigatorFn(context, const ThirdScreen());
          },
        ),
      ),
    );
  }
}
