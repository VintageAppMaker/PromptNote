import 'dart:async'; // Timer를 사용하기 위해 추가
import 'package:flutter/material.dart';
import 'package:promptform/Utils/FontUtil.dart';
import 'package:promptform/pages/FormScreen.dart';
import 'package:promptform/pages/MarkdownPage.dart';
import 'package:promptform/pages/StepperExplainPage.dart';
import 'package:promptform/pages/TutorialSlide.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer; // Timer 객체
  late TabController _tabController; // TabController 추가

  final List<String> _pages = [
    '프롬프트 입력은\n서술(X), 기술(O)',
    '대화가 아닌 명령',
    '1장의 요구서 형식'
  ];

  // ListTile을 만드는 메서드
  Widget _makeMarkDownListItem({
    String titleInfo = '',
    String subTitleInfo = '',
    String filePath = '',
  }) {
    return Container(
      color: Colors.white,
      child: Card(
        elevation: 0.4,
        color: const Color.fromARGB(252, 255, 255, 255),
        child: ListTile(
          title: Text(titleInfo, style: setTextStyleTitle()),
          subtitle: Text(subTitleInfo, style: setTextStyleNormal()),
          onTap: () {
            // MarkdownPage로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        MarkdownPage(mdFilePath: filePath, isAppBar: true),
              ),
            );
          },
        ),
      ),
    );
  }

  // 위젯 배열을 넘기는 함수
  // ...로 사용해야 함
  List<Widget> _makeBigListItem({
    required String imgPath,
    required String title,
    required String subTitle,
    required String pathStepper,
  }) {
    return [
      if (imgPath.isNotEmpty)
        Card(
          margin: const EdgeInsets.all(5),
          child: Container(
            padding: const EdgeInsets.all(30),
            color: const Color.fromARGB(186, 255, 255, 255),
            child: LimitedBox(
              maxHeight: 600,
              child: Image.asset(
                imgPath,
                fit: BoxFit.contain,
                color: Colors.grey, // 회색으로 변경
                colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Center(child: Text('')),
              ),
            ),
          ),
        ),
      SizedBox(height: 10),
      Container(
        margin: const EdgeInsets.only(left: 20),
        child: Text(title, style: setTextStyleTitle()),
      ),
      Container(
        margin: const EdgeInsets.only(left: 20),
        child: Text(subTitle, style: setTextStyleNormal()),
      ),

      SizedBox(height: 10),

      // 버튼 추가
      Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
          onPressed: () {
            // 버튼 클릭 시 동작
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StepperExplainPage(jsonPath: pathStepper),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // 버튼 배경색
            foregroundColor: Colors.grey, // 버튼 텍스트 색상
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // 둥근 모서리
            ),
          ),
          child: Text('보기', style: setTextStyleNormal()),
        ),
      ),

      SizedBox(height: 40),
    ];
  }

  // 페이지 아이템을 지정한다.
  List<List<Widget>> _makeAllItems() {
    // 첫번째 탭
    List<Widget> _Tab1ListItem = [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(right: 20),
        child: Text('기초', style: setTextStyleNormal()),
      ),
      SizedBox(height: 10),

      _makeMarkDownListItem(
        titleInfo: '1.프롬프트? ',
        subTitleInfo: '일반인을 위한 프롬프트 설명 \n#기초 #ChatGPT',
        filePath: 'assets/markdown_files/1.1.md',
      ),

      _makeMarkDownListItem(
        titleInfo: '2. 프롬프트, 윈도우 도스창 프롬프트?',
        subTitleInfo: '프롬프트는 대화가 아니라 명령이다.\n#기초 #ChatGPT',
        filePath: 'assets/markdown_files/1.2.md',
      ),

      _makeMarkDownListItem(
        titleInfo: '3. 프롬프트 시작하기 ',
        subTitleInfo: '간단한 수칙부터 체화하기\n#기초 #ChatGPT',
        filePath: 'assets/markdown_files/1.3.md',
      ),

      SizedBox(height: 10),
      Container(
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(right: 20),
        child: Text('중급', style: setTextStyleNormal()),
      ),
      SizedBox(height: 10),

      _makeMarkDownListItem(
        titleInfo: '4. 프롬프트 기본기',
        subTitleInfo: '문장보다는 사고방식이 중요하다.\n#중고급 #ChatGPT',
        filePath: 'assets/markdown_files/1.4.md',
      ),

      _makeMarkDownListItem(
        titleInfo: '5. 프롬프트 강력하게 만드는 방법?',
        subTitleInfo: '개발자 사고방식 체화하기\n#고급 #ChatGPT',
        filePath: 'assets/markdown_files/1.5.md',
      ),
    ];

    // 두번째 탭
    List<Widget> tab2ListItem = [
      ..._makeBigListItem(
        title: "프롬프트 만드는 과정",
        subTitle: "컴퓨팅 사고력으로 지시문 만들기",
        imgPath: "assets/images/computing_tk.jpg",
        pathStepper: "assets/data/prompt_1.json",
      ),
    ];

    // 세번째 탭
    final List<Widget> tab3ListItem = [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(right: 20),
        child: Text('1. Role 정하기(system, user)', style: setTextStyleNormal()),
      ),
      ..._makeBigListItem(
        title: "1. 시스템, 유저 프롬프트 #1",
        subTitle: "시스템과 유저로 구분하여 시스템 구성",
        imgPath: "",
        pathStepper: "assets/data/prompt_2.json",
      ),
      ..._makeBigListItem(
        title: "2. 시스템, 유저 프롬프트 #2",
        subTitle: "출력을 구체화 요구",
        imgPath: "",
        pathStepper: "assets/data/prompt_3.json",
      ),
      ..._makeBigListItem(
        title: "3. 시스템, 유저 프롬프트 #3",
        subTitle: "학생정보 정리",
        imgPath: "",
        pathStepper: "assets/data/prompt_4.json",
      ),

      SizedBox(height: 10),
      Container(
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(right: 20),
        child: Text('2. 매뉴얼 형식으로 만들기', style: setTextStyleNormal()),
      ),

      ..._makeBigListItem(
        title: "4. 근태 관리시스템 프롬프트 #1",
        subTitle: "일반 회사의 근태 매뉴얼 형식의 프롬프트",
        imgPath: "",
        pathStepper: "assets/data/prompt_5.json",
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.topRight,
        margin: const EdgeInsets.only(right: 20),
        child: Text('3. 구조화된 문서(json)으로 만들기', style: setTextStyleNormal()),
      ),

      ..._makeBigListItem(
        title: "5. 근태 관리시스템 프롬프트 #2",
        subTitle: "4. 근태 관리시스템 프롬프트 #1을 json으로 변형",
        imgPath: "",
        pathStepper: "assets/data/prompt_6.json",
      ),

      ..._makeBigListItem(
        title: "6. json + Role 프롬프트 #1",
        subTitle: "해적의 말투로 날씨 의뢰",
        imgPath: "assets/images/json_to_13.jpg",
        pathStepper: "assets/data/prompt_7.json",
      ),

      ..._makeBigListItem(
        title: "7. json  + Role 프롬프트 #2",
        subTitle: "데이터 전문가 입장에서 데이터 분석 의뢰",
        imgPath: "",
        pathStepper: "assets/data/prompt_8.json",
      ),
    ];

    List<Widget> tab4ListItem = [
      SizedBox(height: 10),
      ..._makeBigListItem(
        title: "8. 구매항목 계산기 ",
        subTitle: "마크다운 형식 + Python 코드로 만드는 계산기 명세서",
        imgPath: "assets/images/developer.jpg",
        pathStepper: "assets/data/prompt_9.json",
      ),

      ..._makeBigListItem(
        title: "9. 초간단 RPG 전투시스템 ",
        subTitle: "마크다운 형식 + Python 코드로 만드는 게임 명세서",
        imgPath: "",
        pathStepper: "assets/data/prompt_10.json",
      ),
    ];

    //탭 아이템 추가
    return [_Tab1ListItem, tab2ListItem, tab3ListItem, tab4ListItem];
  }

  List<List<Widget>> _tabItems = [];
  // Tab header
  List<String> tabHeaders = [
    '프롬프트가 알려주는 프롬프트',
    '프롬프트 과정 ',
    '자동화를 위한 프롬프트',
    '개발자의 프롬프트',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoFlip(); // 자동 페이지 전환 시작

    // tabItems 초기화
    _tabItems = _makeAllItems();

    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
    ); // TabController 초기화
  }

  @override
  void dispose() {
    _timer?.cancel(); // Timer 해제
    _pageController.dispose();
    _tabController.dispose(); // TabController 해제
    super.dispose();
  }

  void _startAutoFlip() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % _pages.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setSizeByMediaQuery(context); // 화면 크기에 따라 폰트 크기 설정
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // PageView 배너 (화면의 1/3 높이)
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(
                children: [
                  Container(color: Colors.grey),
                  PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children:
                        _pages.map((page) {
                          return _makeBannerPage(page);
                        }).toList(),
                  ),
                  // 인디케이터
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  _currentPage == index
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            // TabBar 배너 아래로 이동
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              isScrollable: true,
              tabs:
                  tabHeaders.map((header) {
                    return Tab(child: Text(header, style: setTextStyleTitle()));
                  }).toList(),
            ),
            // TabBarView 아래에 ListView 추가
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:
                    _tabItems.map((tabItem) {
                      return ListView.builder(
                        itemCount: tabItem.length,
                        itemBuilder: (context, index) {
                          return tabItem[index];
                        },
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: 'tutorial',
            onPressed: () {
              // TutorialSlide 실행
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TutorialSlide()),
              );
            },
            tooltip: '개발자의 프롬프트',
            shape: const CircleBorder(),
            child: const Icon(Icons.terminal), // 터미널 아이콘
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: 'prompt',
            onPressed: () {
              // FormScreen 실행
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormScreen()),
              );
            },
            tooltip: 'Prompt 만들기',
            shape: const CircleBorder(),
            child: const Icon(Icons.edit), // 연필 아이콘
          ),
        ],
      ),
    );
  }

  // 배너 페이지를 만드는 메서드
  Widget _makeBannerPage(String page) {
    return Container(
      color: const Color.fromARGB(255, 218, 218, 218),
      child: Center(child: Text(page, style: setTextStyleBigBanner())),
    );
  }
}
