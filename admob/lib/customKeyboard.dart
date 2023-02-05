import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'keyboardKey.dart';

class CustomKeyboard extends StatelessWidget {
  final controller = Get.put(Controller());
  final keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    [
      Math.tex(
        r"\overleftrightarrow{\alpha\beta}",
        mathStyle: MathStyle.display,
        textStyle: const TextStyle(
          fontSize: 30,
        ),
      ),
      '0',
      '-/+'
    ],
  ];

  CustomKeyboard({super.key});

  onNumberPress(val) {
    controller.whichBox
        ? controller.changeAnswer1(val)
        : controller.changeAnswer2(val);
  }

  changeOperator() {
    controller.whichBox
        ? controller.changeOperatorAnswer1()
        : controller.changeOperatorAnswer2();
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
            children: x.map((y) {
              return Expanded(
                child: KeyboardKey(
                  label: y,
                  onTap: (val) {
                    y is Widget
                        ? controller.switchWhichBox()
                        : y == '-/+'
                            ? changeOperator()
                            : onNumberPress(val);
                  },
                  value: y,
                ),
              );
            }).toList(),
          ),
        )
        .toList();
  }

  renderConfirmButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => checkAnswer1(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void checkAnswer1(BuildContext context) {
    controller.answer1 == '' || controller.answer2 == ''
        ? null
        : checkAnswer2(context);
  }

  void checkAnswer2(BuildContext context) {
    if ((controller.transformAnswer1() == controller.alpha &&
            controller.transformAnswer2() == controller.beta) ||
        (controller.transformAnswer2() == controller.alpha &&
            controller.transformAnswer1() == controller.beta)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: const Text("Answer"),
            content: const Text("Correct"),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: const Text("Answer"),
            content: const Text("Wrong"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...renderKeyboard(),
            const SizedBox(height: 16.0),
            renderConfirmButton(context),
          ],
        ),
      ),
    );
  }
}
