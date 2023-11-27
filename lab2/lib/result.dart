import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function restartQuiz;

  const Result(this.score, this.restartQuiz, {super.key});

  String get praise {
    return score > 2
        ? 'Good'
        : score > 0
            ? 'Ok'
            : 'Bad';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Your Score is: ",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Text(
              score.toString(),
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Text(
              praise,
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () => restartQuiz(), child: const Text('Restart'))
          ],
        ));
  }
}
