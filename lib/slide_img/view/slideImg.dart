import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImgSlideScreen extends StatefulWidget {
  const ImgSlideScreen({super.key});

  @override
  State<ImgSlideScreen> createState() => _ImgSlideScreenState();
}

class _ImgSlideScreenState extends State<ImgSlideScreen> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                enlargeCenterPage: false, // 현재 이미지 크게 표시(viewportFraction:1.0으로 설정해서 상관이 없음)
                autoPlay: true, // 자동 슬라이드
                autoPlayInterval: const Duration(seconds: 3), // 슬라이드 속도
                viewportFraction: 1.0, // 슬라이드 간 간격 조절
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: colors.asMap().entries.map((entry) {
                int index = entry.key;
                Color color = entry.value;
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Color ${index + 1}',
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
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
                  alignment: Alignment.centerLeft, // 프로그래스 바가 넘어가는 방향 외쪽 -> 오른쪽
                  widthFactor: (_currentIndex + 1) / colors.length, // 프로그래스 바 게이지가 차는 넓이
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
