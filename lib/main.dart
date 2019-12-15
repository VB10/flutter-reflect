import 'package:flutter/material.dart';

import 'features/home/view/todo_view.dart';
import 'features/welcome/view/hello_view.dart';
import 'main.reflectable.dart';

void main() {
  initializeReflectable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HelloView(),
    );
  }
}
