import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart' hide Animation;

void main() {
  runApp(GameWidget(game: AudioGame()));
}

/// This example game showcases three possible use cases:
///
/// 1. Use the static FlameAudio class to easily fire a sfx using the default
/// configs for the button tap.
/// 2. Uses a custom AudioPool for extremely efficient audio loading and pooling
/// for tapping elsewhere.
/// 3. Uses the Bgm utility for background music.
class AudioGame extends FlameGame with TapDetector {
  //static Paint black = BasicPalette.black.paint();
  //static Paint gray = const PaletteEntry(Color(0xFFCCCCCC)).paint();
  //static TextPaint text = TextPaint(
  //style: TextStyle(color: BasicPalette.white.color),
  //);

  late AudioPool pool;

  @override
  Future<void> onLoad() async {
    pool = await FlameAudio.createPool(
      'video-game-game-over-3_NWM.mp3',
      minPlayers: 3,
      maxPlayers: 4,
    );
    //startBgmMusic();
  }

  void fireOne() {
    FlameAudio.play('video-game-beeps-4_NWM.mp3');
  }

  void fireTwo() {
    FlameAudio.play('video-game-game-over-3_NWM.mp3');
  }

  @override
  void onTapDown(TapDownInfo info) {
    fireTwo();
    fireOne();
  }
}
