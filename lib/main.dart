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
        body: Padding(
          padding: const EdgeInsets.all(100.0),
          child: GameWidget(
            game: AiGame(),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [Text("test")],
          ),
        ),
      ),
    ),
  );
}
