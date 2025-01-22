import '../game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef<AiGame> {
  double movementSpeed = 0.4;
  bool isSprinting = false;

  Player(
  )
      : super(
          size: Vector2.all(300),
          anchor: Anchor.center,
        );
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await startAnimation(id: 'idle');

    position = gameRef.size / 2;
  }

  void toggleSprint() {
    if (isSprinting){
      movementSpeed = 0.4;
      isSprinting = false;
    } else {
      movementSpeed = 0.2;
      isSprinting = true;
    }
  }

  Future<void> startAnimation({String? id}) async {
    final playerSheet = await game.images
        .load('Player/Prototype_Character/Prototype_Character.png');

    final spriteSheet = SpriteSheet(
      image: playerSheet,
      srcSize: Vector2.all(32),
    );

    final idle = spriteSheet.createAnimation(
        row: 0, from: 0, to: 2, stepTime: .4, loop: true);
    final idleEast = spriteSheet.createAnimation(
        row: 1, from: 0, to: 2, stepTime: .4, loop: true);
    final idleBack = spriteSheet.createAnimation(
        row: 2, from: 0, to: 2, stepTime: .4, loop: true);
    final walkForward =
        spriteSheet.createAnimation(row: 3, stepTime: movementSpeed, loop: true);
    final walkEast =
        spriteSheet.createAnimation(row: 4, stepTime: movementSpeed, loop: true);
    final walkBack =
        spriteSheet.createAnimation(row: 5, stepTime: movementSpeed, loop: true);

    switch (id) {
      case 'idle':
        animation = idle;
      case 'idleEast':
        animation = idleEast;
      case 'idleBack':
        animation = idleBack;
      case 'walkForward':
        animation = walkForward;
      case 'walkEast':
        animation = walkEast;
      case 'walkBack':
        animation = walkBack;
      default:
        animation = idle;
    }
  }
}
