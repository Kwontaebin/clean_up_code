import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:clean_up_code/move_screen/view/thirdScreen.dart';
import 'package:flutter/material.dart';

import '../../common/component/custom_elevatedButton.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "secondScreen"),
      body: Center(
        child: CustomElevatedButton(
          text: "button",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ThirdScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
