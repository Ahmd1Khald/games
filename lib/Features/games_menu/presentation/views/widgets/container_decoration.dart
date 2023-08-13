import 'package:flutter/cupertino.dart';

import '../../../../../Core/utiles/constance/AssetsManager.dart';

BoxDecoration buildBoxDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage(AssetsManager.backGroundGamesMenu),
    ),
  );
}
