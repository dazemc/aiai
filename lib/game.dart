import 'package:aiai/main.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'entities/player.dart';

class AiGame extends FlameGame with KeyboardEvents {
  late TiledComponent mapComponent;
  late Player player;

  AiGame()
      : super(
          camera: CameraComponent(
            // viewfinder: Viewfinder(),
            viewport: FixedAspectRatioViewport(aspectRatio: 1.618),
          ),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    mapComponent = await TiledComponent.load('first.tmx', Vector2.all(32));
    player = Player();
 

    world.add(mapComponent);
    world.add(player);

    final ref = Ref();
    world.add(ref);

    camera.viewfinder.zoom = 1.5;
    camera.follow(player);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;
    final isKeyUp = event is KeyUpEvent;
    final isKeyHeld = event is KeyRepeatEvent;
    final isShift = (keysPressed.contains(LogicalKeyboardKey.shiftLeft) ||
        keysPressed.contains(LogicalKeyboardKey.shiftRight));

    if (isShift && isKeyDown) {
      player.toggleSprint();
    }

    if (isKeyDown || isKeyHeld || isKeyUp) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.keyW:
          if (isKeyDown) {
            player.startAnimation(id: 'walkBack');
          } else if (isKeyHeld) {
            player.y -= player.movementSpeed;
          } else if (isKeyUp) {
            player.startAnimation(id: 'idleBack');
          }
        case LogicalKeyboardKey.keyD:
          if (isKeyDown) {
            if (player.isFlippedHorizontally) {
              player.flipHorizontallyAroundCenter();
            }
            player.startAnimation(id: 'walkEast');
          } else if (isKeyHeld) {
            player.x += player.movementSpeed;
          } else if (isKeyUp) {
            player.startAnimation(id: 'idleEast');
          }
        case LogicalKeyboardKey.keyS:
          if (isKeyDown) {
            player.startAnimation(id: 'walkForward');
          } else if (isKeyHeld) {
            player.y += player.movementSpeed;
          } else if (isKeyUp) {
            player.startAnimation(id: 'idle');
          }
        case LogicalKeyboardKey.keyA:
          if (isKeyDown) {
            if (!player.isFlippedHorizontally) {
              player.flipHorizontallyAroundCenter();
            }
            player.startAnimation(id: 'walkEast');
          } else if (isKeyHeld) {
            player.x -= player.movementSpeed;
          } else if (isKeyUp) {
            player.startAnimation(id: 'idleEast');
          }
        default:
          player.startAnimation();
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
