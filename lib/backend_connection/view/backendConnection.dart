import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:clean_up_code/common/component/custom_elevatedButton.dart';
import 'package:clean_up_code/common/component/custom_text_field.dart';
import 'package:clean_up_code/common/function/postDio.dart';
import 'package:clean_up_code/common/function/sizeFn.dart';
import 'package:flutter/material.dart';

class BackendConnection extends StatefulWidget {
  const BackendConnection({super.key});

  @override
  State<BackendConnection> createState() => _BackendConnectionState();
}

class _BackendConnectionState extends State<BackendConnection> {
  String id = '';
  String pw = '';
  Map<String, dynamic> requestData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "test",
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: sizeFn(context).width * 1.0,
          height: deviceHeight(context) * 1.0,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFieldWidget(
                hintText: "아이디를 입려하세요",
                onChanged: (value) {
                  setState(() {
                    id = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                hintText: "비밀번호를 입려하세요",
                onChanged: (value) {
                  setState(() {
                    pw = value;
                  });
                },
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                text: "로그인",
                onPressed: () async {
                  setState(() {
                    requestData = {
                      'id': id,
                      'pw': pw,
                    };
                  });

                  if (id == '' || pw == '') {
                    print("모두 다 작성해주세요");
                  } else {
                    postDio(postData: requestData, url: "login");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
