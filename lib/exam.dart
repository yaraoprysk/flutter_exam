// ignore_for_file: unnecessary_const, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';

class Exam extends StatefulWidget {
  const Exam({Key? key}) : super(key: key);

  @override
  _ExamState createState() => _ExamState();
}

class _ExamState extends State<Exam> {
  Random random = Random();

  late List<Map<String, dynamic>> arr1 = [];
  late List<Map<String, dynamic>> arr2 = [];

  bool toMuchRed = false;

  @override
  void initState() {
    super.initState();
    int randomNumber = random.nextInt(10) + 5;

    late List<Map<String, dynamic>> a1 = [];
    late List<Map<String, dynamic>> a2 = [];

    for (var i = 0; i < randomNumber; i++) {
      a1.add(<String, dynamic>{'text': 'Left${i}', 'color': Colors.grey});
      a2.add(<String, dynamic>{'text': 'Right${i}', 'color': Colors.grey});
    }

    setState(() {
      arr1 = a1;
      arr2 = a2;
    });
  }

  randomMoving() {
    final allElements = [...arr1, ...arr2];

    final allRed =
        allElements.where((item) => item['color'] == Colors.red).toList();
    final onlyRed = check(allElements, allRed);

    setState(() {
      toMuchRed = onlyRed;
    });

    if (!onlyRed) {
      int num = random.nextInt(2) + 0;

      if (arr1.isEmpty) num = 2;

      if (arr2.isEmpty) num = 1;

      final bool isArr1 = num == 1;
      final selectedArr = isArr1 ? arr1 : arr2;

      int num2 = random.nextInt(selectedArr.length) + 0;

      if (isArr1) {
        if (!selectedArr[num2]['text'].contains('Right')) {
          selectedArr[num2]['color'] = Colors.red;
        } else {
          selectedArr[num2]['color'] = Colors.grey;
        }
        setState(() {
          arr2.add(selectedArr[num2]);
          arr1.removeAt(num2);
        });
      } else {
        setState(() {
          if (!selectedArr[num2]['text'].contains('Left')) {
            selectedArr[num2]['color'] = Colors.red;
          } else {
            selectedArr[num2]['color'] = Colors.grey;
          }

          arr1.add(selectedArr[num2]);
          arr2.removeAt(num2);
        });
      }
    } else {
      int num2 = random.nextInt(allRed.length) + 0;

      allRed[num2]['color'] = Colors.grey;
      if (allRed[num2]['text'].contains('Right')) {
        setState(() {
          arr2.add(allRed[num2]);
          arr1.removeWhere(
              (element) => element['text'] == allRed[num2]['text']);
        });
      } else {
        setState(() {
          arr1.add(allRed[num2]);
          arr2.removeWhere(
              (element) => element['text'] == allRed[num2]['text']);
        });
      }
    }
  }

  check(allElements, allRed) {
    return allElements.length - allRed.length < allRed.length;
  }

  @override
  Widget build(BuildContext context) {
    print(arr1);
    print(arr2);
    return (Scaffold(
      body: SafeArea(
          child: Container(
        child: Stack(
          children: [
            Row(
              children: <Widget>[
                ListWidget(
                  // ignore: prefer_const_literals_to_create_immutables
                  list: arr1,
                ),
                SizedBox(
                  width: 50,
                ),
                ListWidget(
                  list: arr2,
                )
              ],
            ),
            Positioned(
              right: 50,
              bottom: 50,
              child: FloatingActionButton(
                onPressed: () {
                  randomMoving();
                },
              ),
            ),
            if (toMuchRed)
              Positioned(
                left: 50,
                bottom: 50,
                child: FloatingActionButton(
                  onPressed: () {
                    randomMoving();
                  },
                ),
              ),
          ],
        ),
      )),
    ));
  }
}

class ListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> list;

  ListWidget({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: ListView(
        children: list.map((item) => ListItem(data: item)).toList(),
      ),
    ));
  }
}

class ListItem extends StatelessWidget {
  final Map<String, dynamic> data;

  ListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 20,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: data['color']),
      child: Text(
        data['text'],
        style: TextStyle(color: Colors.yellow),
      ),
    );
  }
}
