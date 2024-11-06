import 'package:flutter/material.dart';
import '../function/sizeFn.dart';

class CustomElevatedButton extends StatelessWidget {
  final width;
  final height;
  final color;
  final text;
  final buttonColor;
  final buttonSize;
  final VoidCallback? onPressed;

  const CustomElevatedButton({
    super.key,
    this.width,
    this.height,
    this.color = Colors.red,
    required this.text,
    this.buttonColor = Colors.white,
    this.buttonSize,
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
        style: TextStyle(
          color: Colors.white,
          fontSize: buttonSize ?? sizeFn(context).width * 0.05,
        ),
      ),
    );
  }
}
