// /*
//   todo 해당 모듈 사용 시 필수 사항
//   모듈을 불러오는 파일 제일 상단에 GestureDetector 위젯을 불러오고 밑의 코드 작성
//         onTap: () {
//           FocusScope.of(context).unfocus(); // 빈 공간 클릭 시 포커스 해제
//         },
//
//   이렇게 하면 커서가 집중되어 있을 때 빈 공간을 클릭하면 커서 집중이 풀린다.
//  */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../function/sizeFn.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Color backGroundColor;
  final double? width;
  final double? height;
  final ValueChanged<String> onChanged;
  final bool onlyNum;
  final bool obscureText;

  const CustomTextFieldWidget({
    super.key,
    this.controller,
    this.width,
    this.height,
    required this.hintText,
    this.backGroundColor = Colors.white12,
    required this.onChanged,
    this.onlyNum = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black12,
        width: 1.0,
      ),
    );

    final textStyle = TextStyle(
      fontSize: deviceHeight(context) * 0.02,
      fontWeight: FontWeight.w400,
    );

    // height 값에 따라 contentPadding을 동적으로 설정
    EdgeInsetsGeometry contentPadding = EdgeInsets.symmetric(
      vertical: (height != null && height! < 40) ? height! * 0.2 : 20,
      horizontal: 20,
    );

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        onChanged: onChanged,
        keyboardType: onlyNum ? TextInputType.number : TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')), // 띄어쓰기 금지
          if (onlyNum) FilteringTextInputFormatter.digitsOnly,
        ],
        style: textStyle,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          hintText: hintText,
          hintStyle: textStyle,
          fillColor: backGroundColor,
          filled: true,
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
