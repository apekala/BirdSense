import 'package:bird_sense/data/core/client.dart';
import 'package:bird_sense/presentation/bottom_bar.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
  // final birds = await Client().getBirds('1702985548');
  // print(birds);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PBL3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
      ),
      home: const BottomBar(),
      
    );
  }
}
