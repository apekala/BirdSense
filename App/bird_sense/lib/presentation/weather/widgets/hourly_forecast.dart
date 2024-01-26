import 'package:bird_sense/application/forecast_weather/hourly_weather_entity.dart';
import 'package:bird_sense/data/model/colors.dart';
import 'package:flutter/material.dart';


class HourlyForecast extends StatelessWidget {
  final List<HourlyWeatherEntity> hourly;
  const HourlyForecast({ Key? key, required this.hourly}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    TimeOfDay now = TimeOfDay.now();
    
    return Row(
       children: <Widget>[
      Expanded(
      child: Container(
        height: 150.0,
        margin: const EdgeInsets.only(left: 15, right: 15),
        
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)
        
        ),
        color: WAColors.primaryColor,
        ),
        child: ListView.builder(
         scrollDirection: Axis.horizontal,
         itemCount: hourly.length,
         itemBuilder: (context, index) {

            var  time = now.hour + index;
            if (time>=24){
              time = time - 24;
            }
            

             return Container(
              margin: const EdgeInsets.only(left: 30,right: 20),
              padding: const EdgeInsets.only(top:20, bottom: 20),
               child: Column(
                
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('${hourly[index].temperature.round()}°',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: WAColors.primaryTextColor,
                    fontSize: 18
                  ),),
                   const SizedBox(height: 15,),
                  Image.network("https:${hourly[index].icon}",
                  scale: 1.5,),
                  Text('${index}:00')


                ],
                  
                         ),
             );
           
         },
         
        ),
      ),
        )
       ]
    );
  }
}