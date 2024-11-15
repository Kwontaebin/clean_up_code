import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:clean_up_code/common/component/custom_checkbox.dart';
import 'package:clean_up_code/common/component/custom_showdiaLog.dart';
import 'package:clean_up_code/common/component/custom_text.dart';
import 'package:clean_up_code/common/component/custom_text_field.dart';
import 'package:clean_up_code/common/component/custom_loading.dart';
import 'package:clean_up_code/common/component/custom_toast.dart';
import 'package:clean_up_code/move_screen/view/firstScreen.dart';
import 'package:clean_up_code/slide_img/view/slideImg.dart';
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
  List<bool> checkStatus = [false, false, false, false];
  List<String> checkBoxText = ["첫 번째 선택", "두 번째 이용 약관 선택", "세 번쨰 동의"];

  @override
  void initState() {
    super.initState();
    // controller 하드 코딩
    myController.text = "테스트 중!!";
  }

  void checkAllCheckBox(bool value) {
    setState(() {
      for (int i = 0; i < checkStatus.length; i++) {
        if (value) {
          checkStatus[i] = true;
        } else {
          checkStatus[i] = false;
        }
      }
    });
  }

  void updateCheckStatus(int index, bool value) {
    setState(() {
      checkStatus[index] = value;

      if (checkStatus[1] && checkStatus[2] && checkStatus[3]) checkStatus[0] = true;
      else if(!checkStatus[1] || !checkStatus[2] || !checkStatus[3]) checkStatus[0] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 빈 공간 클릭 시 포커스 해제
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "sizeScreen",
          showLeading: false,
          bgColor: Colors.lime,
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
            width: sizeFn(context).width * 1.0,
            height: deviceHeight(context),
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight(context) * 0.3,
                  child: const ImgSlideScreen(),
                ),
                SizedBox(
                  height: deviceHeight(context) * 0.3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Center(
                          child: CustomTextFieldWidget(
                            width: sizeFn(context).width * 0.9,
                            controller: myController,
                            hintText: "입력해주세요",
                            onChanged: (value) {},
                          ),
                        ),
                        const CustomTextWidget(
                          text: "커스텀 텍스트!",
                          textColor: Colors.red,
                          textSize: 22,
                        ),
                        CustomCheckbox(
                          text: '이용 약관 모두 동의하기',
                          isChecked: checkStatus[0],
                          onChanged: (value) {
                            checkAllCheckBox(value);
                          }
                        ),
                        for (int i = 1; i < checkStatus.length; i++)
                          CustomCheckbox(
                            text: checkBoxText[i - 1],
                            isChecked: checkStatus[i],
                            onChanged: (value) {
                              setState(() {
                                updateCheckStatus(i, value!);
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: deviceHeight(context) * 0.01),
                SizedBox(
                  height: deviceHeight(context) * 0.25,
                  child: customLoading(),
                ),
                SizedBox(height: deviceHeight(context) * 0.01),
                CustomElevatedButton(
                  height: deviceHeight(context) * 0.06,
                  text: "버튼",
                  buttonTextSize: sizeFn(context).width * 0.06,
                  color: Colors.blue,
                  // buttonTextColor: Colors.black,
                  buttonTextFontWeight: FontWeight.w900,
                  onPressed: () {
                    showMyDialog(
                      context,
                      title: '테스트',
                      content: "지금은 테스트중!",
                      leftButtonOnPressed: () {
                        customToast("취소");
                        print("취소!!");
                      },
                      rightButtonOnPressed: () {
                        print("확인!!");
                        customToast("화면 이동!");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FirstScreen()),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
