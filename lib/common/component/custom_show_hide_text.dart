import 'package:flutter/material.dart';

Widget customTextShowHide({
  bool isTextVisible = true,
  required String text,
}) {
  return Container(
    alignment: Alignment.center, // 텍스트를 중앙에 정렬
    padding: const EdgeInsets.all(16.0),
    child: AnimatedOpacity(
      duration: const Duration(milliseconds: 300), // 애니메이션 효과
      opacity: isTextVisible ? 1.0 : 0.0, // 가시성에 따라 투명도 조정
      child: isTextVisible
          ? Column(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      )
          : const SizedBox.shrink(), // 숨길 때 공간 차지하지 않음
    ),
  );
}
