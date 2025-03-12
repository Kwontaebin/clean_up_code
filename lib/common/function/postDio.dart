import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../component/custom_toast.dart';
import '../const/data.dart';

Future<void> postDio({
  Map<String, dynamic>? postData,
  required String url,
  required Function(Map<String, dynamic> data) onData,
  Options? options,
}) async {
  Dio dio = Dio();

  try {
    // POST 요청을 보내고 응답을 받습니다.
    Response response = await dio.post(
      "$IP/$url",
      data: postData,
      options: options,
    );

    // 서버 응답 상태 코드가 200일 경우
    if (response.statusCode == 200) {
      print(response.data);
      customToast(message: response.data["message"], bgColor: Colors.black);
      onData(response.data);
    }
  } catch (e) {
    // 네트워크 오류 또는 기타 예외 처리
    if (e is DioException) {
      if (e.response?.data != null) {
        onData(e.response?.data);
        print(e.response?.data);

        customToast(
          message: e.response?.data["message"],
          bgColor: Colors.black,
        );
      } else {
        print("{status: 500, message: 서버 연결이 안 돼 있습니다.}");
        customToast(message: "서버 연결이 안 돼 있습니다.", bgColor: Colors.black);
      }
    }
  }
}
