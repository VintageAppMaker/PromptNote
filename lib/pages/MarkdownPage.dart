import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; // rootBundle 가져오기
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:promptform/Utils/FontUtil.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownPage extends StatefulWidget {
  final String mdFilePath;

  final bool isAppBar;

  const MarkdownPage({
    Key? key,
    required this.mdFilePath,
    required this.isAppBar,
  }) : super(key: key);

  @override
  _MarkdownPageState createState() => _MarkdownPageState();
}

class _MarkdownPageState extends State<MarkdownPage> {
  String _markdownText = '';

  @override
  void initState() {
    super.initState();
    _loadMarkdownFile();
  }

  Future<void> _loadMarkdownFile() async {
    try {
      // rootBundle을 사용하여 assets 파일 읽기
      final contents = await rootBundle.loadString(widget.mdFilePath);
      setState(() {
        _markdownText = contents;
      });
    } catch (e) {
      setState(() {
        _markdownText = '파일을 불러오는 데 실패했습니다: $e';
      });
    }
  }

  // URL을 열기 위한 함수
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    setSizeByMediaQuery(context); // 화면 크기에 따라 폰트 크기 설정
    return Scaffold(
      appBar:
          widget.isAppBar
              ? AppBar(
                title: const Text(''),
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back), // 화살표 아이콘
                  onPressed: () {
                    Navigator.pop(context); // 이전 페이지로 이동
                  },
                ),
              )
              : null,
      body: Container(
        color: Colors.white,
        child:
            _markdownText.isEmpty
                ? Center(child: CircularProgressIndicator()) // 로딩 중 표시
                : Markdown(
                  data: _markdownText,
                  onTapLink: (text, url, title) {
                    _launchURL(url!);
                  },
                  styleSheet: MarkdownStyleSheet(
                    // 본문 텍스트 스타일
                    p: setTextStyleNormal(),
                    // 헤더 스타일
                    h1: setStyle_H1(),
                    h2: setStyle_H2(),
                    h3: setStyle_H3(),
                    h4: setStyle_H4(),
                    // 코드 블록 스타일
                    code: setStyle_code(),
                    codeblockDecoration: BoxDecoration(
                      color: const Color.fromARGB(255, 226, 226, 226),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    // 인용 스타일
                    blockquote: setStyle_blockquote(),
                    horizontalRuleDecoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    // 링크 스타일
                    a: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                    blockquoteDecoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border(
                        left: BorderSide(color: Colors.grey[400]!, width: 4),
                      ),

                      borderRadius: BorderRadius.circular(4),
                    ),
                    tableBody: setTextStyleNormal(),
                  ),
                ),
      ),
    );
  }
}
