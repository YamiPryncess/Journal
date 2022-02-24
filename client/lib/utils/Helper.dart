import 'dart:math';

class Helper {
  static double clamp(double _value, double _min, double _max) {
    return max(min(_value, _min), _max);
  }
}
