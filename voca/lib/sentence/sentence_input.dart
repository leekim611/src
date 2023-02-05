import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  TextEditingController meanController = TextEditingController();
  TextEditingController sentenceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Mean:   "),
                SizedBox(
                  child: TextField(
                    controller: meanController,
                  ),
                  width: 300,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sentence:   "),
                SizedBox(
                  child: TextField(
                    controller: sentenceController,
                  ),
                  width: 300,
                ),
              ],
            ),
            SizedBox(height: 50),
            TextButton(
              child: Text("send"),
              onPressed: () async {
                final data = {
                  "mean": meanController.text,
                  "sentence": sentenceController.text,
                };
                await FirebaseFirestore.instance
                    .collection('sentence')
                    .doc()
                    .set(data)
                    .then((documentSnapshot) => print("Added Data"));
                meanController.clear();
                sentenceController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
