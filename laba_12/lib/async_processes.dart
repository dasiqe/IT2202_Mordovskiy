import 'dart:async';
import 'i_coffee.dart';
import 'enums.dart';

Future<void> heatWater() async {
  print("start_process: water\n");
  await Future.delayed(Duration(seconds: 3));
  print("done_process: water\n");
}

Future<void> brewCoffee(CoffeeType type, ICoffee coffee) async {
  print("start_process: ${type.toString().split('.').last}\n");
  await Future.delayed(Duration(seconds: 5));

  if (coffee.milk() > 0) {
    print("done_process: coffee with milk\n");
  } else {
    print("done_process: coffee with water\n");
  }
}

Future<void> steamMilk() async {
  print("start_process: milk\n");
  await Future.delayed(Duration(seconds: 5));
  print("done_process: milk\n");
}

Future<void> mixIngredients() async {
  print("start_process: mixing\n");
  await Future.delayed(Duration(seconds: 3));
  print("done_process: mixing\n");
}
