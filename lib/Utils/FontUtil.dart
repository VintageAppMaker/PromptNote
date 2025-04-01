import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// [필독]
// 1. 이 파일은 앱의 전역적인 스타일을 설정
// 2. font를 교체가능함
// 3. fontsize는 반드시 소수점으로 해야 함(모바일 디바이스 문제발생)
Function setFontStyle_1 = GoogleFonts.poorStory; // 기본 폰트 설정
Function setFontStyle_2 = GoogleFonts.poorStory; // 2 폰트 설정

double? _normalSize = 16.0; // 기본 폰트 사이즈
double? _bigSize = 18.0; // 큰 폰트 사이즈
double? _bannerSize = _bigSize! * 2; // 작은 폰트 사이즈

void setSizeByMediaQuery(BuildContext context) {
  _normalSize = 16.0;
  _bigSize = 18.0;
  final double screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 600) {
    _normalSize = 16.0;
    _bigSize = 18.0;
  } else if (screenWidth < 900) {
    _normalSize = 16.0 * 1.2;
    _bigSize = 18.0 * 1.2;
  } else {
    _normalSize = 16.0 * 1.5;
    _bigSize = 18.0 * 1.5;
  }
  // 화면 너비에 따라 기준 폰트 크기 결정
}

// box 텍스트 스타일
TextStyle setTextStyleBox() {
  return setFontStyle_2(
    fontSize: _normalSize,
    color: const Color.fromARGB(255, 83, 83, 83), // 줄 번호 색상
  );
}

// 제목 스타일 -shadow
TextStyle setTextStyleShadow() {
  return setFontStyle_1(
    color: const Color.fromARGB(255, 185, 185, 185),
    fontSize: _bigSize,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        color: const Color.fromARGB(255, 0, 0, 0),
        offset: const Offset(1.0, 1.0),
        blurRadius: 3.0,
      ),
    ],
  );
}

// banner 스타일
TextStyle setTextStyleBigBanner() {
  return setFontStyle_1(
    color: const Color.fromARGB(255, 136, 136, 136),
    fontSize: _bannerSize,
    fontWeight: FontWeight.bold,
  );
}

// 제목 스타일
TextStyle setTextStyleTitle() {
  return setFontStyle_1(fontSize: _bigSize, fontWeight: FontWeight.bold);
}

// 일반 텍스트 스타일
TextStyle setTextStyleNormal() {
  return setFontStyle_1(fontSize: _normalSize, fontWeight: FontWeight.normal);
}

// 마크다운 스타일

// h1 스타일
TextStyle setStyle_H1() {
  return setFontStyle_1(
    fontSize: _bigSize,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );
}

//h2 스타일
TextStyle setStyle_H2() {
  return setFontStyle_1(
    fontSize: _bigSize,
    color: Colors.black87,
    fontWeight: FontWeight.normal,
  );
}

//h3 스타일
TextStyle setStyle_H3() {
  return setFontStyle_1(
    fontSize: _bigSize,
    color: Colors.black87,
    fontWeight: FontWeight.normal,
  );
}

//h4 스타일
TextStyle setStyle_H4() {
  return setFontStyle_1(
    fontSize: _bigSize,
    color: Colors.black87,
    fontWeight: FontWeight.normal,
  );
}

//code 스타일
TextStyle setStyle_code() {
  return setFontStyle_2(
    backgroundColor: Colors.transparent,
    color: Color.fromARGB(167, 31, 31, 31),
    fontSize: _normalSize,
  );
}

//codeblock 스타일
TextStyle setStyle_blockquote() {
  return setFontStyle_1(
    color: Colors.black54,
    fontStyle: FontStyle.italic,
    fontSize: _normalSize,
  );
}
