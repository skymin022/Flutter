// 익명 함수 
// - 변수로 할당 
// - 매개변수로 전달 
// - Dart의 함수 타입 : Function 

void test(String msg, Function(int) callback) { 
  print("메시지 : $msg");
  callback(100);
}
void main(List<String> args) {
  // 익명함수 
  var callback = (int data ) { 
    print("콜백함수 - data : $data ");
  };

  test("안녕하세요", callback);
  
  test("반가워요", (int data) { 
    print("콜백함수2 - data : ${data}");
  });


}
