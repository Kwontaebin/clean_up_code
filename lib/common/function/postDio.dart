import 'package:clean_up_code/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../component/custom_toast.dart';

void postDio({
  required Map<String, dynamic> postData,
  required String url,
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
      print('Login successful: ${response.data}');
    }
  } catch (e) {
    // 네트워크 오류 또는 기타 예외 처리
    if (e is DioException) {
      int? errCode = e.response?.statusCode;

      if(errCode == 400) {
        print('유저 정보 없음: ${e.response?.statusMessage}');
        customToast(
            message: "데이터 형식이 올바르지 않습니다",
            color: Colors.black
        );
      } else if (errCode == 401) {
        print('유저 정보 없음: ${e.response?.statusMessage}');
        customToast(
            message: "유저 정보 없음",
            color: Colors.black
        );
      }  else if(errCode == 500) {
        print('Unexpected erro: ${e.response?.statusMessage}');
        customToast(
            message: "서버 에러",
            color: Colors.black
        );
      }
    }
  }
}
