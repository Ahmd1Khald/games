import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../clock_game/home_page.dart';
import '../../../darkness_game/menu.dart';
import '../../../flappy_game/flappy_bird_game.dart';
import '../../../flappy_game/game_over_page.dart';
import '../../../tetris_game/board.dart';

class GamesMenu extends StatelessWidget {
  GamesMenu({Key? key}) : super(key: key);

  final game = FlappyBirdGame();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GameBoard(),
                        ));
                  },
                  child: Container(
                    height: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: const Center(child: Text('Tetris Game')),
                  ),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  },
                  child: Container(
                    height: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: const Center(child: Text('Clock Game')),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameWidget(
                            game: game,
                            overlayBuilderMap: {
                              'gameOver': (context, _) =>
                                  GameOverPage(game: game),
                            },
                          ),
                        ));
                  },
                  child: Container(
                    height: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: const Center(child: Text('Flappy Game')),
                  ),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Menu(),
                        ));
                  },
                  child: Container(
                    height: 100,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: const Center(child: Text('Darknees Game')),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
