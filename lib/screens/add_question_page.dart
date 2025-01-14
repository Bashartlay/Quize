import 'package:flutter/material.dart';
import 'package:tests_system/models/question_model.dart';
import 'package:tests_system/services/quiz_service.dart';

class AddQuestionPage extends StatelessWidget {
  final Function(Autogenerated) onQuestionAdded;
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> optionControllers =
      List.generate(4, (_) => TextEditingController());
  final TextEditingController correctAnswerController = TextEditingController();

  AddQuestionPage({required this.onQuestionAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              TextField(
                controller: questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              ...optionControllers.map((controller) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Option',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              TextField(
                controller: correctAnswerController,
                decoration: InputDecoration(
                  labelText: 'Correct Answer',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (questionController.text.isEmpty ||
                      optionControllers.any((controller) => controller.text.isEmpty) ||
                      correctAnswerController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all the fields'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    Autogenerated newQuestion = Autogenerated(
                      questionText: questionController.text,
                      answers: optionControllers.map((controller) => controller.text).toList(),
                      correctAnswer: correctAnswerController.text,
                    );

                    Autogenerated addedQuestion = await postQuiz(newQuestion);
                    onQuestionAdded(addedQuestion);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Question added successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                child: Text(
                  'Add Question',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 191, 0),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
