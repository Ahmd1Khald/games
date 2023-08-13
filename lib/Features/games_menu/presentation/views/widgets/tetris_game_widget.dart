import 'package:flutter/material.dart';

import '../../../../../Core/utiles/constance/AssetsManager.dart';

class TetrisGameWidget extends StatelessWidget {
  const TetrisGameWidget({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        AssetsManager.tetrisGame,
        fit: BoxFit.fill,
        height: size.width * 0.16,
        width: size.width * 0.18,
      ),
    );
  }
}
