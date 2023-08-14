import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../flame_audio_test.dart';
import 'flappy_bird_game.dart';

class GameOverPage extends StatefulWidget {
  final FlappyBirdGame game;

  const GameOverPage({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  State<GameOverPage> createState() => _GameOverPageState();
}

class _GameOverPageState extends State<GameOverPage> {
  @override
  void initState() {
    super.initState();

    GameWidget(game: AudioGame()..fireTwo());
  }

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
                widget.game.overlays.remove('gameOver');
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
