import 'package:bird_sense/application/articles/bloc/articles_bloc.dart';
import 'package:bird_sense/application/device/bloc/device_bloc.dart';
import 'package:bird_sense/application/markers/bloc/markers_bloc.dart';
import 'package:bird_sense/application/reacentBirds/bloc/reacent_birds_bloc.dart';
import 'package:bird_sense/application/reacentBirds/controller/bloc/controller_bloc.dart';

import 'package:bird_sense/application/sortedBirds/bloc/sorted_birds_bloc.dart';
import 'package:bird_sense/application/sortedBirds/blocMigration/sorted_birds_bloc.dart';
import 'package:bird_sense/data/birds/atricles_repository.dart';
import 'package:bird_sense/data/birds/birds_repository.dart';
import 'package:bird_sense/data/birds/device_repository.dart';
import 'package:bird_sense/data/birds/sorted_birds_repository.dart';
import 'package:bird_sense/data/core/client.dart';
import 'package:bird_sense/data/core/wather_client.dart';
import 'package:bird_sense/data/current/current_weather_repository.dart';
import 'package:bird_sense/data/forecast/forecast_weather_repository.dart';
import 'package:bird_sense/data/forecast/hourly_weather_repository.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:bird_sense/presentation/bottom_bar.dart';
import 'package:bird_sense/presentation/map_initial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:latlong2/latlong.dart';

import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

void main() async {
  // final weather = await Client().getArticles();
  // print(weather);
  runApp(
    MultiProvider(providers: [
    Provider(
      create: (context) => Client()),
      Provider(
              create: (context) => WeatherClient()),
           Provider(
        create: (context) => ReacentBirdsRepository(
          client: context.read<Client>(),
        )),
         Provider(
          create: (context) => SortedBirdsRepository(
            client: context.read<Client>(),
          )),
           Provider(
            create: (context) => DeviceRepository(
              client: context.read<Client>(),
            )),
            
               Provider(
                create: (context) => CurrentWeatherRepository(
          client: context.read<WeatherClient>(),
        )),
                 Provider(
                  create: (context) => ForecastWeatherRepository(
            client: context.read<WeatherClient>(),
          )),
                  Provider(
                    create: (context) => HourlyWeatherRepository(
              client: context.read<WeatherClient>()),
                    child: const MyApp(),
                  ),
                  Provider(create: (context) => ArticlesRepository(client: context.read<Client>()))
    ],
    child: const MyApp(),
                ),
            
  );
  final birds = await ArticlesRepository(client: Client(),).getArticles();
  print('articles: $birds');

  // final birds = await CurrentWeatherRepository(client: WeatherClient(),).getWeather('52.21885, 21.01077');
  // print(birds);
  
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch / 1000 +
        DateTime.now().timeZoneOffset.inSeconds;
    return MaterialApp(
      title: 'PBL3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: MultiBlocProvider(
          providers: [
            BlocProvider<DeviceBloc>(
                create: (context) =>
                    DeviceBloc(repository: context.read<DeviceRepository>())
                      ..add(DeviceCount())),
            BlocProvider(create: (context) => MarkersBloc()..add(
                // MarkersChange(marker: const LatLng(0, 0))
                MarkersCounter(
                    // marker: const LatLng(0, 0)
                    ))),
            BlocProvider(create: (context) => ArticlesBloc(repository: context.read<ArticlesRepository>())
            ..add(ArticlesCount()
            ))
          ],
          child: BlocBuilder<MarkersBloc, MarkersState>(
            builder: (context, state) {
              if (state is MarkersLoaded) {
                if (state.markers == const LatLng(1, 0)) {
                  return const MapInitialPage();
                } else {
                  return BottomBar(
                    devEUI: state.devEui, latlong: LatLng(20.21885, 21.01077),//state.markers,
                  );
                }
              } else {
                return Scaffold(
                  backgroundColor: BSColors.backgroundColor,
                );
              }
            },
          )),
      // ),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}
