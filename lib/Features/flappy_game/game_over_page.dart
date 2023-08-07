import 'package:flutter/material.dart';

import 'flappy_bird_game.dart';

class GameOverPage extends StatelessWidget {
  final FlappyBirdGame game;

  const GameOverPage({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Game Over!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // TextButton(
            //   onPressed: () {
            //     game.restartGame();
            //     game.overlays.remove('gameOver');
            //   },
            //   child: const Text(
            //     'Restart',
            //     style: TextStyle(
            //       fontSize: 20,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
