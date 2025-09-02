# 화면 이동 관련 코드 리뷰 
```
    Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => SecondScreen())
    );

```
1. Navigator.push()
: Flutter 에서 화면 전을 담당하는 메서드
- 현재 화면 위에 새로운 화면을 쌓아준다. 
- 뒤로가기 버튼을 누르면 이전 화면으로 돌아온다.

2. context
: 현재 위젯의 BuildContext.
* BuildContext
: 여러 위젯들을 트리 구조 안에서 관리하는데,
  이 위젯들이 어디에 위치해 있는지 알려주는 객체.
  * buildContext를 사용하면, 
  부모/조상(상위) 위젯에 접근할 수 있고, 
  Theme, Navigator, MediaQuery 등의 상위에서 제공하는 정보 접근 가능하다. 

3. MaterialPageRoute
: Flutter에서 화면 전환을 위해 사용하는 Route 클래스 
- 화면 전환 애니메이션 등을 적용해준다. 
(MaterialPAgeRoute vs CupertinoPageRoute)
(안드로이드 스타일 vs iOS 스타일)

4. builder: (context) => SecondScreen() 
   builder: (context) => 이동할 화면 위젯() 
: 빌더 함수를 통해서 이동할 화면을 지정하는 속성 

