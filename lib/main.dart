import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/binding.dart';
import 'package:quiz_app/QuestionBank.dart';
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

  QuestionBank qb = QuestionBank();
  List<Icon> scoreKeeper = [];
  int questionNumber = 0;


  void checkAnswers( bool answer ){

    if( answer == qb.getAnswer() ){

      setState(() {
        scoreKeeper.add( const Icon(
          Icons.check,
          color: Colors.green,
        ) );
        qb.nextQuestion();
      });

    }
    else{
      setState(() {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
        qb.nextQuestion();
      });
    }

  }

  // void alert(BuildContext context){
  //
  //   Alert(
  //     context: context,
  //     title: "Yooo",
  //     desc: "The quiz is over ",
  //     buttons: [DialogButton(
  //       onPressed: () {
  //           Navigator.pop(context);
  //         },
  //       width: 120.0,
  //       child: const Text(
  //         "Okay",
  //         style: TextStyle(
  //             color: Colors.white
  //         ),
  //       ),
  //     )],
  //   ).show();
  // }

  List<Widget> display(){

    if( qb.isFinished() ){

      // Alert(
      //   context: context,
      //   title: "Yooo",
      //   desc: "The quiz is over ",
      //   buttons: [DialogButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     width: 120.0,
      //     child: const Text(
      //       "Okay",
      //       style: TextStyle(
      //           color: Colors.white
      //       ),
      //     ),
      //   )],
      // ).show();

      return [
        const Expanded(
        flex: 5,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              "You Completed the quize",
              textAlign: TextAlign.center,
              style: TextStyle(
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
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.lightBlueAccent),
              textStyle: WidgetStatePropertyAll<TextStyle>(
                  TextStyle(
                      color: Colors.white
                  )
              ),
            ),
            child: const Text(
              'Restart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              setState(() {
                qb.restart();
                scoreKeeper = [];
              });
            },
          ),
        ),
      ),
        Row(
          children: scoreKeeper,
        ),
      ];

    }
    else{
      return[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                qb.getQuestion(),
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
      ];
    }



  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: display(),
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
