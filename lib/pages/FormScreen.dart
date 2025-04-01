import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';
import 'package:promptform/Utils/FontUtil.dart';
import 'package:promptform/mobile_file_operations.dart'
    if (dart.library.html) 'package:promptform/web_file_operations.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // 각 항목의 입력값을 저장하는 맵
  final Map<String, String> formValues = {
    '제목': '',
    '작성자': '',
    '목적': '',
    '환경': '',
    '기능정의': '',
    '결과요청': '',
  };

  String hint1 = '제목\n(예: 시스템 프롬프트 작성)';
  String hint2 = '작성자\n(예: 상품 기획자: IT 제품을 상품기획 한다)';
  String hint3 = '목적\n(예: 소셜마케팅 서비스 런칭목표)';
  String hint4 = '환경\n(예: 웹, 모바일, 데스크탑 등)';
  String hint5 = '기능정의\n(예: 사용자에게 제공할 기능을 정의.)';
  String hint6 = '결과요청\n(예: 초기기획서 작성, 준비할 내용 리스트 작성)';

  @override
  Widget build(BuildContext context) {
    setSizeByMediaQuery(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // 화살표 아이콘
          onPressed: () {
            Navigator.pop(context); // 이전 페이지로 이동
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 218, 218, 218),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 36),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                _buildFormRow(label: '제목', hint: hint1),
                _buildFormRow(label: '작성자', hint: hint2),
                _buildFormRow(label: '목적', hint: hint3),
                _buildFormRow(label: '환경', hint: hint4),
                _buildFormRow(label: '기능정의', hint: hint5),
                _buildFormRow(label: '결과요청', hint: hint6),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'save',
              onPressed: _saveFormData,
              child: const Icon(Icons.save),
              tooltip: '저장하기',
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 8),
            FloatingActionButton(
              heroTag: 'load',
              onPressed: _loadFormData,
              child: const Icon(Icons.file_upload),
              tooltip: '가져오기',
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget _buildFormRow({String label = "", String hint = '내용을 입력하세요'}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 좌측 세로 텍스트
            Container(
              width: 40,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    for (int i = 0; i < label.characters.length; i++)
                      Text(
                        label.characters.elementAt(i),
                        style: setTextStyleTitle(),
                      ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            // 우측 Text (클릭 가능)
            Expanded(
              child: GestureDetector(
                onTap: () => _showInputBottomSheet(context, label),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.transparent, // 클릭 가능한 영역 확장
                  child: Text(
                    formValues[label]!.isEmpty ? hint : formValues[label]!,
                    style: setTextStyleNormal(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showInputBottomSheet(BuildContext context, String label) {
    final TextEditingController controller = TextEditingController(
      text: formValues[label],
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DefaultTextStyle(
            style: setTextStyleNormal(),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '$label 입력',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    style: setTextStyleNormal(),
                    controller: controller,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '내용을 입력하세요',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(16),
                    ),

                    onPressed: () {
                      setState(() {
                        formValues[label] = controller.text;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '저장',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // JSON 데이터를 Pretty Print 형식으로 변환
  String _getPrettyJsonString(Map<String, String> formValues) {
    const encoder = JsonEncoder.withIndent('  ');
    final wrappedJson = {"role": "system", "content": formValues};
    return encoder.convert(wrappedJson);
  }

  // 폼 데이터를 JSON 파일로 저장하는 함수
  Future<void> _saveFormData() async {
    try {
      // 현재 시간을 파일 이름에 사용
      final now = DateTime.now();
      final fileName =
          'prompt_${now.year}${now.month}${now.day}_${now.hour}${now.minute}.json';

      // 폼 데이터를 Pretty Print JSON 문자열로 변환
      final jsonData = _getPrettyJsonString(formValues);

      // 웹 환경에서는 파일 다운로드
      await downloadFile(context, jsonData, fileName);
    } catch (e) {
      // 오류 메시지 표시
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('저장 중 오류가 발생했습니다: $e')));
      }
    }
  }

  // JSON 파일에서 폼 데이터를 불러오는 함수
  Future<void> _loadFormData() async {
    try {
      if (kIsWeb) {
        // 웹 환경에서 파일 선택
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
          withData: true, // 웹에서는 파일 데이터를 바로 가져옴
        );

        if (result != null && result.files.single.bytes != null) {
          // 파일 내용을 UTF-8 문자열로 디코딩
          final jsonData = utf8.decode(result.files.single.bytes!);
          _processLoadedData(jsonData);
        }
      } else {
        // 모바일/데스크톱 환경에서 파일 선택
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
        );

        if (result != null && result.files.single.path != null) {
          final file = File(result.files.single.path!);
          final jsonData = await file.readAsString();

          _processLoadedData(jsonData);
        }
      }
    } catch (e) {
      // 오류 메시지 표시
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('불러오기 중 오류가 발생했습니다: $e')));
      }
    }
  }

  // 불러온 JSON 데이터 처리
  void _processLoadedData(String jsonData) {
    // JSON 데이터를 Map으로 변환
    final Map<String, dynamic> loadedData = jsonDecode(jsonData);

    // 래핑된 구조에서 content 필드만 추출
    if (loadedData.containsKey("content") &&
        loadedData["content"] is Map<String, dynamic>) {
      final Map<String, dynamic> contentData = loadedData["content"];
      setState(() {
        for (final key in formValues.keys) {
          if (contentData.containsKey(key)) {
            formValues[key] = contentData[key].toString();
          }
        }
      });

      // 성공 메시지 표시
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('데이터가 성공적으로 불러와졌습니다.')));
      }
    } else {
      // JSON 구조가 예상과 다를 경우 오류 메시지 표시
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('JSON 구조가 올바르지 않습니다.')));
      }
    }
  }
}
