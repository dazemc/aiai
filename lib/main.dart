import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.dark(surface: Colors.black),
      ),
      home: Scaffold(
        body: GameWidget(
          autofocus: true,
          game: AiGame(),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              ElevatedButton(   // Maybe change this to a grid or array that is just always there
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xff121212))),
                child: Text(
                  'Inventory',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                onPressed: () {
                  print('You touched me... ew');  // how can I access game state up this far in the tree? 
                },
              )
            ],
          ),
        ),
      ),
    ),
  );
}

class Ref extends Component with HasGameRef<AiGame> {
  Ref({super.key});
  late Vector2 playerPos;

  @override
  Future<void> onLoad() async {
  playerPos = game.player.position;
  }
}