import 'package:bird_sense/application/core/temperature_value_object.dart';
import 'package:bird_sense/application/core/wind_value_object.dart';
import 'package:bird_sense/application/current_weather/current_weather_bloc.dart';
import 'package:bird_sense/application/current_weather/current_weather_entity.dart';
import 'package:bird_sense/application/forecast_weather/bloc/forecast_bloc.dart';
import 'package:bird_sense/application/forecast_weather/forecast_weather_entity.dart';
import 'package:bird_sense/application/forecast_weather/hourly_weather_entity.dart';
import 'package:bird_sense/application/markers/bloc/markers_bloc.dart';
import 'package:bird_sense/data/model/color.dart';
import 'package:bird_sense/data/model/colors.dart';
import 'package:bird_sense/presentation/weather/widgets/current_containers.dart';
import 'package:bird_sense/presentation/weather/widgets/current_temp.dart';
import 'package:bird_sense/presentation/weather/widgets/forecast.dart';
import 'package:bird_sense/presentation/weather/widgets/hourly_forecast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class WeatherPage extends HookWidget {
  final LatLng latlong;
  const WeatherPage({super.key, required this.latlong});

  CurrentWeatherEntity? getWeather({required CurrentWeatherState from}) {
    final state = from;

    if (state is CurrentWeatherLoading) {
      return state.lastWeather;
    }

    if (state is CurrentWeatherLoaded) {
      return state.weather;
    }

    return null;
  }

  List<ForecastWeatherEntity>? getForecastWeather(
      {required ForecastWeatherState from}) {
    final state = from;

    if (state is ForecastWeatherLoading) {
      return state.lastWeather;
    }

    if (state is ForecastWeatherLoaded) {
      return state.weather;
    }

    return null;
  }

  List<HourlyWeatherEntity>? getHourlytWeather(
      {required ForecastWeatherState from}) {
    final state = from;

    if (state is ForecastWeatherLoading) {
      return state.lastHourly;
    }

    if (state is ForecastWeatherLoaded) {
      return state.hourly;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    var location = LatLng(0, 0);
    var city = useState('');
    var subCity = useState('');
    
    Future<List<Placemark>> placemarkFromCoordinates(
      double latitude,
      double longitude, {
      String? localeIdentifier,
    }) =>
        GeocodingPlatform.instance.placemarkFromCoordinates(
          latitude,
          longitude,
          localeIdentifier: localeIdentifier,
        );

    getAdress(latitude, longitude) async {
      List<Placemark> placemark =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemark[0];
      print(place);
      city.value = place.locality!;
      subCity.value = place.subLocality!;
    }

    return BlocBuilder<MarkersBloc, MarkersState>(
            builder: (contextMarker, state) {
              
              
              if(state is MarkersLoaded){
                
                final markerChoosed = state.markers;
                getAdress(markerChoosed.latitude, markerChoosed.longitude);
        return BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
            builder: (context, state) {
          
          
          final weather = getWeather(from: state);

          return BlocBuilder<ForecastBloc, ForecastWeatherState>(
            builder: (contextForecast, stateForecast) {
              final forecast = getForecastWeather(from: stateForecast);

              final hourly = getHourlytWeather(from: stateForecast);

              // print(hourly?.length);
              // return Center();
              print(state);
              print(stateForecast);
              print(forecast?.length);
              if(markerChoosed != location){
                location = markerChoosed;
                context.read<CurrentWeatherBloc>().add( QueryForLocationEvent( location: '${markerChoosed.latitude},${markerChoosed.longitude}'),
                                                            );
                                                        contextForecast
                                                            .read<
                                                                ForecastBloc>()
                                                            .add(
                                                              ForecastEvent(
                                                                  location: '${markerChoosed.latitude},${markerChoosed.longitude}'),
                                                            );
              }
              if (state is CurrentWeatherLoaded &&
                  stateForecast is ForecastWeatherLoaded) {
                print(weather?.temperatureC);
                return SingleChildScrollView(
                  child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15, right: 9),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: BSColors.backgroundColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${city.value}, ${subCity.value}',
                                style: const TextStyle(fontSize: 23),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CurrentTemp(
                            temperature: weather?.temperatureC ??
                                const TemperatureValueObject(
                                    value: 0, unit: TemperatureUnit.celsius),
                            icon: weather?.conditionIcon ??
                                '//cdn.weatherapi.com/weather/64x64/day/302.png',
                            conditionText: weather?.conditionText ?? '',
                            feelslikeTemperature:
                                weather?.fellTemperatureCelcius ?? 0,
                            maxTemperature: forecast?[0].maxTemperature ?? 0,
                            minTemperature: forecast?[0].minTemperature ?? 0),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Today",
                            //textAlign: TextAlign.left,
                            style: TextStyle(
                                color: WAColors.primaryTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        HourlyForecast(hourly: hourly ?? []),
                        const SizedBox(
                          height: 20,
                        ),

                        Text("Forecast",
                            //textAlign: TextAlign.left,
                            style: TextStyle(
                                color: WAColors.primaryTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),

                        // Forecast(forecast: forecast ?? []),
                        Forecast(forecast: forecast ?? []),

                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text("Current weather",
                              //textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: WAColors.primaryTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CurrentContainers(
                          wind: weather?.windKph ??
                              const WindValueObject(
                                  value: 0, unit: WindUnit.kilometersPerHour),
                          pressure: weather?.pressure ?? 0,
                          uv: weather?.uv ?? 0,
                          windDegree: weather?.windDegree ?? 0,
                          windDirection: weather?.windDirection ?? '',
                          humidity: weather?.humidity ?? 0,
                        ),
                      ]),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        });
      }
      else {
        return const Center(child: CircularProgressIndicator());
      }
            }
    );
  }
}
