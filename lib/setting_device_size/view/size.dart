import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:flutter/material.dart';
import '../../common/component/custom_elevatedButton.dart';
import '../../common/function/sizeFn.dart';

class SizeScreen extends StatefulWidget {
  const SizeScreen({super.key});

  @override
  State<SizeScreen> createState() => _SizeScreenState();
}

class _SizeScreenState extends State<SizeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "sizeScreen",
        showLeading: false,
      ),
      body: Container(
        width: size.width * 1.0,
        height: calculateBodyHeight(context),
        color: Colors.lightGreen,
        child: Column(
          children: [
            Container(
              height: calculateBodyHeight(context) * 0.3,
              color: Colors.lime,
            ),
            Container(
              height: calculateBodyHeight(context) * 0.3,
              color: Colors.amberAccent,
            ),
            Container(
              height: calculateBodyHeight(context) * 0.25,
              color: Colors.red,
            ),
            CustomElevatedButton(
              // width: size.width * 0.3,
              height: calculateBodyHeight(context) * 0.06,
              text: "btn",
              buttonSize: sizeFn(context).width * 0.06,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
