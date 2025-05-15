import 'dart:async';
import 'dart:io';
import 'i_coffee.dart';
import 'enums.dart';

Future<void> heatWater() async {
  stdout.write("start_process: water\n");
  await Future.delayed(Duration(seconds: 3));
  stdout.write("done_process: water\n");
}

Future<void> brewCoffee(CoffeeType type, ICoffee coffee) async {
  stdout.write("start_process: ${type.toString().split('.').last}\n");
  await Future.delayed(Duration(seconds: 5));

  if (coffee.milk() > 0) {
    stdout.write("done_process: coffee with milk\n");
  } else {
    stdout.write("done_process: coffee with water\n");
  }
}

Future<void> steamMilk() async {
  stdout.write("start_process: milk\n");
  await Future.delayed(Duration(seconds: 5));
  stdout.write("done_process: milk\n");
}

Future<void> mixIngredients() async {
  stdout.write("start_process: mixing\n");
  await Future.delayed(Duration(seconds: 3));
  stdout.write("done_process: mixing\n");
}
