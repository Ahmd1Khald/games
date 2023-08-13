import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games/Features/games_menu/domain/usecase/minus_coins_usecase.dart';
import 'package:games/Features/games_menu/presentation/views/widgets/clock_game_widget.dart';
import 'package:games/Features/games_menu/presentation/views/widgets/container_decoration.dart';
import 'package:games/Features/games_menu/presentation/views/widgets/custom_appbar.dart';
import 'package:games/Features/games_menu/presentation/views/widgets/darkness_game_widget.dart';
import 'package:games/Features/games_menu/presentation/views/widgets/flappy_bird_widget.dart';
import 'package:games/Features/games_menu/presentation/views/widgets/tetris_game_widget.dart';

import '../../../../Core/services/ServiceLocator.dart';
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
    Size size = MediaQuery.of(context).size;
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
            //myToast(state: state.data.message, toastState: ToastState.success);

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
            appBar: buildAppBar(cubit),
            body: Container(
              decoration: buildBoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TetrisGameWidget(
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
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      ClockGameWidget(onTap: () {
                        cubit
                            .minusCoins(count: 10)
                            .then((value) => cubit.fetchCoins())
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                )));
                      }),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlappyBirdGameWidget(
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
                      ),
                      SizedBox(
                        width: size.width * 0.05,
                      ),
                      DarknessGameWidget(onTap: () {
                        cubit
                            .minusCoins(count: 10)
                            .then((value) => cubit.fetchCoins())
                            .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Menu(),
                                )));
                      }),
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
