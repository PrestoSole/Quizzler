import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';

void main() => runApp(const Quizzler());

/// Material App
@immutable
class Quizzler extends StatelessWidget {
  /// Keys
  const Quizzler({Key key}) : super(key: key);
  @override

  /// Material App
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
      ),
      home: const QuizPage(),
    );
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

  /// Alert Popup Function
  void alert() {
    final AlertStyle _alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: const TextStyle(fontWeight: FontWeight.bold),
      animationDuration: const Duration(),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.black,
        ),
      ),
      titleStyle: const TextStyle(
        color: Colors.red,
      ),
    );
    Alert(
      context: context,
      style: _alertStyle,
      type: AlertType.success,
      title: "Finished",
      desc: "You've reached the end of the quiz.",
      buttons: <DialogButton>[
        DialogButton(
          onPressed: () {
            setState(() {
              quizBrain.resetApp();
              scoreKeeper.clear();
              Navigator.pop(context);
            });
          },
          color: const Color.fromRGBO(0, 179, 134, 1.0),
          child: const Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          gradient: const LinearGradient(
            colors: <Color>[
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ],
          ),
          child: const Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  /// Check the user's answer Function
  void _onPressed(bool answer) {
    setState(() {
      if (quizBrain.isDone()) {
        alert();
      } else {
        final bool correctAnswer = quizBrain.getQuestionsAnswer();
        if (correctAnswer == answer) {
          scoreKeeper.add(
            const Icon(
              Icons.check,
              size: 24,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            const Icon(
              Icons.close,
              size: 24,
              color: Colors.red,
            ),
          );
        }
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
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
                      style: const TextStyle(
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
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      _onPressed(true);
                    },
                    child: const Text(
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
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      _onPressed(false);
                    },
                    child: const Text(
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
