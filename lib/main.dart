import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app/Questions.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});



  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Questions> questions = [
     Questions('You can lead a cow down stairs but not up stairs.', false),
    Questions('Approximately one quarter of human bones are in the feet.', true),
    Questions('A slug\'s blood is green.', true)
  ];

  List<Icon> scoreKeeper = [];



  int questionNumber = 0;


  void checkAnswers( bool answer ){

    if( answer == questions[questionNumber].answer ){

      setState(() {
        scoreKeeper.add( const Icon(
          Icons.check,
          color: Colors.green,
        ) );
        ++questionNumber;
      });

    }
    else{
      setState(() {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
        ++questionNumber;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[questionNumber].question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(

              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
                textStyle: WidgetStatePropertyAll<TextStyle>(
                    TextStyle(
                        color: Colors.white
                    )
                ),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswers(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.red)
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswers(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
