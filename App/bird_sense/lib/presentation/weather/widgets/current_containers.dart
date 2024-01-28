import 'dart:math' as math;

import 'package:bird_sense/presentation/weather/thermomentr.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:bird_sense/application/core/wind_value_object.dart';
import 'package:bird_sense/data/model/colors.dart';
import 'package:flutter/material.dart';


class CurrentContainers extends StatelessWidget {
  final WindValueObject wind;
  final String windDirection;
  final double windDegree;
  final double uv;
  final double pressure;
  final double humidity;

const CurrentContainers({ Key? key, 
required this.wind,
required this.pressure,
required this.windDirection,
required this.windDegree,
required this.uv,
required this.humidity,
}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        Column(
          children: [
            //Wiatr
            Container(
              margin: EdgeInsets.only(left: 8),
              height: 190,
              width: 170,
              decoration: BoxDecoration(
                color: WAColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                        "Wind",
                        style:  TextStyle(
                        color: WAColors.primaryTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        ),             
                      ),
                      const SizedBox(height: 8,),

                      Text(
                        "${wind.value.round()} km/h",
                        style:  TextStyle(
                        color: WAColors.primaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        ),             
                      ),
                      const SizedBox(height: 8,),
                      Center(
                        child: Column(
                          
                          children: [
                            Text("${windDirection}",
                              style:  TextStyle(
                              color: WAColors.primaryTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              ),
                            ),
                            Transform.rotate(
                              angle: windDegree * math.pi / 180,
                                child: Icon(Icons.arrow_circle_up_outlined,
                                color: WAColors.iconColor1,
                                size: 70,
                                semanticLabel: "text",),
                            ),
                          ],
                        ),
                      )

                
                  ]),
                ),
            ),
            const SizedBox(height: 20,),
            //Indeks UV
            Container(
              margin: EdgeInsets.only(left: 8),
              height: 190,
              width: 170,
              decoration: BoxDecoration(
                color: WAColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                          "UV",
                          style:  TextStyle(
                          color: WAColors.primaryTextColor,
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          ),             
                        ),
                        const SizedBox(height: 25,),
                        Text(
                        "${uv.round()}",
                        style:  TextStyle(
                        color: WAColors.primaryTextColor,
                        fontSize: 40,
                        fontWeight: FontWeight.normal,
                        ),

                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('0'),
                          LinearPercentIndicator(
                            width: 110,
                            lineHeight: 20,
                            percent: uv.round() / 11,
                            backgroundColor: Colors.greenAccent,
                            progressColor: Colors.green,
                            barRadius: const Radius.circular(10),
                          ),
                          const Text('+11'),
                          
                        ],
                      ),

                      ]
                  ),
                )
            ),

          ],
        ),
        const SizedBox(width: 4,),

        Column(
          children: [
            //Humidyty
            Container(
              margin: EdgeInsets.only(right: 8),
              height: 190,
              width: 170,
              
              decoration: BoxDecoration(
                color: WAColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  

                  child: Row(
                    children: [
                      Column(
                        children: [ 
                          Text(
                              "Humidity",
                              style:  TextStyle(
                              color: WAColors.primaryTextColor,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              ),             
                            ),

                            const SizedBox(height: 25,),
                        Text(
                        "${humidity.round()}%",
                        style:  TextStyle(
                        color: WAColors.primaryTextColor,
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        ),
                        ),


                            
                            ],
                        


                      ),
                      Padding(padding: EdgeInsets.only(top: 0, left: 0),
                      child: Thermometer(humidyty: humidity)
                        
                        
                        


                      
                      )
                    ],
                  ),
                
                ),
            ),
            const SizedBox(height: 20,),
            //Pressure
            Container(
              margin: EdgeInsets.only(right: 8),
              height: 190,
              width: 170,
              decoration: BoxDecoration(
                color: WAColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),),
                child: Padding(
                  padding: EdgeInsets.only(left:15, top:15),

                  child: Row(
                    children: [
                      Column(
                        children: [ 
                          Text(
                              "Pressure",
                              style:  TextStyle(
                              color: WAColors.primaryTextColor,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              ),             
                            ),

                            const SizedBox(height: 25,),
                        Text(
                          
                        "${pressure.round()}",
                        style:  TextStyle(
                        color: WAColors.primaryTextColor,
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        ),
                        ),
                        Text(
                        "mbar",
                        style:  TextStyle(
                        color: WAColors.secondaryTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        ),
                        ),


                            
                            ],
                        


                      ),
                      SizedBox(width: 0,),
                       CircularPercentIndicator(
                        radius: 36,
                        lineWidth: 15,
                        startAngle: 180,
                        percent: pressure / (1100+900),
                        animation: true,
                        animationDuration: 1000,
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: WAColors.iconColor1,
                        arcType: ArcType.FULL,
                        arcBackgroundColor: WAColors.backgroundColor,
                        linearGradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          stops: [
                              0.1,
                              0.2,
                              0.3,
                              0.4,
                              0.6,
                              0.9,
                            ],
                            colors: [
                            Colors.green,
                            Colors.greenAccent,
                            Colors.lightGreen,
                            Colors.lightGreenAccent,
                            Color.fromRGBO(185, 248, 152, 1),
                            Colors.white,
                          ],),
                        
                        
                        


                      
                      )
                    ],
                  ),
                
                ),
            ),

          ],
        ),

      ],
    );
  }
}