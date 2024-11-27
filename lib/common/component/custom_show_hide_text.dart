import 'package:flutter/material.dart';

Widget customTextShowHide({
  bool isTextVisible = true,
  required String text,
}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(16.0),
    child: AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isTextVisible ? 1.0 : 0.0,
      child: isTextVisible
          ? Column(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ) : const SizedBox.shrink(),
    ),
  );
}
