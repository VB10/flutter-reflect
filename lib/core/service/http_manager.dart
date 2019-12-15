import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reflectable/reflectable.dart';
import 'package:refsample/core/model/not_found.dart';

import '../model/query_model.dart';
import '../model/result_model.dart';
import 'reflaction.dart';

enum HttpType { GET, POST }

class _HttpManagerHelper {
  static const FROM_JSON = "fromJson";
}

class HttpManager {
  String baseUrl;
  String queryParamsUrl = "";
  HttpType type = HttpType.GET;
  Map<String, String> header = {};

  HttpManager({@required this.baseUrl});

  HttpManager addQueryModel(KeyValue queryModel) {
    queryParamsUrl +=
        "$queryParamBridgeCharacter${queryModel.key}=${queryModel.value}";
    return this;
  }

  String get queryParamBridgeCharacter =>
      queryParamsUrl.contains("?") ? "&" : "?";

  HttpManager addHeader(KeyValue headerModel) {
    header[headerModel.key] = headerModel.value;
    return this;
  }

  Future get<T extends BaseResultModel>(String path,
      {bool isList = false}) async {
    ClassMirror classMirror = reflector.reflectType(T);

    final response =
        await http.get("$baseUrl/$path/$queryParamsUrl", headers: header);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return isList
            ? jsonToList<T>(classMirror: classMirror, body: response.body)
            : jsonToObject<T>(classMirror: classMirror, body: response.body);
      default:
        return NotFound(description: response.statusCode.toString());
    }
  }

  dynamic jsonSerialize(dynamic jsonResponse) => json.decode(jsonResponse);

  List<T> jsonToList<T>({@required ClassMirror classMirror, dynamic body}) {
    body = jsonSerialize(body);
    var listRepsonse = List<T>();
    if (body is List) {
      body.forEach((item) {
        T responsChildValue =
            classMirror.newInstance(_HttpManagerHelper.FROM_JSON, [item]);
        listRepsonse.add(responsChildValue);
      });
    }
    return listRepsonse;
  }

  T jsonToObject<T>({@required ClassMirror classMirror, dynamic body}) {
    body = jsonSerialize(body);

    T responsChildValue =
        classMirror.newInstance(_HttpManagerHelper.FROM_JSON, [body]);
    return responsChildValue;
  }
}
