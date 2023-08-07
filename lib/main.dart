import 'package:flutter/material.dart';

import 'Features/games_menu/presentation/views/games_menu.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Games',
      debugShowCheckedModeBanner: false,
      home: GamesMenu(),
    );
  }
}
