
import 'package:bird_sense/data/core/model/color.dart';
import 'package:bird_sense/presentation/bird_page/reacent.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

class BirdPage extends HookWidget{
   const BirdPage({
    super.key, 
    });

  @override
   Widget build(BuildContext context) {
  final screens = [
     const ReacentBirds(),
     const ReacentBirds(),
     const ReacentBirds(),
  ];
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 300,
            elevation: 0,
            backgroundColor: BSColors.backgroundColor ,
            bottom:  TabBar(
              labelColor: BSColors.secondaryColor,
              indicatorColor: BSColors.primaryColor,
              tabs: const [
                Tab(icon: Icon(Icons.recent_actors)),
                Tab(icon: Icon(Icons.history)),
                Tab(icon: Icon(Icons.menu_book)),
              ],
            ),
            title: Stack(
              children:[
              Image.asset('assets/birdSense(1).png', fit: BoxFit.fitHeight),
              ]
              )
          ),
          body: TabBarView(
            children: screens
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: BSColors.backgroundColor,
            child:  Icon(Icons.map, color: BSColors.primaryColor,),
            onPressed: () => const ReacentBirds()),
        ),
      );
  }

}