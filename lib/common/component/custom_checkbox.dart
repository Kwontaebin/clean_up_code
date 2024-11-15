import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String text;
  final bool isChecked;
  final ValueChanged onChanged;

  const CustomCheckbox({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked, // 체크박스의 상태
          onChanged: onChanged,
        ),

        Text(
          text,
        ),
      ],
    );
  }
}