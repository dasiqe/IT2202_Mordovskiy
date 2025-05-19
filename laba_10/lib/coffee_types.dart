import 'i_coffee.dart';
import 'enums.dart';

class Espresso implements ICoffee {
  @override
  String getName() => "Эспрессо";
  @override
  int coffeBeans() => 50;
  @override
  int milk() => 0;
  @override
  int water() => 100;
  @override
  int cash() => 150;
}

class Cappuccino implements ICoffee {
  @override
  String getName() => "Капучино";
  @override
  int coffeBeans() => 50;
  @override
  int milk() => 150;
  @override
  int water() => 100;
  @override
  int cash() => 200;
}

class Latte implements ICoffee {
  @override
  String getName() => "Латте";
  @override
  int coffeBeans() => 50;
  @override
  int milk() => 250;
  @override
  int water() => 100;
  @override
  int cash() => 250;
}

ICoffee? getCoffeeInstance(CoffeeType type) {
  switch (type) {
    case CoffeeType.espresso:
      return Espresso();
    case CoffeeType.cappuccino:
      return Cappuccino();
    case CoffeeType.latte:
      return Latte();
  }
}
