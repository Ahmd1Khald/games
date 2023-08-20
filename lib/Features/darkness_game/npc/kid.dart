import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../enemies/boss.dart';
import '../util/custom_sprite_animation_widget.dart';
import '../util/dialogs.dart';
import '../util/functions.dart';
import '../util/npc_sprite_sheet.dart';
import '../util/player_sprite_sheet.dart';
import '../util/sounds.dart';

class Kid extends GameDecoration {
  bool conversationWithHero = false;

  final IntervalTick _timer = IntervalTick(1000);
  Kid(
    Vector2 position,
  ) : super.withAnimation(
          animation: NpcSpriteSheet.kidIdleLeft(),
          position: position,
          size: Vector2(valueByTileSize(8), valueByTileSize(11)),
        );

  @override
  void update(double dt) {
    super.update(dt);
    if (!conversationWithHero && _timer.update(dt)) {
      try {
        gameRef.enemies().firstWhere((e) => e is Boss);
      } catch (e) {
        conversationWithHero = true;
        gameRef.camera.moveToTargetAnimated(
          this,
          finish: () {
            _startConversation();
          },
        );
      }
    }
  }

  void _startConversation() {
    Sounds.interaction();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            const TextSpan(
              text:
                  "Thank the gods !!! \nYou managed to defeat this horrible creature! Thank you very much! \nI don't even know how to thank you!",
            )
          ],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.kidIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [
            const TextSpan(
              text:
                  "It was an honor to be able to help you! And don't worry about rewarding me, your father promised me a fortune to rescue you! :-)",
            )
          ],
          person: CustomSpriteAnimationWidget(
            animation: PlayerSpriteSheet.idleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
      ],
      onFinish: () {
        Sounds.interaction();
        gameRef.camera.moveToPlayerAnimated(finish: () {
          Dialogs.showCongratulations(gameRef.context);
        });
      },
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }
}
