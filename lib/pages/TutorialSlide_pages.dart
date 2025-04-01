part of 'TutorialSlide.dart';

List<Widget> pages = [
  _pageOne(),
  _pageTwo(),
  _pageThree(),
  _pageFour(),
  _pageFive(),
  _pageSix(),
  _pageSeven(),
  _pageEight(),
  _pageNine(),
  _pageTen(),
];

// 전체 슬라이드의 배경색 설정
Color backgroundColor = const Color.fromARGB(255, 100, 100, 100); // 배경색 설정

// title 만들기
Container makeTitle(String title) {
  return Container(
    color: Colors.transparent,
    child: Text(title, style: setTextStyleShadow()),
  );
}

// Syntax Highlighting Box 만들기
Container makeCodeCell(String code) {
  final lines = code.split('\n'); // 코드 문자열을 줄 단위로 나눔

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 209, 209, 209), // 박스 배경색
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lines.length, (index) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 줄 번호 표시
            SizedBox(
              width: 25,
              child: Text(
                '${index + 1}', // 줄 번호
                style: setTextStyleBox(),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 4), // 줄 번호와 코드 간 간격
            // 세로 회색 줄 추가
            Container(
              width: 1, // 회색 줄의 너비
              height: 20, // 회색 줄의 높이 (텍스트 높이에 맞춤)
              color: Color.fromARGB(255, 83, 83, 83), // 회색 줄 색상
              margin: const EdgeInsets.only(right: 8), // 줄과 텍스트 간 간격
            ),

            const SizedBox(width: 4), // 줄 번호와 코드 간 간격
            // 코드 내용 표시
            Expanded(child: Text(lines[index], style: setTextStyleBox())),
          ],
        );
      }),
    ),
  );
}

// 첫번재 페이지
Container _pageOne() {
  const String title = '1. 프롬프트 목적';
  const String content1 = """
일반적으로 다음과 같이 2가지 목적으로 사용한다. 
""";

  const String content2 = """

검색의 경우, 
대화(interaction)을 통해 
원하는 정보를 얻고자 할 때 
유용하다. 

그리고 대부분의 많은 사람들이 
검색의 목적으로 
프롬프트를 사용한다.  

그런 이유로 맥락있는 대화와 
해당분야에 문해력을 가진 사람이라면
"만족도 높은 결과물"을 얻을 수 있다.

반면, 프롬프트로 자동화(=프로그래밍화)를, 
목적으로 한다면
""";

  const String content3 = """

를 하지 않으면 최소한의 성과도 얻을 수 없게 된다.
""";

  const String code1 = """
검색
자동화""";

  const String code2 = """
. 컴퓨팅 사고력
. 구조화된 프롬프트
. 소프트웨어와 연계""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/1.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          // Syntax Highlighting Box 추가
          makeCodeCell(code1),

          const Text(
            content2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code2),
          const Text(
            content3,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

// 두번째 페이지
Widget _pageTwo() {
  const String title = '2. 프롬프트는 명령이다';
  const String content1 = """
자동화 입장에서 프롬프트는 대화가 아닌 프로그래밍이다.
""";
  const String content2 = """

자동화의 프롬프트는 명세서가 되어야 한다. 
최초의 프롬프트가 "법칙"을 만들어야 한다.  
그 이후에 입력되는 프롬프트는 
첫 번째 입력의 법칙으로
해석되고 반응하게 된다. 

[*]
windows 95부터 제공된 
도스창(CMD)에는
타이틀이 [명령 프롬프트]였다. 
프롬프트는 소프트웨어 관점에서
명령일 뿐이다.  

""";

  const String code1 = """
대화(X)
명령(O)""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/2.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code1),

          const Text(
            content2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          // Syntax Highlighting Box 추가
        ],
      ),
    ),
  );
}

