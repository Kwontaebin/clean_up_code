import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_up_code/common/component/custom_image.dart';
import 'package:clean_up_code/common/function/navigator.dart';
import 'package:clean_up_code/move_screen/view/firstScreen.dart';
import 'package:clean_up_code/move_screen/view/secondScreen.dart';
import 'package:flutter/material.dart';
import '../../common/function/sizeFn.dart';

class ImgSlideScreen extends StatefulWidget {
  const ImgSlideScreen({super.key});

  @override
  State<ImgSlideScreen> createState() => _ImgSlideScreenState();
}

class _ImgSlideScreenState extends State<ImgSlideScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  // 색상을 이미지로 변경 변경
  final List list = [
    'asset/img/img1.jpg',
    'asset/img/img2.jpg',
    'asset/img/img3.jpg',
    'asset/img/img4.jpg',
    'asset/img/img5.jpg',
    'asset/img/img6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox.expand(
          // SizedBox.expand 위젯은 자식 위젯(CarouselSlider)이 화면의 전체 영역을 차지하도록 도와주는 위젯
          child: CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1.0, // 전체 화면 꽉 차도록
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: list.asMap().entries.map((entry) {
              int index = entry.key;
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      // 이렇게 해서 클릭 시 화면 이동
                      // 슬라이드 개수가 많아지면 다른 방법을 고민해야 될지도..
                      if (_currentIndex == 0) navigatorFn(context, const FirstScreen());
                      if (_currentIndex == 1) navigatorFn(context, const SecondScreen());
                    },
                    child: SizedBox(
                      width: sizeFn(context).width * 1.0,
                      child: customImage(
                        image: list[index],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        // 게이지로 몇번쨰 페이지 인지 표시
        Positioned(
          bottom: 10,
          child: Container(
            width: 200,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (_currentIndex + 1) / list.length,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),

        // 현재 페이지 / 총 페이지 수 로 표시
        // Positioned(
        //   bottom: 5,
        //   right: 30,
        //   child: Text(
        //     "${_currentIndex + 1} / ${list.length}",
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: sizeFn(context).width * 0.04,
        //       fontWeight: FontWeight.w900,
        //     ),
        //   ),
        // )
      ],
    );
  }
}
