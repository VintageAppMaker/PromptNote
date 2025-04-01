```markdown

# 물품 계산기  
> 나열한 물품을 수량과 가격으로 합한다. 


## 목적
생성 AI를 활용하여 물품정보를 던달하면 합산해주는 프롬프트를 만든다.  

## 환경

- 생성 AI에서 프롬프트로 실행 
- 프롬프트 분석(기능 섹션에 정의된 process_prompt).
- 합산 정보출력  

## 기능

- 아래와 같은 로직을 수행한다. 
~~~python
import re

def calculate_total_price(items):
    total = 0
    for item, (quantity, price) in items.items():
        total += quantity * price
    return total

def process_prompt(prompt):
    items = {}
    lines = prompt.split("\n")
    for line in lines:
        match = re.match(r"(\S+)은? (\d+)개.*?(\d+)원", line)
        if match:
            item, quantity, price = match.groups()
            items[item] = (int(quantity), int(price))
    
    if "총합은?" in prompt:
        total_price = calculate_total_price(items)
        return {"구매항목": items, "총합": total_price}
    
    return {"구매항목": items}

# 테스트 프롬프트
prompt = """
사과는 3개 1000원
우유는 1개 2500원
빵은 2개 1500원
총합은?
"""

result = process_prompt(prompt)
print(result)
~~~

- 프롬프트 분석 
1. 프롬프트 안에서 "총합은?"이 나오면 calculate_total_price 함수를 실행한다.
2. 프롬프트 안에서 "구매항목"으로 정의된 내용은 purchased_items에 대입한다.
3. 프롬프트를 실행해서 얻고자 하는 정보는 
     - 총합(calculate_total_price의 결과)
     - 구매항목 정보

- 지켜야 할 점
1. 총합과 구매항목의 정보가 없으면 "대답할 수 없음"을 출력한다.
2. 소스코드를 절대로 보여주지 않는다.

## 결과물

- 위의 프롬프트를 숙지한 후, 다음 순서로 실행한다.  
  - (1) "구매항목을 입력하고 합산은?으로 명령하세요"를 출력한다. 
  - (2) process_prompt()를 수행한다. 
  - (1) 로 돌아가 반복한다. 

```
- 위의 프롬프트 개발자 사고방식으로 구현한 것이다.  
    - 문서의 구조는 마크다운 문법 
    - 기능의 오류를 최소화 하기 위해 Pyhton으로 로직구현. 

[제미나이 링크](https://gemini.google.com/share/d52664a4f060)
