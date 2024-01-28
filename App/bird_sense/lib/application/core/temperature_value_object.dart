enum TemperatureUnit {
  celsius,
  fahrenheit;

  const TemperatureUnit();

  @override
  String toString() => switch (this) {
        TemperatureUnit.celsius => '°C',
        TemperatureUnit.fahrenheit => '°F',
      };
}

class TemperatureValueObject {
  final double value;
  final TemperatureUnit unit;

  const TemperatureValueObject({
    required this.value,
    required this.unit,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TemperatureValueObject &&
        other.value == value &&
        other.unit == unit;
  }

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  round() {}
}