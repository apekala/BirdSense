
import 'package:bird_sense/application/sortedBirds/bloc/sorted_birds_bloc.dart';
import 'package:bird_sense/application/sortedBirds/sortedBirdsEntity.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter/widgets.dart';




class HistoryPage extends HookWidget {
  final String devEUI;
  const HistoryPage({
    super.key, 
    required this.devEUI
    });

     List<SortedBirdsEntity>? getSortedBirds({required SortedBirdsState from}) {
    final state = from;

    if (state is SortedBirdsLoading) {
      
      return state.lastBirds;
    }

    if (state is SortedBirdsLoaded) {
      
      return state.sortedBirds;
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final alive = useAutomaticKeepAlive(wantKeepAlive: true);
    final List<SalesData> chartData = [];
    var indexTapped = 1;

    
    
    return BlocBuilder<SortedBirdsBloc,SortedBirdsState>(
      builder:(context, state) {
        final birds = getSortedBirds(from: state);
        
        if(state is SortedBirdsLoaded) {
             for(var i = birds!.length-1; i>=0; i--) {
              chartData.add(SalesData(birds[i].species, birds[i].duration,birds[i].count));
              
             }
             final now = DateTime.now().toUtc().millisecondsSinceEpoch / 1000 + DateTime.now().timeZoneOffset.inSeconds;
             const hour = 60*60;
             print(chartData.length.toDouble());
             
             
             

          
          return Stack(
            children: [
              
              chartData.isNotEmpty ? 
              // SafeArea(
                // child: 
                // Builder(
                //   builder: (controllerContext) {
                //     return 
                    SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: 
                    // [
                      SizedBox(
                      height: chartData.length.toDouble()*120 + 50,
                      width: 600,
                      child: SfCartesianChart(
                        title: ChartTitle(
                          text: 'Bar of total count and time of recorded birds'
                          ),
                         primaryXAxis: CategoryAxis( 
                          labelRotation: 0,
                         labelPlacement: LabelPlacement.betweenTicks,
                         labelPosition: ChartDataLabelPosition.outside,
                         labelAlignment: LabelAlignment.center,
                         labelsExtent: 120,
                         
                         ),
                        primaryYAxis: NumericAxis(minimum: 0, maximum: chartData.isNotEmpty ? birds[0].duration.toDouble() + birds[0].duration.toDouble()/10:20, interval: 10,
                        isVisible: false),
                        
                        tooltipBehavior: TooltipBehavior(enable: true),
                        
                        
                        series: <CartesianSeries<SalesData, String>>[
                          BarSeries<SalesData, String>(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                            dataSource: chartData, 
                            name: 'Duration',
                            
                            
                            
                            color: Colors.blue,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              labelPosition: ChartDataLabelPosition.outside,
                               labelAlignment: ChartDataLabelAlignment.auto
                            ),
                            xValueMapper: (SalesData data, _) => data.x, 
                            yValueMapper: (SalesData data, _) => data.y,
                            dataLabelMapper: (SalesData data, _) => 'Time: ${data.y.toString()}s',
                            ),
                            BarSeries<SalesData, String>(
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
                            xValueMapper: (SalesData data, _) => data.x, 
                            
                            yValueMapper: (SalesData data, _) => data.y2,
                            dataLabelMapper: (SalesData data, _) => 'Count: ${data.y2.toString()}'
                            ),
                        ],
                      
                      ),
                    ),
                    // ]
                                )
              //     }
              //   ),
              // )
              :const Center(child: Text('No birds'),),


             Align(
              alignment: const Alignment(0, 0.9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //1h
                   GestureDetector(
                    onTap: () {
                      chartData.clear();
                      indexTapped = 1;
                    context.read<SortedBirdsBloc>().add(SortedBirdsCount(after: (now - hour).toInt(), before: now.toInt(),devEUI: devEUI));
                   }, child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                  borderRadius:const BorderRadius.only(
                  bottomLeft:Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                boxShadow: [
                          BoxShadow(
                                    color: BSColors.secondaryColor,
                                    
                                    blurRadius: 5,
                                    offset: const Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ],
                color: indexTapped == 1 ? BSColors.buttonColor : BSColors.backgroundColor,
                 ),
                 child: Center(child: Text("1h",
                 style: TextStyle(color: BSColors.textColor),)),
              ),
                    ),

                    //4h
                    GestureDetector(
                    onTap: () {
                      chartData.clear();
                      indexTapped = 2;
                    context.read<SortedBirdsBloc>().add(SortedBirdsCount(after: (now - 4*hour).toInt(), before: now.toInt(),devEUI: devEUI));
                   }, child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                   border: const Border(
                    
                    left: BorderSide(color: Colors.black,
                    width: 2
                    ),
                  ),
                boxShadow: [
                          BoxShadow(
                                    color: BSColors.secondaryColor,
                                    // spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ],
                color: indexTapped == 2 ? BSColors.buttonColor : BSColors.backgroundColor,
                 ),
                 child: Center(child: Text("4h",
                 style: TextStyle(color: BSColors.textColor),)),
              ),
                    ),


                     //8h
                     GestureDetector(

                    onTap: () {
                      chartData.clear();
                      indexTapped = 3;
                    context.read<SortedBirdsBloc>().add(SortedBirdsCount(after: (now - 8*hour).toInt(), before: now.toInt(),devEUI: devEUI));
                   }, child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                   border: const Border(
                    
                    left: BorderSide(color: Colors.black,
                    width: 2
                    ),
                  ),
                boxShadow: [
                          BoxShadow(
                                    color: BSColors.secondaryColor,
                                    
                                    blurRadius: 5,
                                    offset: const Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ],
                color: indexTapped == 3 ? BSColors.buttonColor : BSColors.backgroundColor,
                 ),
                 child: Center(child: Text("8h",
                 style: TextStyle(color: BSColors.textColor),)),
              ),
                    ),


                     //24h
                     GestureDetector(
                    onTap: () {
                      chartData.clear();
                      indexTapped = 4;
                    context.read<SortedBirdsBloc>().add(SortedBirdsCount(after: (now - 24*hour).toInt(), before: now.toInt(),devEUI: devEUI));
                   }, child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                   border: const Border(
                    
                    left: BorderSide(color: Colors.black,
                    width: 2
                    ),
                  ),
                boxShadow: [
                          BoxShadow(
                                    color: BSColors.secondaryColor,
                                    // spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ],
                color: indexTapped == 4 ? BSColors.buttonColor : BSColors.backgroundColor,
                 ),
                 child: Center(child: Text("24h",
                 style: TextStyle(color: BSColors.textColor),)),
              ),
                    ),
                
                
                     //48h
                     GestureDetector(
                    onTap: () {
                      chartData.clear();
                      indexTapped = 5;
                    context.read<SortedBirdsBloc>().add(SortedBirdsCount(after: (now - 48*hour).toInt(), before: now.toInt(),devEUI: devEUI));
                   }, child: Container(
                    height: 30,
                    width: 60,
                    decoration:  BoxDecoration(
                   borderRadius:const BorderRadius.only(
                  bottomRight:Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                border: const Border(
                    
                    left: BorderSide(color: Colors.black,
                    width: 2
                    ),
                  ),
                 
                boxShadow: [
                          BoxShadow(
                                    color: BSColors.secondaryColor,
                                    // spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ],
                color: indexTapped == 5 ? BSColors.buttonColor : BSColors.backgroundColor,
                 ),
                 child: Center(child: Text("48h",
                 style: TextStyle(color: BSColors.textColor),)),
              ),
                    ),
                ],
                ),
            )
            ]
          );

        }
        else {
          return const Center(child: CircularProgressIndicator());
        }

        
      },
      );
  }
}
class SalesData {
  SalesData(this.x, this.y, this.y2);
    final String x;
    final int y;
    final int y2;
}


