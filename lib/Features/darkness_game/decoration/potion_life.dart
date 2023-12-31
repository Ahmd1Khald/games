import 'dart:async' as async;

import 'package:bonfire/bonfire.dart';

import '../../../main.dart';

class PotionLife extends GameDecoration with Sensor {
  final Vector2 initPosition;
  final double life;
  double _lifeDistributed = 0;

  PotionLife(this.initPosition, this.life)
      : super.withSprite(
          sprite: Sprite.load('items/potion_red.png'),
          position: initPosition,
          size: Vector2(tileSize, tileSize),
        );

  void _starTimeAddLife() {
    async.Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        if (_lifeDistributed >= life) {
          timer.cancel();
        } else {
          _lifeDistributed += 2;
          gameRef.player?.addLife(5);
        }
      },
    );
  }

  @override
  void onContact(GameComponent collision) {
    if (collision is Player) {
      _starTimeAddLife();
      removeFromParent();
    }
  }
}
