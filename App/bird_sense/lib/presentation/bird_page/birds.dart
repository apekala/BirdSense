
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
            toolbarHeight: 150,
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
            title: Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Bird',style: TextStyle(color: BSColors.primaryColor, fontSize: 25, fontStyle: FontStyle.italic),),
                Image.asset('assets/birdSense(2).png', height: 150,),
                Text('Sense', style: TextStyle(color: BSColors.primaryColor, fontSize: 25, fontStyle: FontStyle.italic),)
              ],
            ))
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