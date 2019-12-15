import 'package:flutter/material.dart';
import 'package:refsample/core/model/not_found.dart';
import 'package:refsample/features/home/model/todo.dart';

import '../../../core/service/http_manager.dart';
import '../../../core/service/http_service.dart';
import '../model/photo.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HttpManager service = HttpService.instance.baseHttp;
  bool isServiceRequest = false;
  bool isLoading = false;
  dynamic photo;
  dynamic todos;

  Future getSingleObject() async {
    setState(() {
      isLoading = true;
    });
    var data = await service.get<Photo>("photos/3xsxs");
    setState(() {
      photo = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => getSingleObject(),
          child: Icon(Icons.question_answer),
        ),
        body: childBody);
  }

  Widget get childBody => isLoading
      ? progress
      : photo is Photo ? photoCard(photo) : _notFoundWidget(photo);

  Widget get progress => Center(child: CircularProgressIndicator());

  Widget photoCard(Photo photo) => Card(
        child: ListTile(
          title: Text(photo.title),
        ),
      );

  Widget _notFoundWidget(NotFound notFound) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.not_interested, size: 100),
            Text(notFound?.description ?? "Not Found",
                style: Theme.of(context).textTheme.display1)
          ],
        ),
      );
}
