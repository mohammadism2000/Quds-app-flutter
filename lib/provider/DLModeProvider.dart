import 'package:flutter/cupertino.dart';

class DLModeProvider extends ChangeNotifier {
  bool mode;
  DLModeProvider({required this.mode});

  setMode(bool state) {
    if (mode) {
      mode = false;
      notifyListeners();
    } else {
      mode = true;
      notifyListeners();
    }
  }

}
