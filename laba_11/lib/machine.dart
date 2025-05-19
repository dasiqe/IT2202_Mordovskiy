import 'resources.dart';
import 'i_coffee.dart';
import 'enums.dart';
import 'coffee_types.dart';
import 'async_processes.dart';
import 'dart:io';

class Machine {
  Resources _resources;

  Machine({
    required int initialBeans,
    required int initialMilk,
    required int initialWater,
    required int initialCash,
  }) : _resources = Resources(
         coffeeBeans: initialBeans,
         milk: initialMilk,
         water: initialWater,
         cash: initialCash,
       );

  Resources get resources => _resources;

  void fillResources({
    int beans = 0,
    int milk = 0,
    int water = 0,
    int cash = 0,
  }) {
    _resources.coffeeBeans += beans;
    _resources.milk += milk;
    _resources.water += water;
    _resources.cash += cash;
    print("Ресурсы пополнены.");
    displayResources();
  }

  bool isAvailableResources(ICoffee coffee) {
    return _resources.coffeeBeans >= coffee.coffeBeans() &&
        _resources.milk >= coffee.milk() &&
        _resources.water >= coffee.water();
  }

  void _subtractResources(ICoffee coffee) {
    _resources.coffeeBeans -= coffee.coffeBeans();
    _resources.milk -= coffee.milk();
    _resources.water -= coffee.water();
    _resources.cash += coffee.cash();
  }

  Future<void> makeCoffeeByType(CoffeeType type) async {
    stdout.write("*\n");
    stdout.write("_start_\n");

    ICoffee? coffee = getCoffeeInstance(type);

    if (coffee == null) {
      print("Неизвестный тип кофе.");
      stdout.write("_end_\n");
      return;
    }

    if (!isAvailableResources(coffee)) {
      print("Недостаточно ресурсов для ${coffee.getName()}!");
      print(
        "Требуется: Зерна: ${coffee.coffeBeans()} г, Молоко: ${coffee.milk()} мл, Вода: ${coffee.water()} мл.",
      );
      displayResources();
      stdout.write("_end_\n");
      return;
    }

    List<Future<void>> parallelSteps = [];

    parallelSteps.add(heatWater());

    if (type == CoffeeType.cappuccino || type == CoffeeType.latte) {
      parallelSteps.add(steamMilk());
    }

    await Future.wait(parallelSteps);
    stdout.write("_then_\n");

    await brewCoffee(type, coffee);

    if (type == CoffeeType.cappuccino || type == CoffeeType.latte) {
      await mixIngredients();
    }

    _subtractResources(coffee);

    stdout.write("_end_\n");
  }

  void displayResources() {
    print("Текущие ресурсы: ${_resources.toString()}");
  }
}
