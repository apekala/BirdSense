import 'package:bird_sense/application/core/temperature_value_object.dart';
import 'package:bird_sense/presentation/weather/gradient_extension.dart';
import 'package:flutter/material.dart';


class Thermometer extends StatelessWidget {
  final double humidyty;

  const Thermometer({
    super.key,
    required this.humidyty,
  });

  static const double _minHumidity =  0;
   

  static const  _maxHumidyty = 100;

  static const LinearGradient _colorGradient = LinearGradient(
    stops: [
      0.1,
      0.2,
      0.3,
      0.4,
      0.6,
      0.9,
    ],
    colors: [
      Colors.blueAccent,
      Colors.blue,
      Colors.lightBlue,
      Colors.lightBlueAccent,
      Colors.blueGrey,
      Colors.white,
    ],
  );

  Color _getColor(double humidity) {
    final value = humidyty;
    const minValue = _minHumidity;
    const maxValue = _maxHumidyty;
    const range = maxValue - minValue;

    return _colorGradient.colorAt(
      (maxValue - value) / range,
    )!;
  }

  double _getHeightFactor(double humidity) {
    final value = humidyty;
    const minValue = _minHumidity;
    const maxValue = _maxHumidyty;
    const range = maxValue - minValue;

    return 1 - (maxValue - value) / range;
  }

  @override
  Widget build(BuildContext context) {
    final heightFactor = _getHeightFactor(humidyty);
    final color = _getColor(humidyty);

    return Center(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 150,
            child: AnimatedContainer(
              clipBehavior: Clip.none,
              height: (heightFactor * 150).clamp(50, 100),
              alignment: Alignment.topCenter,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              // child: TemperatureLabel(temperature: humidyty),
            ),
          ),
          const SizedBox(width: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                AnimatedContainer(
                  width: 40,
                  height: heightFactor * 150,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const ShapeDecoration(
                    color: Colors.transparent,
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                  ),
                  width: 40,
                  height: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureLabel extends StatelessWidget {
  final TemperatureValueObject temperature;

  const TemperatureLabel({
    super.key,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Text(
            temperature.value.toString(),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            temperature.unit.toString(),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}