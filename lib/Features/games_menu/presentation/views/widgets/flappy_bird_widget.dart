import 'package:flutter/material.dart';

import '../../../../../Core/utiles/constance/AssetsManager.dart';

class FlappyBirdGameWidget extends StatelessWidget {
  const FlappyBirdGameWidget({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        AssetsManager.flappyBirdGame,
        fit: BoxFit.fill,
        height: size.width * 0.16,
        width: size.width * 0.18,
      ),
    );
  }
}
