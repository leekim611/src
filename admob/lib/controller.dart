import 'package:get/get.dart';
import 'dart:math' as math;

class Controller extends GetxController {
  final _answer1 = ''.obs;
  get answer1 => _answer1.value;
  final _answer2 = ''.obs;
  get answer2 => _answer2.value;
  final _whichBox = true.obs;
  get whichBox => _whichBox.value;

  final _alpha = 100.obs;
  get alpha => _alpha.value;
  final _beta = 100.obs;
  get beta => _beta.value;

  void changeAnswer1(String value) {
    if (_answer1.value.length > 3) return;
    _answer1.value = _answer1.value + value;
  }

  void initChangeAnswer1() {
    _answer1.value = '';
  }

  void changeOperatorAnswer1() {
    _answer1.value.isEmpty
        ? _answer1.value = '-'
        : _answer1.value[0] == '-'
            ? _answer1.value = _answer1.value.replaceAll(RegExp('[^0-9]'), "")
            : _answer1.value = '-${_answer1.value}';
  }

  int transformAnswer1() {
    return int.parse(_answer1.value);
  }

  void changeAnswer2(String value) {
    if (_answer2.value.length > 3) return;
    _answer2.value = _answer2.value + value;
  }

  void initChangeAnswer2() {
    _answer2.value = '';
  }

  void changeOperatorAnswer2() {
    _answer2.value.isEmpty
        ? _answer2.value = '-'
        : _answer2.value[0] == '-'
            ? _answer2.value = _answer2.value.replaceAll(RegExp('[^0-9]'), "")
            : _answer2.value = '-${_answer2.value}';
  }

  int transformAnswer2() {
    return int.parse(_answer2.value);
  }

  void switchWhichBox() {
    _whichBox.value = !_whichBox.value;
  }

  void setWhichBoxTrue() {
    _whichBox.value = true;
  }

  void setWhichBoxFalse() {
    _whichBox.value = false;
  }

  void refreshAlpha() {
    _alpha.value = math.Random().nextInt(19) - 9;
  }

  void refreshBeta() {
    _beta.value = math.Random().nextInt(19) - 9;
  }
}
