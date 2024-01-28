// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bird_sense/application/forecast_weather/forecast_weather_entity.dart';
import 'package:bird_sense/data/model/colors.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Forecast extends StatelessWidget {
  final List<ForecastWeatherEntity> forecast;
  const Forecast({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    DateTime now = DateTime.now();
    String day = DateFormat('EEEE').format(now);
    print(DateFormat('EEEE').format(now.add(Duration(days: 1))));

    return Column(
      children: _getListData(),
    );
  }

  _getListData() {
    DateTime now = DateTime.now();
    List<Widget> widgets = [];
    for (int i = 0; i < forecast.length; i++) {
      widgets.add(Padding(padding: const EdgeInsets.only(top:6.0), child: Container(
                height: 50,
                width: 380,
                padding: const EdgeInsets.only(left: 10, right: 10),
                
                decoration: BoxDecoration(
                  color: WAColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft:  Radius.circular(i == 0 ? 15:5),
                    topRight: Radius.circular(i == 0 ? 15:5),
                    bottomLeft: Radius.circular(i == 2 ? 15:5),
                    bottomRight: Radius.circular(i == 2 ? 15:5),
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,                      
                      children: [
                        Text(DateFormat('EEEE').format(now.add(Duration(days: i))),
                        style: TextStyle(
                          fontSize: 14,
                          color: WAColors.primaryTextColor,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        
                       
                            Row(
                              children: [
                                Image.network("https:${forecast[i].icon}",
                                  scale: 1.5,),
                                  const SizedBox(width: 40,),
                                  Text('${forecast[i].maxTemperature.round()}°',
                                  style: TextStyle(
                                  fontSize: 14,
                                  color: WAColors.primaryTextColor,
                                  fontWeight: FontWeight.bold
                                                            ),
                                  ),
                                  Text('/${forecast[i].minTemperature.round()}°',
                                  style: TextStyle(
                                  fontSize: 14,
                                  color: WAColors.secondaryTextColor,
                                  fontWeight: FontWeight.bold
                                                            ),
                                  ),
                              ],
                            )
                      
                          
                       
                      ],
                    ),
                  ),));
    }
    return widgets;
  }
}



