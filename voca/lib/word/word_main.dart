import 'package:flutter/material.dart';
import 'package:voca/word/word_input.dart';
import 'package:voca/word/word_test.dart';

class WordMain extends StatelessWidget {
  const WordMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text(
                "input",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Input(),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text(
                "test",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Test(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
