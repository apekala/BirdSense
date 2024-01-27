import 'package:bird_sense/application/current_weather/current_weather_bloc.dart';
import 'package:bird_sense/application/forecast_weather/bloc/forecast_bloc.dart';
import 'package:bird_sense/application/markers/bloc/markers_bloc.dart';
import 'package:bird_sense/application/reacentBirds/bloc/reacent_birds_bloc.dart';
import 'package:bird_sense/application/reacentBirds/controller/bloc/controller_bloc.dart';
import 'package:bird_sense/application/sortedBirds/bloc/sorted_birds_bloc.dart';
import 'package:bird_sense/application/sortedBirds/blocMigration/sorted_birds_bloc.dart';
import 'package:bird_sense/data/birds/birds_repository.dart';
import 'package:bird_sense/data/birds/sorted_birds_repository.dart';
import 'package:bird_sense/data/current/current_weather_repository.dart';
import 'package:bird_sense/data/forecast/forecast_weather_repository.dart';
import 'package:bird_sense/data/forecast/hourly_weather_repository.dart';
import 'package:bird_sense/presentation/articles.dart';
import 'package:bird_sense/presentation/bird_page/birds.dart';
import 'package:bird_sense/presentation/map.dart';
import 'package:bird_sense/presentation/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:latlong2/latlong.dart';

class BottomBar extends HookWidget{
  final String devEUI;
  final LatLng latlong;
  const BottomBar({required this.devEUI, required this.latlong, Key? key,}) : super(key : key);

  @override
   Widget build(BuildContext context) {
    print(devEUI);
    
    final selectedIndex = useState(0);
    final now = DateTime.now().toUtc().millisecondsSinceEpoch / 1000; //+ DateTime.now().timeZoneOffset.inSeconds;
    void onItemTapped(int index) {
      selectedIndex.value = index;
  }
  final screens = [
     const BirdPage(),
      const MapPage(),
      WeatherPage(latlong: latlong,),
    // const ArticlesPage(),
    const ArticlesPage(),
  ];
    return MultiBlocProvider(
        providers: [
          BlocProvider<ReacentBirdsBloc>(
            create: (context) => ReacentBirdsBloc(
                repository: context.read<ReacentBirdsRepository>())
              ..add(ReacentBirdsCount(after: (now - 3*24*60*60).toInt(), before: now.toInt(), devEUI: devEUI)),
          ),
          
          BlocProvider(create: (context) => SortedBirdsBloc(
            repository: context.read<SortedBirdsRepository>())..add(SortedBirdsCount(after: (now - 60*60).toInt(), before: now.toInt(), devEUI: devEUI)
            )
            ),
            BlocProvider(create: (context) => SortedMigrationBirdsBloc(
            repository: context.read<SortedBirdsRepository>())..add(SortedMigrationBirdsCount(after: 0, before: -10, devEUI: devEUI)
            )
            ),
            BlocProvider(create: ((context) => ControllerBloc(

            )..add(ControllerInitialEvent())
            )),
            BlocProvider(
                    create: (context) => CurrentWeatherBloc(
                      repository: context.read<CurrentWeatherRepository>(),
                    )..add(
                        QueryForLocationEvent(location: '${latlong.latitude},${latlong.longitude}'),
                      ),
                  ),
                  BlocProvider(
                      create: (contextForecast) => ForecastBloc(
                          repository:
                              contextForecast.read<ForecastWeatherRepository>(),
                          repositoryHourly:
                              contextForecast.read<HourlyWeatherRepository>())
                        ..add(
                          ForecastEvent(location: '${latlong.latitude},${latlong.longitude}'),
                        ),
                  ),
            
            
        ],
        child:
      
    Scaffold(
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
  
    )
    );
  }

}