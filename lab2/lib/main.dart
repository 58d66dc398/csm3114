import 'package:first_app/result.dart';
import 'package:flutter/material.dart';
import 'question.dart';
import 'answer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questionIndex = 0, score = 0;

  List<Map<String, Object>> questions = [
    {
      'question': "1 + 1",
      'answers': ['2', '11'],
      'answer': 0
    },
    {
      'question': "Which one is feline?",
      'answers': ['dog', 'cat'],
      'answer': 1
    },
    {
      'question': "Which is the better discount?",
      'answers': ['15%', '10%'],
      'answer': 0
    }
  ];

  void restartQuiz() {
    questionIndex = score = 0;
  }

  void answerQuestion(String choice, String answer) {
    if (choice == answer) score++;

    setState(() {
      if (++questionIndex >= questions.length) {
        print('Question finished');
      } else {
        print(questionIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: questionIndex < questions.length
              ? Column(
                  children: [
                    Question(questions[questionIndex]['question'].toString()),
                    ...(questions[questionIndex]['answers'] as List<String>)
                        .map((choice) => Answer(
                            answerQuestion,
                            choice,
                            (questions[questionIndex]['answers']
                                    as List<String>)[
                                int.parse(questions[questionIndex]['answer']
                                    .toString())])),
                  ],
                )
              : Result(score, restartQuiz)),
    ));
  }
}
