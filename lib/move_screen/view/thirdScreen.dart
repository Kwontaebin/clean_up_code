import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../common/component/custom_elevatedButton.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "thirdScreen"),
      body: Center(
        child: Text("마지막 페이지"),
      ),
    );
  }
}
