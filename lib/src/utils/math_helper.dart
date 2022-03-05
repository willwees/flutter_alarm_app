import 'dart:math';
import 'dart:ui';

double coordinatesToRadians(Offset center, Offset coords) {
  final double a = coords.dx - center.dx;
  final double b = center.dy - coords.dy;
  return atan2(b, a);
}

double radiansToPercentage(double radians) {
  final double normalized = radians < 0 ? -radians : 2 * pi - radians;
  final double percentage = (100 * normalized) / (2 * pi);
  return (percentage + 25) % 100;
}

int percentageToValue(double percentage, int intervals) => ((percentage * intervals) / 100).round();

extension MathExtension on num {
  double get degrees => 2 * pi / 360 * this;
}
