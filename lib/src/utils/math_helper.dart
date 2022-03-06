import 'dart:math';
import 'dart:ui';

double coordinatesToRadians(Offset center, Offset coords) {
  // calculate the x-axis diff
  final double x = coords.dx - center.dx;

  // calculate the y-axis diff
  final double y = center.dy - coords.dy;

  // calculate the angle in radians
  // assume 3 o'clock equals to 0 radians
  return atan2(y, x);
}

double radiansToPercentage(double radians) {
  // radians value: -3.14... to 3.14...

  // normalize the radians value
  // if the radians is negative, abs the value
  // if the radians is positive, calculate the complement value
  // remember that 360 degrees = 2 * pi radians
  final double normalizedRadians = radians < 0 ? -radians : 2 * pi - radians;

  // convert the normalized radians into percentage
  final double percentage = (100 * normalizedRadians) / (2 * pi);

  // move the start point by 90 degrees by adding 25 to the percentage
  // remember that 90 degrees is 25% of a full circle (360 degrees)
  return (percentage + 25) % 100;
}

int percentageToValue(double percentage, int intervals) {
  return ((percentage * intervals) / 100).round();
}

extension MathExtension on num {
  double get degrees => 2 * pi / 360 * this;
}
