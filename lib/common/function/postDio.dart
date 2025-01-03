import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../component/custom_toast.dart';
import '../const/data.dart';

Future<void> postDio({
  required Map<String, dynamic> postData,
  required String url,
  required Function(Map<String, dynamic> data) onSuccess,
}) async {
  Dio dio = Dio();

  try {
    // POST 요청을 보내고 응답을 받습니다.
    Response response = await dio.post(
      "$IP/$url",
      data: postData,
    );

    // 서버 응답 상태 코드가 200일 경우
    if (response.statusCode == 200) {
      // print('Login successful: ${response.data}');
      customToast(message: response.data["message"], bgColor: Colors.black);
      onSuccess(response.data);
    }
  } catch (e) {
    // 네트워크 오류 또는 기타 예외 처리
    if (e is DioException) {
      // 해당 변수로 에러 상태 코드를 확인 가능!
      int? errCode = e.response?.statusCode;
      print(errCode);

      print('데이터 형식 수정 부탁: ${e.response?.data["message"]}');
      customToast(message: e.response?.data["message"], bgColor: Colors.black);
    }
  }
}
