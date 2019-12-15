import 'package:flutter/cupertino.dart';

class KeyValue {
  final String key;
  final String value;

  KeyValue({@required this.key, @required this.value})
      : assert(key.isNotEmpty & value.isNotEmpty);
}
