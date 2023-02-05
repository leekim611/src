import 'package:flutter/material.dart';
import 'package:voca/sentence/sentence_input.dart';
import 'package:voca/sentence/sentence_test.dart';

class SentenceMain extends StatelessWidget {
  const SentenceMain({Key? key}) : super(key: key);

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
