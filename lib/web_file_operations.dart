import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';

Future<void> downloadFile(
  BuildContext context,
  String jsonData,
  String fileName,
) async {
  // Blob 객체 생성
  final blob = html.Blob([jsonData], 'application/json');

  // 다운로드 URL 생성
  final url = html.Url.createObjectUrlFromBlob(blob);

  // 임시 <a> 태그 생성하여 다운로드 링크 클릭
  final anchor =
      html.AnchorElement(href: url)
        ..setAttribute('download', fileName)
        ..click();

  // URL 객체 해제
  html.Url.revokeObjectUrl(url);

  // 성공 메시지 표시
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('파일 다운로드가 시작되었습니다.')));
}
