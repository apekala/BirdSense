import 'dart:ffi';


import 'package:bird_sense/application/sortedBirds/bloc/sorted_birds_bloc.dart';
import 'package:bird_sense/application/sortedBirds/blocMigration/sorted_birds_bloc.dart';
import 'package:bird_sense/application/sortedBirds/sortedBirdsEntity.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:quiver/time.dart';

class MigrationPage extends StatefulWidget{
  final String devEUI;
   const MigrationPage( {
    super.key, 
    required this.devEUI
    });
@override
  State<MigrationPage> createState() => _MigrationPageState();
}

class _MigrationPageState extends State<MigrationPage> with AutomaticKeepAliveClientMixin {
  DateTime? _selected;
  double? after;
  double? before;
  int? monthdays;
  
  final List<SalesDataMigration> chartData = [];
  
  
  

  List<SortedBirdsEntity>? getSortedBirds({required SortedMigrationBirdsState from}) {
    final state = from;

    if (state is SortedMigrationBirdsLoading) {
      
      return state.lastBirds;
    }

    if (state is SortedMigrationBirdsLoaded) {
      
      return state.sortedBirds;
    }
    
    return null;
  }

 @override
  Widget build(BuildContext context) {
    final devEUI = widget.devEUI;
    super.build(context);
    
    
   
    return BlocBuilder<SortedMigrationBirdsBloc,SortedMigrationBirdsState>(
      builder:(context, state) {
        final birds = getSortedBirds(from: state);
            
        
        if(state is SortedMigrationBirdsLoaded) {
             for(var i = birds!.length-1; i>=0; i--) {
              chartData.add(SalesDataMigration(birds[i].species, birds[i].duration,birds[i].count));
              
             }
             
           
             return Stack(
               children: [ 

                     
           chartData.isNotEmpty ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: chartData.length.toDouble()*120 + 50,
                width: 600,
                child: SfCartesianChart(
                  title: ChartTitle(
                    text: '${DateFormat('LLLL').format(_selected!)} of ${_selected?.year}'
                    ),
                   primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(minimum: 0, maximum: chartData.isNotEmpty ? birds[0].duration.toDouble() +10:20, interval: 10,
                  isVisible: false),
                  // legend: Legend(height: 'aaaa'),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  
                  
                  series: <CartesianSeries<SalesDataMigration, String>>[
                    BarSeries<SalesDataMigration, String>(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                      dataSource: chartData, 
                      name: 'Duration',
                      // groupName: 'Duration',
                      
                      
                      color: Colors.blue,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                         labelAlignment: ChartDataLabelAlignment.auto
                      ),
                      xValueMapper: (SalesDataMigration data, _) => data.x, 
                      yValueMapper: (SalesDataMigration data, _) => data.y,
                      dataLabelMapper: (SalesDataMigration data, _) => 'Time: ${data.y.toString()}s',
                      ),
                      BarSeries<SalesDataMigration, String>(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                      dataSource: chartData, 
                      //  groupName: 'Count',
                      name: 'Count',
                      color: Colors.green,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                        // labelAlignment: ChartDataLabelAlignment.outer
                        ),
                      xValueMapper: (SalesDataMigration data, _) => data.x, 
                      yValueMapper: (SalesDataMigration data, _) => data.y2,
                      dataLabelMapper: (SalesDataMigration data, _) => 'Count: ${data.y2.toString()}'
                      ),
                  ],
                
                ),
              ),
            ):
            const Center(child: Text('No birds'),),




            Align(
                  alignment: const Alignment(0, 0.9),
                      child: TextButton(
                                    child:  Container(
                                      alignment: Alignment.center,
                                      width: 150,
                                      height: 60,
                                      decoration:  BoxDecoration(color: BSColors.buttonColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                                      child: Text('Choose month of migration',            
                           
                                      style: TextStyle(color: BSColors.textColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold

                                      ),
                                      ),
                                    
                                    ),
                                    onPressed: () { _onPressed(devEUI: devEUI);
                                    

                                    
                                   
                                    }
                      ),
                  
                  
                ),
            ]
    );
  }
  else {
          return const Center(child: CircularProgressIndicator());
      }
      }
    );
  }

  Future<void> _onPressed(
    {required final String devEUI,
    //required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      locale: localeObj,
      
    );

    if (selected != null) {
      setState(() {
        _selected = selected;
        monthdays = daysInMonth(_selected?.year ?? 0, _selected?.month ?? 0);
        after = _selected!.toUtc().millisecondsSinceEpoch / 1000;
        before = (after! + (monthdays! *24 * 60 * 60));
        chartData.clear();
        context.read<SortedMigrationBirdsBloc>().add(SortedMigrationBirdsCount(after: after!.toInt(), before: before!.toInt(),devEUI: devEUI));

      });
    }
  }
  
  @override
  
  bool get wantKeepAlive=> true;
  
}
class SalesDataMigration {
  SalesDataMigration(this.x, this.y, this.y2);
    final String x;
    final int y;
    final int y2;
}