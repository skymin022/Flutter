class Dog { 
  String _name;
  int _age;

  Dog(this._name, this._age);

  void bark() {
    print('$_name : 멍멍');
  }

  void sleep() {
    print('$_name : 쿨쿨');
  }

}