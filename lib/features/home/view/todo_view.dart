import 'package:flutter/material.dart';

import '../../../core/service/http_manager.dart';
import '../../../core/service/http_service.dart';
import '../model/todo.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  HttpManager service = HttpService.instance.baseHttp;

  Future<List<Todo>> getListTodoObjects() async =>
      await service.get<Todo>("todos", isList: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Todo>>(
        future: getListTodoObjects(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Text(snapshot.data[index].title);
                  },
                );
              }
              return Text("not found");
            default:
              return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
