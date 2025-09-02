import 'Dog.dart';

class Person { 
  // 변수
  // Dart 에서는 public, private(_)
  // - public : 외부에서 접근 가능
  // - private : 외부에서 접근 불가능 (_)

  String name; // public
  int _age; // private 
  // 생성자
  Person(this.name, this._age);
  // 메소드
  void introduce() {
    print('안녕하세요, 제이름은 $name 나이는 $_age입니다.');
  }
}

void main(List<String> args) {
  // 객체 생성
  Person person =Person("홍길동", 30);
  person.introduce();

  person.name = "트럼프";
  // 같은 파일 내에서는 private 변수에 접근 가능 
  person._age = 77;

  person.introduce();


  // 외부 파일 가져오기 : import
  // import 'Dog.dart';
  Dog dog = Dog("바둑이", 3);
  dog.bark();

  // _name, _age 접근 불가 :: private 변수이기 때문 
  // dog._name = "뭉치";
  // dog.age = 4;

}