void useAutomaticKeepAlive({
  required bool wantKeepAlive,
}) =>
    use(_AutomaticKeepAliveHook(
      wantKeepAlive: wantKeepAlive ?? true,
    ));

class _AutomaticKeepAliveHook extends Hook<void> {
  final bool wantKeepAlive;

  _AutomaticKeepAliveHook({required this.wantKeepAlive});

  @override
  HookState<void, _AutomaticKeepAliveHook> createState() => _AutomaticKeepAliveHookState();
}

class _AutomaticKeepAliveHookState extends HookState<void, _AutomaticKeepAliveHook> {
    KeepAliveHandle? _keepAliveHandle;

  void _ensureKeepAlive() {
    assert(_keepAliveHandle == null);
    _keepAliveHandle = KeepAliveHandle();
    KeepAliveNotification(_keepAliveHandle!).dispatch(context);
  }

  void _releaseKeepAlive() {
    _keepAliveHandle!.dispose();
    _keepAliveHandle = null;
  }

  void updateKeepAlive() {
    if (hook.wantKeepAlive) {
      if (_keepAliveHandle == null) _ensureKeepAlive();
    } else {
      if (_keepAliveHandle != null) _releaseKeepAlive();
    }
  }

  @override
  void initHook() {
    super.initHook();
    if (hook.wantKeepAlive) _ensureKeepAlive();
  }

  @override
  void build(BuildContext context) {
    if (hook.wantKeepAlive && _keepAliveHandle == null) _ensureKeepAlive();
    return null;
  }

  @override
  void deactivate() {
    if (_keepAliveHandle != null) _releaseKeepAlive();
    super.deactivate();
  }

  @override
  Object get debugValue => _keepAliveHandle!;

  @override
  String get debugLabel => 'useAutomaticKeepAlive';
}
              