import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

final Random _random = Random.secure();

Color get() {
  final int length = Colors.primaries.length;
  return Colors.primaries[_random.nextInt(length)].withAlpha(200);
}
