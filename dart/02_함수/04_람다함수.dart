void main(List<String> args) {
  // 람다함수
  // Dart 에서 화살표 함수는 표현식만 가능 (return 및 2줄 이상 불가)
  var add = (int a, int b) => a + b;
  print("add() 호출 결과 : ${add(10, 20)}");

  List<int> list = [1, 2, 3, 4, 5];
  List<int> newList = list.map((item) => item *2).toList();
  print("newList : $newList");

}