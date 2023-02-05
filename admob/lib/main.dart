import 'package:get/get.dart';
import 'package:admob/controller.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customKeyboard.dart';

// 2차함수 생성기

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Quadratic equation problem generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final checkAlpha = TextEditingController();
  final checkBeta = TextEditingController();

  final controller = Get.put(Controller());

  late String operator1, operator2;
  late int num1, num2;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() {
    controller.refreshAlpha();
    controller.refreshBeta();
    controller.initChangeAnswer1();
    controller.initChangeAnswer2();

    num1 = controller.alpha + controller.beta;
    num2 = controller.alpha * controller.beta;
    if (num1 > 0) {
      operator1 = '-';
    } else if (num1 < 0) {
      operator1 = '+';
    } else {
      operator1 = 'none';
    }
    if (num2 > 0) {
      operator2 = '+';
    } else if (num2 < 0) {
      operator2 = '-';
    } else {
      operator2 = 'none';
    }

    num1 = num1.abs();
    num2 = num2.abs();
  }

  void refreshButton() {
    setState(() {
      refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: portrait(),
      floatingActionButton: FloatingActionButton(
        onPressed: refreshButton,
        tooltip: 'refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget portrait() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Math.tex(
            operator1 == 'none'
                ? operator2 == 'none'
                    ? 'x^2 = 0'
                    : 'x^2 $operator2 $num2 = 0'
                : operator2 == 'none'
                    ? num1 == 1
                        ? 'x^2 $operator1 x = 0'
                        : 'x^2 $operator1 {$num1}x = 0'
                    : num1 == 1
                        ? 'x^2 $operator1 x $operator2 $num2 = 0'
                        : 'x^2 $operator1 {$num1}x $operator2 $num2 = 0',
            mathStyle: MathStyle.display,
            textStyle: const TextStyle(
              fontSize: 50,
            ),
          ),
          const SizedBox(height: 30),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Math.tex(
                  r"\alpha: ",
                  mathStyle: MathStyle.display,
                  textStyle: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: controller.whichBox
                            ? Colors.black
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  width: 30,
                  child: Text(
                    controller.answer1,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 40),
                Math.tex(
                  r"\beta: ",
                  mathStyle: MathStyle.display,
                  textStyle: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: controller.whichBox
                            ? Colors.transparent
                            : Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  width: 30,
                  child: Text(
                    controller.answer2,
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[100]),
            onPressed: () {
              controller.initChangeAnswer1();
              controller.initChangeAnswer2();
            },
            // \u{CD08}\u{AE30}\u{D654}
            child: Math.tex(
              r"\alpha,\beta초기화",
              mathStyle: MathStyle.display,
              textStyle: const TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 100),
          keyboard(),
        ],
      ),
    );
  }

  Widget keyboard() {
    return CustomKeyboard();
  }
}
