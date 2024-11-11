import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.textSize = 18,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textSize,
        color: textColor
      ),
    );
  }
}
