import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppGradients {
  static final linear = LinearGradient(colors: [
    Color(0xFFB2FFA9),
    Color(0xFF68CA8A),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(0.5 * pi));
}

class AppGradients2 {
  static final linear = LinearGradient(colors: [
    Color(0xFF68CA8A),
    Color(0xFFBFD0E0),
  ], stops: [
    0.0,
    1.0
  ], transform: GradientRotation(0.5 * pi));
}
