import 'dart:math';

final Random _random = Random.secure();

Shape get() {
  const int length = 3;
  return Shape.values[_random.nextInt(length)];
}

enum Shape {
  Rect,
  Circle,
  Triangle,
}
