import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() => runApp(Phoenix(child: const Quizzler()));

/// Material App
@immutable
class Quizzler extends StatelessWidget {
  /// Keys
  const Quizzler({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[900],
            primaryColor: Colors.grey[900]),
        home: QuizPage());
  }
}

/// The Brain
class QuizPage extends StatefulWidget {
  /// Keys
  const QuizPage({Key key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  /// scoreKeeper stores the user's answers
  final List<Icon> scoreKeeper = <Icon>[];
  final QuizBrain quizBrain = QuizBrain();

  /// Check the user's answer Function
  void _onPressed(bool answer) {
    if (quizBrain.isDone()) {
      return;
    }
    final bool correctAnswer = quizBrain.getQuestionsAnswer();
    if (correctAnswer == answer) {
      setState(() {
        scoreKeeper.add(
          Icon(
            Icons.check,
            size: 30,
            color: Colors.green,
          ),
        );
      });
    } else {
      setState(() {
        scoreKeeper.add(
          Icon(
            Icons.close,
            size: 30,
            color: Colors.red,
          ),
        );
      });
    }

    quizBrain.nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.grey[900],
        leading: IconButton(
          icon: Icon(
            Icons.refresh,
          ),
          onPressed: () {
            Phoenix.rebirth(context);
          },
        ),
      ),
      //backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /// This expanded widget displays the questions
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionsText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              /// This expanded widget displays the true button
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FlatButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      _onPressed(true);
                    },
                    child: Text(
                      'True',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),

              /// This expanded widget displays the false button
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      _onPressed(false);
                    },
                    child: Text(
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              /// This is were the checks and closes are displayed
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: scoreKeeper,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
