import 'package:url_launcher/url_launcher.dart';

extension LauncherExtensions on String {
  void hello() {
    print("$this : hello");
  }

  Future<void> callPhone() async {
    if (await canLaunch("tel:$this")) {
      launch("tel:$this");
    }
  }
}
