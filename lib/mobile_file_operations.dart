import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';

Future<void> downloadFile(
  BuildContext context,
  String jsonData,
  String fileName,
) async {
  try {
    // 임시 파일 생성 후 공유
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(jsonData);

    // 공유 다이얼로그를 통해 파일 저장/공유 처리
    await Share.shareXFiles([XFile(file.path)], text: '프롬프트 데이터 파일');

    // 성공 메시지 표시
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('파일이 생성되었습니다. 저장할 위치를 선택하세요.')),
    );
  } catch (e) {
    // 오류 메시지 표시
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('저장 중 오류가 발생했습니다: $e')));
  }
}
