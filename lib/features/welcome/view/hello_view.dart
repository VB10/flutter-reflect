import 'package:flutter/material.dart';
import 'package:reflectable/reflectable.dart';
import 'package:refsample/core/service/reflaction.dart';

import '../../../core/utility/url_extensions.dart';
import '../model/hello.dart';

class HelloView extends StatefulWidget {
  HelloView({Key key}) : super(key: key);

  @override
  _HelloViewState createState() => _HelloViewState();
}

class _HelloViewState extends State<HelloView> {
  Hello hello;
  @override
  void initState() {
    super.initState();
  }

  void getSample<T>() {
    ClassMirror classMirror = reflector.reflectType(T);
    print(classMirror);
    var hello1 = classMirror.newInstance("", []);
    if (hello1 is Hello) {
      hello1.age = 15;
      hello1.message = "oke";
      hello1.printName();
      setState(() {
        hello = hello1;
      });
    }
  }

  void getSample2<T>() {
    ClassMirror classMirror = reflector.reflectType(T);
    print(classMirror);
    var hello2 = classMirror.newInstance("setMessage", ["hello2"]);
    if (hello2 is Hello) {
      hello2.printName();
      setState(() {
        hello = hello2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getSample2<Hello>();
          await "+1 555 010 999".callPhone();
        },
      ),
      body: Center(
        child: hello == null ? LinearProgressIndicator() : Text(hello.message),
      ),
    );
  }
}
