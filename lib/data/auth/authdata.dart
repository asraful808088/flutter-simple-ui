import 'package:flutter/foundation.dart';
import 'package:megawallet/components/opoup/box.dart';

class AuthData extends ChangeNotifier {
  late bool popup = false;
  late String message = "Some Message";
  late GETDATA stage = GETDATA.PANDING;
  late int index = 2;
  void changePage({required int index}) {
    this.index = index;
    notifyListeners();
  }

  void changePopup() {
    popup = !popup;
    notifyListeners();
  }
}
