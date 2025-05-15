import 'resources.dart';
import 'i_coffee.dart';
import 'enums.dart';
import 'coffee_types.dart';

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

  void makeCoffeeByType(CoffeeType type) {
    ICoffee? coffee = getCoffeeInstance(type);

    if (coffee == null) {
      print("Неизвестный тип кофе.");
      return;
    }

    if (isAvailableResources(coffee)) {
      _subtractResources(coffee);
      print("${coffee.getName()} готов!");
      displayResources();
    } else {
      print("Недостаточно ресурсов для ${coffee.getName()}!");
      print(
        "Требуется: Зерна: ${coffee.coffeBeans()} г, Молоко: ${coffee.milk()} мл, Вода: ${coffee.water()} мл.",
      );
      displayResources();
    }
  }

  void displayResources() {
    print("Текущие ресурсы: ${_resources.toString()}");
  }
}