// 세번째 페이지
Widget _pageThree() {
  const String title = '3. 프롬프트는 맥락이다';
  const String content1 = """
프롬프트는 맥락에 따라 분석하며 반응한다.
맥락이 모호할 수록 "잘못된 정보"를 생산할 가능성이 
높아지게 된다. 
""";

  const String code1 = """
. 맥락은 대화(프롬프트)를 통해 
  만들어진다
. 처음대화에서 "맥락을 한 번에 정의" 
  하는 것이 좋다
. 맥락은 배경지식(상황, 상태)이다""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/3.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code1),
        ],
      ),
    ),
  );
}

// 네번째 페이지
Widget _pageFour() {
  const String title = '4. 프롬프트는 시스템';
  const String content1 = """
프롬프트는 시스템과 사용자로 역할을 구분해야 한다.
""";

  const String content2 = """
		
Open AI에서 제공하는 API 예제에서도
role을 정의한다.

자동화를 구현하기 위해서는
프롬프트에서 role을 "제공자"와 "사용자"로 			
분리한 후, 시스템의 구조를 만드는 것이 좋다.			
""";

  const String code1 = """
. 시스템 프롬프트 : 
  입력받는 모든 요구사항(프롬프트)의 
  법칙을 정한다.			
. 유저 프롬프트: 
  법칙 안에서 원하는 기능을 
  요청한다.""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/4.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code1),

          const Text(
            content2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

// 다섯번째 페이지
Widget _pageFive() {
  const String title = '5. 프롬프트는 프로그래밍';
  const String content1 = """
생성 AI로 자동화(프로그래밍화)를 만들고자 한다면 
엔지니어링 사고방식이 필요하다.			

자동화는 대화가 아닌 "기술명세서"를 
프롬프트로 만들어야 하기 때문이다. 			

그런 점에서 
인간의 언어와 기계의 언어(프로그래밍 언어)를 
구분하지  말아야 한다.			

핵심은 "맥락" 기반의 "기능명세서"이다. 			
""";

  const String content2 = """
		
중에서 가장 맥락적으로 완벽한 것이 
유리한 결과를 만들어낸다. 				

결과적으로 프로그래밍 언어를 사용할 수록 				
모호한 인간의 언어를 사용할 때보다 
높은 완성도를 보여준다.							
""";

  const String code1 = """
. 정형화된 문서		
. 의사코드		
. 프로그래밍 언어(또는 형식)""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/5.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code1),

          const Text(
            content2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

// 여섯번째 페이지
Widget _pageSix() {
  const String title = '6. 프롬프트가 전부는 아니다';
  const String content1 = """
생성 AI는 확률 AI이다. 			
1 +1 이 2가 아닐 수도 있다.			
			
요청하면 가장 근사한 것들 중 
하나를 선택하는 것이 생성 AI이다.			

완벽한 자동화는 
"프로그래밍"에서나 가능하다.					
""";

  const String content2 = """
""";

  const String code1 = """
. 생성 AI의  결과는 
  에이전트(ex: ChatGPT) 랜덤수치
  (=대충 여기서 골라봐)
  에 따라 달라진다				

. 맥락이 길어지면 
  잘못된 결과를 
  생성 하기도 한다(용량의 한계)				

. 학습의 내용, 모델(심지어 버전)에 따라 
  전혀다른 결과를 만든다				

. 인간의 요구(프롬프트)가 
  맥락상 완벽하지 않음				""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/6.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code1),

          const Text(
            content2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

// 일곱번째 페이지
Widget _pageSeven() {
  const String title = '7. 그럼에도 사용하는 이유';
  const String content1 = """
완벽하지 않을 뿐, 불필요한 것이 아니다.			
활용법만 터득하면 최고의 도구가 된다.							
""";

  const String content2 = """

대화를 잘하면 위의 3개의 장점을 얻을 수 있다. 				
단지 "자동화(프로그램화)" 부분에 있어서 
많은 문제가 있을 뿐이다.				
				
이것이 
AI 에이전트(프로그램)를 
만들어야 하는 이유이다.				
""";

  const String code1 = """
. 업무효율향상 : 
  AI를 활용하면 이전과는 
  비교할 수 없는 생산성을 
  가지게 된다.					

. 복잡한 문제해결: 
  내 수준으로 해결못하는 
  방법을 제시한다.					

. 나에게 특화된 정보: 
  대화(세션)의 정보를 통해 
  나에게 맞는 방법을 제시한다.						""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/7.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code1),

          const Text(
            content2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

// 여덜번째 페이지
Widget _pageEight() {
  const String title = '8. 프롬프트 구성';
  const String content1 = """
[완벽한 방법은 없다]  
다양한 프롬프트 작성 기법들이 제시되고 있다. 					

[방향은 존재한다]  
근거를 기반으로 할 일을 제시한다.					

[간결] 
문장이 아닌 명령으로 
단순화는 필수이다
(형용사, 감성 표현 글은 삭제필수).									
""";

  const String content2 = """
""";

  const String code1 = """
. 맥락:
  지금의 대화들이 어떤 상황에서 
  이루어지는 것인지 정의					

. 법칙: 
  요구에 대한 
  판단근거 및 방법을 제시					

. 요구 및 결과: 
  맥락과 법칙을 근거로 
  요구를 분석하고 결과를 도출
  하는 예를 제시										""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/8.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code1),

          const Text(
            content2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

//아홉번째 페이지
Widget _pageNine() {
  const String title = '9. 프롬프트 다양한 기법';
  const String content1 = """
개발자 입장에서 API 개발을 하다보면 알게되는 것 
- 프롬프트의 매뉴얼화.								
""";

  const String content2 = """

그리고 마크다운 문법도 많이 사용하게 된다. 
명세서와 같은 구조에서 많이 사용하기 때문이다.
""";

  const String code1 = """
. 역할정의 :
  Role을 시스템과 유저로 
  정리하여 기술한다
  (API 문서내용)						

.의사코드: 
  수학적, 논리적 방법을 활용 

.프로그래밍 문법:
  JSON 및 소스코드를 
  프롬프트로 활용하면 
  월등한 결과를 
  얻을 수 있다														""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/9.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code1),

          const Text(
            content2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}

//마지막 페이지
Widget _pageTen() {
  const String title = '10. 결국, 컴퓨팅 사고력';
  const String content1 = """
AI 에이전트를 개발하다보면 알게되는 것 
- 프로그래머의 사고방식이 필요함					
"AI 에이전트 = 프롬프트 + 프로그래밍"
이므로 논리적 코딩 능력이 필수임											
""";

  const String content2 = """
""";

  const String code1 = """
. 프로그래밍 사고방식으로 
  프롬프트 만들기				

. 생성 AI의 장점:  
  한글로 (의사코드)로 만들어도 
  소스코드로 변환 가능				

. 결국은 
  "프롬프트 작성자가 
  개발자와 같은 역할"을 
  하는 것																""";

  return Container(
    color: backgroundColor, // 배경을 설정
    width: double.infinity, // 가로를 화면 전체로 설정
    height: double.infinity, // 세로를 화면 전체로 설정
    child: DefaultTextStyle(
      style: setTextStyleNormal(),
      child: ListView(
        padding: const EdgeInsets.all(16), // 여백 추가
        children: [
          SizedBox(height: 16),
          makeTitle(title),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/10.jpg',
              fit: BoxFit.contain,
              color: Colors.grey, // 회색으로 변경
              colorBlendMode: BlendMode.saturation, // 색상 혼합 모드 설정
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Text('이미지를 불러올 수 없습니다')),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            content1,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),

          makeCodeCell(code1),

          const Text(
            content2,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
