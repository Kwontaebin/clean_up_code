import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:clean_up_code/common/component/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../../common/component/custom_elevatedButton.dart';
import '../../common/function/sizeFn.dart';

class SizeScreen extends StatefulWidget {
  const SizeScreen({super.key});

  @override
  State<SizeScreen> createState() => _SizeScreenState();
}

class _SizeScreenState extends State<SizeScreen> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.text = "테스트 중!!";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 빈 공간 클릭 시 포커스 해제
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "sizeScreen",
          showLeading: false,
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
            width: size.width * 1.0,
            height: calculateBodyHeight(context),
            child: Column(
              children: [
                SizedBox(
                  height: calculateBodyHeight(context) * 0.3,
                  child: Center(
                    child: CustomTextFieldWidget(
                      width: size.width * 0.9,
                      controller: myController,
                      hintText: "입력해주세요",
                      onChanged: (value) {},
                    ),
                  ),
                ),
                Container(
                  height: calculateBodyHeight(context) * 0.3,
                  color: Colors.amberAccent,
                ),
                Container(
                  height: calculateBodyHeight(context) * 0.25,
                  color: Colors.red,
                ),
                const SizedBox(height: 10),
                CustomElevatedButton(
                  height: calculateBodyHeight(context) * 0.06,
                  text: "btn",
                  buttonSize: sizeFn(context).width * 0.06,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
