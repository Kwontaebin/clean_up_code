import 'package:clean_up_code/common/component/custom_appbar.dart';
import 'package:clean_up_code/common/component/custom_elevatedButton.dart';
import 'package:clean_up_code/common/component/custom_text_field.dart';
import 'package:clean_up_code/common/const/data.dart';
import 'package:clean_up_code/common/function/postDio.dart';
import 'package:clean_up_code/common/function/sizeFn.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class BackendConnection extends StatefulWidget {
  const BackendConnection({super.key});

  @override
  State<BackendConnection> createState() => _BackendConnectionState();
}

class _BackendConnectionState extends State<BackendConnection> {
  String signId = '', signPw = '', loginId = '', loginPw = '';

  Map<String, dynamic> requestData = {};

  late IO.Socket socket;
  String response = "";
  String socketText = '';

  @override
  void initState() {
    super.initState();

    // 서버와 연결
    socket = IO.io(IP, {
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // 서버로부터 메시지 수신
    socket.on('message', (data) {
      setState(() {
        response = data;
        print(data);
      });
    });

    // 서버 연결
    socket.connect();
  }

  @override
  void dispose() {
    // 앱 종료 시 서버 연결 종료
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "server",
        showLeading: false,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: sizeFn(context).width * 1.0,
            height: deviceHeight(context) * 1.0,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextFieldWidget(
                  hintText: "회원가입 아이디를 입력하세요",
                  onChanged: (value) {
                    setState(() {
                      signId = value;
                    });
                  },
                  myControllerText: signId,
                  clearText: true,
                ),
                const SizedBox(height: 20),
                CustomTextFieldWidget(
                  hintText: "회원가입 비밀번호를 입력하세요",
                  onChanged: (value) {
                    setState(() {
                      signPw = value;
                    });
                  },
                  myControllerText: signPw,
                  clearText: true,
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                customElevatedButton(
                  context,
                  text: "회원가입",
                  onPressed: () async {
                    setState(() {
                      requestData = {
                        'user_id': signId,
                        'user_pw': signPw,
                      };
                    });

                    (signId == '' || signPw == '')
                        ? print("모두 다 작성해주세요")
                        : postDio(
                            postData: requestData,
                            url: "auth/register",
                            onData: (Map<String, dynamic> data) {

                              if (data["statusCode"] == 200) {
                                setState(() {
                                  signId = "";
                                  signPw = "";

                                  // print(signId);
                                });
                              }
                            },
                          );
                  },
                ),
                divider(),
                CustomTextFieldWidget(
                  hintText: "로그인 아이디를 입려하세요",
                  onChanged: (value) {
                    setState(() {
                      loginId = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFieldWidget(
                  hintText: "로그인 비밀번호를 입려하세요",
                  onChanged: (value) {
                    setState(() {
                      loginPw = value;
                    });
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                customElevatedButton(
                  context,
                  text: "로그인",
                  onPressed: () async {
                    setState(() {
                      requestData = {
                        'user_id': loginId,
                        'user_pw': loginPw,
                      };
                    });
                    (loginId == '' || loginPw == '')
                        ? print("모두 다 작성해주세요")
                        : postDio(
                            postData: requestData,
                            url: "auth/login",
                            onData: (Map<String, dynamic> data) {});
                  },
                ),
                divider(),
                Text('Server response: $response'),
                const SizedBox(height: 20),
                CustomTextFieldWidget(
                  hintText: "입력하세요",
                  myControllerText: socketText,
                  textSpacing: true,
                  onChanged: (value) {
                    setState(() {
                      socketText = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                customElevatedButton(
                  context,
                  text: "소켓 통신 버튼",
                  onPressed: () {
                    if (socketText.isNotEmpty) socket.emit('message', socketText);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Divider(
        color: Colors.black,
        thickness: 2.0,
      ),
    );
  }
}
