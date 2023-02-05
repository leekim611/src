import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:voca/controller/controller.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Controller controller = Controller();
  late Stream stream;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int maxNum = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('sentence').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(" ");
            }
            maxNum = snapshot.data!.docs.length;
            return Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 200,
                    child: Text(
                      "${snapshot.data!.docs[controller.rn.value]['mean']}"
                          .replaceAll("\\n", "\n"),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 300,
                    child: Obx(
                      () => TextButton(
                        // style: TextButton.styleFrom(
                        //   backgroundColor: Colors.yellow,
                        // ),
                        child: Text(
                          "${snapshot.data!.docs[controller.rn.value]['sentence']}",
                          style: TextStyle(
                            color: controller.tf.value
                                ? Colors.black
                                : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onPressed: () {
                          controller.tfChanger();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async {
          controller.rnChanger(maxNum);
        },
      ),
    );
  }
}
