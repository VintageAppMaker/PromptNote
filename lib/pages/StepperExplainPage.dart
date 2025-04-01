import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:promptform/Utils/FontUtil.dart';
import 'package:promptform/pages/MarkdownPage.dart';

class StepperExplainPage extends StatefulWidget {
  final String jsonPath; // JSON 경로명을 받을 변수

  const StepperExplainPage({Key? key, required this.jsonPath})
    : super(key: key);

  @override
  State<StepperExplainPage> createState() => _StepperExplainPageState();
}

class _StepperExplainPageState extends State<StepperExplainPage> {
  int _currentStep = 0;
  final List<Step> steps = []; // Step 객체를 저장할 리스트
  bool isLoading = true; // 로딩 상태를 나타내는 변수

  bool isAppBar = false;

  @override
  void initState() {
    super.initState();
    _loadStepsFromJson(widget.jsonPath); // JSON 파일에서 Step 데이터 로드
  }

  Step _createStep({
    required String title,
    required Widget content,
    required bool Function(int currentStep) isActiveCondition,
  }) {
    return Step(
      title: Text(title, style: setTextStyleTitle()),
      content: content,
      isActive: isActiveCondition(_currentStep),
    );
  }

  /// JSON 파일에서 Step 데이터를 로드하는 메서드
  Future<void> _loadStepsFromJson(String jsonPath) async {
    try {
      final String jsonString = await rootBundle.loadString(jsonPath);
      final List<dynamic> jsonData = jsonDecode(jsonString);

      setState(() {
        for (var stepData in jsonData) {
          steps.add(
            _createStep(
              title: stepData['title'],
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    child: Card(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 0.4,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          stepData['content'],
                          style: setTextStyleNormal(),
                        ),
                      ),
                    ),
                  ),
                  // 이미지 경로가 있을 경우
                  if (stepData['imagePath'] != null) ...[
                    const SizedBox(height: 10),
                    Image.asset(
                      stepData['imagePath'],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('이미지를 불러올 수 없습니다.');
                      },
                    ),
                  ],
                  // prompt 경로가 있을 경우
                  if (stepData['promptPath'] != null) ...[
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: Text('프롬프트 클립보드 복사', style: setTextStyleNormal()),
                      onPressed: () async {
                        String strPrompt = await rootBundle.loadString(
                          stepData['promptPath'],
                        );
                        Clipboard.setData(ClipboardData(text: strPrompt));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // 버튼 배경색
                        foregroundColor: Colors.grey, // 버튼 텍스트 색상
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // 둥근 모서리
                        ),
                      ),
                    ),
                  ],
                  // markdown 경로가 있을 경우
                  if (stepData['markdownPath'] != null) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 300, // 고정된 높이 설정
                      child: MarkdownPage(
                        mdFilePath: stepData['markdownPath'],
                        isAppBar: false,
                      ),
                    ),
                  ],
                ],
              ),
              isActiveCondition:
                  (currentStep) =>
                      currentStep >= int.parse(stepData['title']) - 1,
            ),
          );
        }
        isLoading = false; // 로딩 완료
      });
    } catch (e) {
      setState(() {
        isLoading = false; // 로딩 실패 시에도 로딩 상태를 false로 설정
      });
      debugPrint('Error loading steps: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    setSizeByMediaQuery(context);
    return Scaffold(
      appBar: AppBar(title: const Text(''), backgroundColor: Colors.white),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator()) // 로딩 중 표시
              : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Stepper(
                  currentStep: _currentStep,
                  onStepTapped: (step) {
                    setState(() {
                      _currentStep = step;
                    });
                  },
                  onStepContinue: () {
                    if (_currentStep < steps.length - 1) {
                      setState(() {
                        _currentStep += 1;
                      });
                    }
                  },
                  onStepCancel: () {
                    if (_currentStep > 0) {
                      setState(() {
                        _currentStep -= 1;
                      });
                    }
                  },
                  controlsBuilder: (
                    BuildContext context,
                    ControlsDetails details,
                  ) {
                    return Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentStep > 0)
                            ElevatedButton(
                              onPressed: details.onStepCancel,
                              child: const Text('이전'),
                            ),
                          if (_currentStep >= steps.length - 1)
                            ElevatedButton(
                              onPressed: () {
                                // 완료 버튼 클릭 시 동작
                                Navigator.pop(context);
                              },
                              child: const Text('완료'),
                            )
                          else
                            ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: const Text('다음'),
                            ),
                        ],
                      ),
                    );
                  },
                  steps: steps,
                ),
              ),
    );
  }
}
