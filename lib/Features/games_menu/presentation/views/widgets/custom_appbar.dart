import 'package:flutter/material.dart';

import '../../controller/gemes_menu_cubit/gemes_menu_cubit.dart';

AppBar buildAppBar(GamesMenuCubit cubit) {
  return AppBar(
    backgroundColor: Colors.deepPurpleAccent,
    title: Text("${cubit.getCoinsData?.coins ?? ""} Coins"),
  );
}
