import '../game.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef<AiGame> {
  double animationSpeed = 0.4;
  double movementSpeed = 6;
  bool isSprinting = true;

  Player()
      : super(
          size: Vector2.all(96),
          anchor: Anchor.center,
        );
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await startAnimation(id: 'idle');

    position = Vector2(200, 200);
  }

  void toggleSprint() {
    if (isSprinting) {
      animationSpeed = 0.4;
      movementSpeed = 3;
      isSprinting = false;
    } else {
      animationSpeed = 0.2;
      movementSpeed = 6;
      isSprinting = true;
    }
  }

  Future<void> startAnimation({String? id}) async {
    final playerSheet = await game.images
        // .load('Player/Prototype_Character/Prototype_Character.png');
        .load('Player/main/player.png');

    final spriteSheet = SpriteSheet(
      image: playerSheet,
      srcSize: Vector2.all(48),
    );

    final idle = spriteSheet.createAnimation(row: 0, stepTime: .4, loop: true);
    final idleEast =
        spriteSheet.createAnimation(row: 1, stepTime: .4, loop: true);
    final idleBack =
        spriteSheet.createAnimation(row: 2, stepTime: .4, loop: true);
    final walkForward = spriteSheet.createAnimation(
        row: 3, stepTime: animationSpeed, loop: true);
    final walkEast = spriteSheet.createAnimation(
        row: 4, stepTime: animationSpeed, loop: true);
    final walkBack = spriteSheet.createAnimation(
        row: 5, stepTime: animationSpeed, loop: true);

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
