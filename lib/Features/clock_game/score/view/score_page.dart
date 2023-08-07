import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../score.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreCubit, ScoreState>(
      builder: (context, state) {
        if (state is ScoreInitial) {
          return const CircularProgressIndicator();
        } else if (state is ScoreLoaded) {
          final scoreState = state.score;
          return Center(
            child: Container(
              alignment: Alignment.center,
              height: 600,
              width: 1024,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("High Score"),
                ),
                body: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "scorePageTitle",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      // -If there is no score record, it shows 'no data'.
                      scoreState.dateTime == 'noData'
                          ? "No Data"
                          : scoreState.dateTime!,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade900,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_sharp,
                          color: Colors.yellow[900],
                          size: 70.0,
                        ),
                        Text(
                          scoreState.score.toString(),
                          style: const TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              contentPadding: const EdgeInsets.all(10),
                              children: <Widget>[
                                DecoratedBox(
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Are you sure?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "Attention!\nScore will be reset!",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        context.read<ScoreCubit>().clearScore();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Clear",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text("Clear"),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}
