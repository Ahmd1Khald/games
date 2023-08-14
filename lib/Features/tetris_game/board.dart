import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../flame_audio_test.dart';
import 'piece.dart';
import 'pixel.dart';
import 'values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L);
  int currentScore = 0;
  bool gameOver = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    GameWidget(game: AudioGame()..fireOne());
    //player.play(UrlSource('assets/audio/video-game-beeps-4_NWM.mp3'));
    startGame();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void startGame() {
    currentPiece.initializePiece();

    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(
      frameRate,
      (timer) {
        setState(() {
          clearLines();
          checkLending();

          if (gameOver == true) {
            timer.cancel();
            showGameOverDialog();
          }

          currentPiece.movePiece(Direction.down);
        });
      },
    );
  }

  void showGameOverDialog() {
    GameWidget(game: AudioGame()..fireTwo());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Game over"),
        content: Text("Your score si : $currentScore"),
        actions: [
          TextButton(
              onPressed: () {
                //resetGame();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("End"))
        ],
      ),
    );
  }

  void resetGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    gameOver = false;
    currentScore = 0;

    createNewPiece();
    startGame();
  }

  // 碰撞检测
  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (col < 0 || row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }

      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }
    return false;
  }

  void checkLending() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random random = Random();
    Tetromino randomType =
        Tetromino.values[random.nextInt(Tetromino.values.length)];

    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);

        currentScore++;
      }
    }
  }

  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;

                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: currentPiece.color,
                      // child: index,
                    );
                  } else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(
                      color: tetrominoColor[tetrominoType],
                      // child: '',
                    );
                  } else {
                    return Pixel(
                      color: Colors.grey[900],
                      // child: index,
                    );
                  }
                }),
          ),
          Text(
            "Score: $currentScore",
            style: const TextStyle(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: moveLeft,
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back_ios)),
                IconButton(
                    onPressed: rotatePiece,
                    color: Colors.white,
                    icon: const Icon(Icons.rotate_right)),
                IconButton(
                    onPressed: moveRight,
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_forward_ios)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
