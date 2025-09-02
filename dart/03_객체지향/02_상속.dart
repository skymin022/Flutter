
class Animal { 
  String? name;
  int? age;

  // 기본 생성자
  // Animal();
  
  Animal(this.name, this.age);

  void eat() {
    print('$name는 밥 묵는다.');
  }

  void sleep() { 
    print ("$name : 나 잔다.");
  }

}

class Dog extends Animal { 
  // 부모 클래스의 기본 생성자가 자동으로 호출 
  // Dog(String name, int age);

  // 부모 생성자를 지정하여 호출 
  // : super(name, age);
   Dog(String name, int age) : super(name, age);

  void bark() {
    print('$name : 누구셔');
  }
}
class Cat extends Animal { 
  Cat(String name, int age) : super(name, age);
  void meow() {
    print('$name : 애옹.');
  }
}

void main(List<String> args) {
  Dog dog = Dog('댕댕이', 3);
  dog.eat();
  dog.bark();
  dog.sleep();

  Cat cat = Cat('애옹이', 2);
  cat.eat();
  cat.meow();
  cat.sleep();
  
}
