import 'dart:math';

import 'package:faker/faker.dart';

abstract class ModelFactory<T> {
  Faker get faker => Faker();

  int createFakeId() {
    var random = Random();
    return random.nextInt(100);
  }

  T generateFake();

  List<T> generateFakeList({required int length});
}
