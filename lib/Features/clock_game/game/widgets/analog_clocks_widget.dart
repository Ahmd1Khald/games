import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../score/score.dart';
import '../game.dart';

class AnalogClocksWidget extends StatelessWidget {
  const AnalogClocksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocBuilder<GameCubit, GameState>(
        buildWhen: (previous, current) {
          return previous.randomNumMap != current.randomNumMap;
        },
        builder: (context, state) {
          return ColoredBox(
            color: Colors.white,
            child: Row(
              children: _analogClocksWidget(
                state.randomNumMap,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _analogClocksWidget(Map<int, int>? randomNumMap) {
    final List<Widget> analogClocks = [];
    randomNumMap!.forEach((key, value) {
      analogClocks.add(
        _AnalogClocksWidgetBuild(
          hourHand: key,
          minuteHand: value,
        ),
      );
    });

    return analogClocks;
  }
}

class _AnalogClocksWidgetBuild extends StatelessWidget {
  const _AnalogClocksWidgetBuild({this.hourHand, this.minuteHand});

  final int? hourHand;
  final int? minuteHand;

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();

    return Flexible(
      child: Stack(
        children: [
          AnalogClockBuild(
            hourHand: hourHand,
            minuteHand: minuteHand,
          ),
          Center(
            child: SizedBox(
              height: 110,
              width: 110,
              child: InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                onTap: () {
                  if (answerTrue(gameCubit)) {
                    answerTrueReturn(gameCubit, context);
                  } else {
                    // -If the selected hour is wrong, it will work.
                    gameCubit.answerFalse();
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          contentPadding: const EdgeInsets.all(10),
                          children: <Widget>[
                            if (healthZero(gameCubit))
                              answerFalseAndHealthZero(gameCubit, context)
                            else
                              answerFalse(
                                context,
                              ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool answerTrue(gameCubit) => gameCubit.state.selectedHour == hourHand;

  void answerTrueReturn(gameCubit, BuildContext context) {
    gameCubit.answerTrue();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(10),
          children: <Widget>[
            GameDialog(
              title: "Congratulations",
              animation: 'answer_true.json',
              buttonText: "Next",
              onPressed: () {
                gameCubit.nextStage();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  bool healthZero(gameCubit) => gameCubit.state.health == 0;

  GameDialog answerFalseAndHealthZero(gameCubit, BuildContext context) {
    return GameDialog(
      title: "Game Over - Restart",
      animation: 'game_over.json',
      buttonText: "Restart",
      onPressed: () {
        final scoreCubit = context.read<ScoreCubit>();
        scoreCubit.saveScore(
          score: gameCubit.state.score,
        );
        gameCubit.gameOver();
        Navigator.pop(context);
      },
    );
  }

  GameDialog answerFalse(BuildContext context) {
    return GameDialog(
      title: "Try again",
      animation: 'answer_false.json',
      buttonText: "Try again",
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
