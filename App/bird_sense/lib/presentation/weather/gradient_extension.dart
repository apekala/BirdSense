import 'package:flutter/material.dart';

extension GradientColorAt on LinearGradient {
  Color? colorAt(double stop) {
    assert(0 <= stop && stop <= 1);
    final nextStopIndex = stops!.indexWhere((element) => element >= stop);
    if (nextStopIndex == -1) {
      // happens when the last stop is not 1, where we return the last given color
      return colors.last;
    }
    if (nextStopIndex == 0) {
      // happens when the first stop is not 0, where we return the first given color
      return colors.first;
    }
    return Color.lerp(
      colors[nextStopIndex - 1],
      colors[nextStopIndex],
      (stop - stops![nextStopIndex - 1]) /
          (stops![nextStopIndex] - stops![nextStopIndex - 1]),
    );
  }
}