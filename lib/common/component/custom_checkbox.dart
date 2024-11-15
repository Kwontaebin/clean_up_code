import 'package:flutter/material.dart';

Widget customCheckbox({
  required String text,
  required bool isChecked,
  required ValueChanged onChanged,
}) {
  return Row(
    children: [
      Checkbox(
        value: isChecked, // 체크박스의 상태
        onChanged: onChanged,
      ),
      GestureDetector(
        onTap: () {
          onChanged(!isChecked);
        },
        child: Text(
          text,
        ),
      )
    ],
  );
}
