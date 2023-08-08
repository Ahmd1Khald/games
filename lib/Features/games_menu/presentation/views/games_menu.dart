import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/Features/games_menu/domain/usecase/minus_coins_usecase.dart';

import '../../../../Core/services/ServiceLocator.dart';
import '../../../../Core/utiles/widgets/flutter_toast.dart';
import '../../../clock_game/home_page.dart';
import '../../../darkness_game/menu.dart';
import '../../../flappy_game/flappy_bird_game.dart';
import '../../../flappy_game/game_over_page.dart';
import '../../../tetris_game/board.dart';
import '../../data/repository/games_repository.dart';
import '../../domain/usecase/get_coins_usecase.dart';
import '../controller/gemes_menu_cubit/gemes_menu_cubit.dart';

class GamesMenu extends StatelessWidget {
  GamesMenu({Key? key}) : super(key: key);

  final game = FlappyBirdGame();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GamesMenuCubit(
        GetCoinsUseCase(getIt.get<GamesRepository>()),
        MinusCoinsUseCase(getIt.get<GamesRepository>()),
      )..fetchCoins(),
      child: BlocConsumer<GamesMenuCubit, GamesMenuState>(
        listener: (context, state) {
          if (state is GamesMenuSuccessGetCoinsState) {
            print(state.data);
            //Navigator.pop(context);
          }
          if (state is GamesMenuSuccessMinusCoinsState) {
            print(state.data);
            myToast(state: state.data.message, toastState: ToastState.success);

            //Navigator.pop(context);
          }
          if (state is GamesMenuLoadingGetCoinsState) {
            //loadingPage(context: context);
          }
          if (state is GamesMenuLoadingMinusCoinsState) {
            //loadingPage(context: context);
          }
        },
        builder: (context, state) {
          GamesMenuCubit cubit = GamesMenuCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("${cubit.getCoinsData?.coins ?? ""} Coins"),
            ),
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
                          cubit
                              .minusCoins(count: 10)
                              .then((value) => cubit.fetchCoins())
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const GameBoard(),
                                  )));
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: const Center(
                              child: Text('Tetris Game\n 10 coins')),
                        ),
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          cubit
                              .minusCoins(count: 10)
                              .then((value) => cubit.fetchCoins())
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  )));
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: const Center(
                              child: Text('Clock Game\n 10 coins')),
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
                          cubit
                              .minusCoins(count: 10)
                              .then((value) => cubit.fetchCoins())
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GameWidget(
                                      game: game,
                                      overlayBuilderMap: {
                                        'gameOver': (context, _) =>
                                            GameOverPage(game: game),
                                      },
                                    ),
                                  )));
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: const Center(
                              child: Text('Flappy Game\n 10 coins')),
                        ),
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          cubit
                              .minusCoins(count: 10)
                              .then((value) => cubit.fetchCoins())
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Menu(),
                                  )));
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: const Center(
                              child: Text('Darknees Game\n 10 coins')),
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
