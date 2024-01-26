enum WindUnit {
  milesPerHour,
  kilometersPerHour,;

  const WindUnit();

  @override
  String toString() => switch (this) {
        WindUnit.milesPerHour => 'Mph',
        WindUnit.kilometersPerHour => 'Kph',
      };
}

class WindValueObject {
  final double value;
  final WindUnit unit;

  const WindValueObject({
    required this.value,
    required this.unit,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WindValueObject &&
        other.value == value &&
        other.unit == unit;
  }

  @override
  int get hashCode => value.hashCode ^ unit.hashCode;

  round() {}
}