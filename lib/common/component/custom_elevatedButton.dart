import 'package:flutter/material.dart';
import '../function/sizeFn.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;
  final String text;
  final Color buttonTextColor;
  final double? buttonTextSize;
  final FontWeight? buttonTextFontWeight;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    this.width,
    this.height,
    this.color = Colors.red,
    required this.text,
    this.buttonTextColor = Colors.white,
    this.buttonTextSize,
    this.buttonTextFontWeight,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(
          width ?? sizeFn(context).width * 0.5,
          height ?? deviceHeight(context) * 0.05,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: buttonTextColor,
          fontSize: buttonTextSize ?? sizeFn(context).width * 0.05,
          fontWeight: buttonTextFontWeight ?? FontWeight.w500
        ),
      ),
    );
  }
}