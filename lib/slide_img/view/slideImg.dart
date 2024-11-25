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
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox.expand( // SizedBox.expand 위젯은 자식 위젯(CarouselSlider)이 화면의 전체 영역을 차지하도록 도와주는 위젯
          child: CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 1.0,
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
                    width: double.infinity, // 슬라이드 아이템이 화면 너비 전체를 차지하도록 설정
                    decoration: BoxDecoration(
                      color: color,
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
              alignment: Alignment.centerLeft,
              widthFactor: (_currentIndex + 1) / colors.length,
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
    );
  }
}
