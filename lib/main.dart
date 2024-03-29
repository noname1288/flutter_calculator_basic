import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var userQuestion = '';
  var userAnswer = '';
  var res_Answer;
  var fixedLength = 14;
  var fixedFontSize = 40;

  final List<String> buttons = [
    'C',
    'Del',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'Ans',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.deepPurple[100],
            body: Column(
              children: <Widget>[
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userQuestion,
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        userAnswer,
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                  ],
                )),
                Expanded(
                    flex: 2,
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          //Clear button
                          if (index == 0) {
                            return MyButtons(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = '';
                                  userAnswer = '';
                                });
                              },
                              buttonText: buttons[index],
                              color: Colors.red[300],
                              textColor: Colors.white,
                            );
                          }

                          // Del button
                          else if (index == 1) {
                            return MyButtons(
                              buttonTapped: () {
                                setState(() {
                                  if (userQuestion.length == 0) {
                                    userQuestion = '';
                                  } else
                                    userQuestion = userQuestion.substring(
                                        0, userQuestion.length - 1);
                                });
                              },
                              buttonText: buttons[index],
                              color: Colors.amber[300],
                              textColor: Colors.white,
                            );
                          }

                          // ANS button
                          else if (index == buttons.length - 2) {
                            return MyButtons(
                                buttonTapped: () {
                                  setState(() {
                                    userAnswer = res_Answer;
                                  });
                                },
                                buttonText: buttons[index],
                                color: Colors.deepPurple,
                                textColor: Colors.white);
                          }

                          // Equal button
                          else if (index == buttons.length - 1) {
                            return MyButtons(
                              buttonTapped: () {
                                setState(() {
                                  result();
                                });
                              },
                              buttonText: buttons[index],
                              color: isOperate(buttons[index])
                                  ? Colors.deepPurple
                                  : Colors.white,
                              textColor: isOperate(buttons[index])
                                  ? Colors.white
                                  : Colors.deepPurple,
                            );
                          }
                          // Others
                          else {
                            return MyButtons(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion += buttons[index];
                                });
                              },
                              buttonText: buttons[index],
                              color: isOperate(buttons[index])
                                  ? Colors.deepPurple
                                  : Colors.white,
                              textColor: isOperate(buttons[index])
                                  ? Colors.white
                                  : Colors.deepPurple,
                            );
                          }
                        })),
              ],
            )));
  }

  bool isOperate(String x) {
    if (x == '+' || x == '-' || x == 'x' || x == '/' || x == '%' || x == '=')
      return true;
    else
      return false;
  }

  void result() {
    res_Answer = userAnswer;
    String res = userQuestion;
    res = res.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(res);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
