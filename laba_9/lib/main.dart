import 'dart:io';

class Machine {
  int _coffeeBeans;
  int _milk;
  int _water;
  int _cash;

  Machine(this._coffeeBeans, this._milk, this._water, this._cash);

  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  set coffeeBeans(int value) => _coffeeBeans = value;
  set milk(int value) => _milk = value;
  set water(int value) => _water = value;
  set cash(int value) => _cash = value;

  bool isAvailable() {
    return _coffeeBeans >= 50 && _water >= 100;
  }

  void _subtractResources() {
    _coffeeBeans -= 50;
    _water -= 100;
    _cash += 150;
  }

  void makingCoffee() {
    if (isAvailable()) {
      _subtractResources();
      print("Кофе готов!");
    } else {
      print("Недостаточно ресурсов!");
    }
  }
}

void main() {
  Machine coffeeMachine = Machine(200, 500, 1000, 0);

  while (true) {
    print(
      "\nВыберите команду: \n1. Приготовить кофе\n2. Добавить ресурсы\n3. Выйти",
    );
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      coffeeMachine.makingCoffee();
    } else if (choice == '2') {
      print("Введите количество зерен, молока и воды через пробел:");
      List<String> inputs = stdin.readLineSync()?.split(" ") ?? [];
      if (inputs.length == 3) {
        coffeeMachine.coffeeBeans += int.parse(inputs[0]);
        coffeeMachine.milk += int.parse(inputs[1]);
        coffeeMachine.water += int.parse(inputs[2]);
        print("Ресурсы добавлены.");
      } else {
        print("Ошибка ввода!");
      }
    } else if (choice == '3') {
      print("Выход...");
      break;
    } else {
      print("Неверная команда!");
    }
  }
}
