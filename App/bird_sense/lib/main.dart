import 'package:bird_sense/application/markers/bloc/markers_bloc.dart';
import 'package:bird_sense/application/reacentBirds/bloc/reacent_birds_bloc.dart';



import 'package:bird_sense/application/sortedBirds/bloc/sorted_birds_bloc.dart';
import 'package:bird_sense/application/sortedBirds/blocMigration/sorted_birds_bloc.dart';
import 'package:bird_sense/data/birds/birds_repository.dart';
import 'package:bird_sense/data/birds/sorted_birds_repository.dart';
import 'package:bird_sense/data/core/client.dart';
import 'package:bird_sense/presentation/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    Provider(
      create: (context) => Client(),
      child: Provider(
        create: (context) => ReacentBirdsRepository(
          client: context.read<Client>(),
        ),
        child: Provider(
          create: (context) => SortedBirdsRepository(
            client: context.read<Client>(),
          ),
          child: MyApp(),
        ),
      ),
    ),
  );
  // final birds = await ReacentBirdsRepository(client: Client(),).getBirds();
  // print(birds);
}

class MyApp extends HookWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;
    return MaterialApp(
      title: 'PBL3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ReacentBirdsBloc>(
            create: (context) => ReacentBirdsBloc(
                repository: context.read<ReacentBirdsRepository>())
              ..add(ReacentBirdsCount(after: (now - 2*24*60*60).toInt(), before: now.toInt())),
          ),
          BlocProvider<MarkersBloc>(
            create: (context) => MarkersBloc()
              ..add(
                MarkersCounter(),
              ),
          ),
          BlocProvider(create: (context) => SortedBirdsBloc(
            repository: context.read<SortedBirdsRepository>())..add(SortedBirdsCount(after: (now - 60*60).toInt(), before: now.toInt())
            )
            ),
            BlocProvider(create: (context) => SortedMigrationBirdsBloc(
            repository: context.read<SortedBirdsRepository>())..add(SortedMigrationBirdsCount(after: 0, before: -10)
            )
            ),
            
        ],
        child: const BottomBar(),
      ),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
    );
  }
}
