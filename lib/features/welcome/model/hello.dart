import 'package:refsample/core/model/result_model.dart';
import 'package:refsample/core/service/reflaction.dart';

@reflector
class Hello {
  String message;
  int age;

  Hello();

  Hello.setMessage(String text) {
    message = text;
  }

  void printName() => print(this.message);
}
