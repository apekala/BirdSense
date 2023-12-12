import 'package:bird_sense/presentation/articles.dart';
import 'package:bird_sense/presentation/bird_page/birds.dart';
import 'package:bird_sense/presentation/map.dart';
import 'package:bird_sense/presentation/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:bird_sense/data/core/model/color.dart';

class BottomBar extends HookWidget{
  const BottomBar({Key? key,}) : super(key : key);

  @override
   Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    void onItemTapped(int index) {
      selectedIndex.value = index;
  }
  final screens = [
     const BirdPage(),
     const MapPage(),
    const WeatherPage(),
    const ArticlesPage(),
  ];
    return Scaffold(
      //body: screens[selectedIndex.value],
      body: IndexedStack(
        index:selectedIndex.value,
        children: screens,
       ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        iconSize: 20,
        type: BottomNavigationBarType.fixed,
        //showSelectedLabels: true,
        //showUnselectedLabels: true,
        backgroundColor: BSColors.backgroundColor,
        selectedFontSize: 20,
        selectedIconTheme: IconThemeData(color: BSColors.primaryColor, size: 30),
        selectedItemColor: BSColors.primaryColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: BSColors.secondaryColor,
    items: <BottomNavigationBarItem>[

      BottomNavigationBarItem(
        icon: const Icon(Icons.forest),
        label: "Birds",
        backgroundColor: BSColors.backgroundColor,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.map_outlined),
        label: "Map",
        backgroundColor: BSColors.backgroundColor,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.sunny),
        label: 'Weather',
        backgroundColor: BSColors.backgroundColor, 
      ),
       BottomNavigationBarItem(
        icon: const Icon(Icons.article),
        label: 'Articles',
        backgroundColor: BSColors.backgroundColor,
      ),
    ],
    currentIndex: selectedIndex.value,
    onTap: onItemTapped,
  ),
  
    );
  }

}