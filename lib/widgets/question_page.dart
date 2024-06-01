import 'package:flutter/material.dart';
import 'package:tests_system/widgets/answer_button.dart';

class QuestionPage extends StatelessWidget {
  final String question;
  final List<String> answers;
  final void Function(String) onAnswer;
  final int questionIndex;
  final int totalQuestions;

  QuestionPage({
    required this.question,
    required this.answers,
    required this.onAnswer,
    required this.questionIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Question ${questionIndex + 1} of $totalQuestions',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 41, 199, 9)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Text(
            question,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ...answers.map((answer) {
            return AnswerButton(answerText: answer, onAnswer: onAnswer);
          }).toList(),
        ],
      ),
    );
  }
}
