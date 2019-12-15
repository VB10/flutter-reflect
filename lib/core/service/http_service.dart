import 'package:refsample/core/utility/app_constants.dart';

import 'http_manager.dart';

class HttpService {
  static HttpService _instance;
  HttpManager baseHttp;

  HttpService._init() {
    baseHttp = HttpManager(baseUrl: AppConstants.API_URL);
  }

  static HttpService get instance => _instance ?? HttpService._init();
}
