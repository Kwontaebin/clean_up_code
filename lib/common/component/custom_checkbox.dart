import 'package:clean_up_code/common/component/custom_show_hide_text.dart';
import 'package:flutter/material.dart';

class CustomCheckboxWidget extends StatefulWidget {
  final String text;
  final bool isChecked;
  final ValueChanged onChanged;
  final bool showMoreText;
  final String showText;

  const CustomCheckboxWidget({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onChanged,
    this.showMoreText = true,
    required this.showText,
  });

  @override
  State<CustomCheckboxWidget> createState() => _CustomCheckboxWidgetState();
}

class _CustomCheckboxWidgetState extends State<CustomCheckboxWidget> {
  bool iconBtnStatus = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        Row(
          children: [
            Checkbox(
              value: widget.isChecked,
              onChanged: widget.onChanged,
            ),
            GestureDetector(
              onTap: () {
                widget.onChanged(!widget.isChecked);
              },
              child: Text(
                widget.text,
              ),
            ),
            const Spacer(), // 나머지 위젯과 IconButton 사이에 가변 공간 추가
            widget.showMoreText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        iconBtnStatus = !iconBtnStatus;
                      });
                    },
                    iconSize: 22.0,
                    icon: iconBtnStatus
                        ? const Icon(Icons.keyboard_arrow_down)
                        : const Icon(Icons.keyboard_arrow_right),
                  )
                : const SizedBox(),
          ],
        ),
        if (iconBtnStatus)
          customTextShowHide(
            text: widget.showText,
          ),
      ],
    );
  }
}

// import 'package:clean_up_code/common/component/custom_show_hide_text.dart';
// import 'package:flutter/material.dart';
//
// class CustomCheckboxWidget extends StatefulWidget {
//   final String text;
//   final bool isChecked;
//   final ValueChanged onChanged;
//   final bool showMoreText;
//   final String showText;
//
//   const CustomCheckboxWidget({
//     super.key,
//     required this.text,
//     required this.isChecked,
//     required this.onChanged,
//     this.showMoreText = true,
//     required this.showText,
//   });
//
//   @override
//   State<CustomCheckboxWidget> createState() => _CustomCheckboxWidgetState();
// }
//
// class _CustomCheckboxWidgetState extends State<CustomCheckboxWidget> {
//   bool iconBtnStatus = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
//       children: [
//         Row(
//           children: [
//             Checkbox(
//               value: widget.isChecked,
//               onChanged: widget.onChanged,
//             ),
//             GestureDetector(
//               onTap: () {
//                 widget.onChanged(!widget.isChecked);
//               },
//               child: Text(
//                 widget.text,
//               ),
//             ),
//             const Spacer(), // 나머지 위젯과 IconButton 사이에 가변 공간 추가
//             widget.showMoreText
//                 ? IconButton(
//               onPressed: () {
//                 setState(() {
//                   iconBtnStatus = !iconBtnStatus;
//                 });
//               },
//               iconSize: 22.0,
//               icon: iconBtnStatus
//                   ? const Icon(Icons.keyboard_arrow_down)
//                   : const Icon(Icons.keyboard_arrow_right),
//             )
//                 : const SizedBox(),
//           ],
//         ),
//         if (iconBtnStatus)
//           customTextShowHide(
//             text: widget.showText,
//           ),
//       ],
//     );
//   }
// }
