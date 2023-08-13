import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'flappy_bird_game.dart';

class GameOverPage extends StatelessWidget {
  final FlappyBirdGame game;

  const GameOverPage({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   //DeviceOrientation.landscapeRight,
    // ]);
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Game Over!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]);
                game.overlays.remove('gameOver');
              },
              child: const Text(
                'End',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
