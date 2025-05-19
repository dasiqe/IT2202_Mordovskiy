import 'dart:io';
import 'machine.dart';
import 'enums.dart';

void main() async {
  Machine coffeeMachine = Machine(
    initialBeans: 500,
    initialMilk: 1000,
    initialWater: 2000,
    initialCash: 0,
  );

  while (true) {
    print("Выберите команду:");
    print("1. Приготовить кофе");
    print("2. Добавить ресурсы");
    print("3. Показать ресурсы");
    print("4. Выйти");
    stdout.write("Ваш выбор: ");
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      print("\nВыберите тип кофе:");
      print("1. Эспрессо");
      print("2. Капучино");
      print("3. Латте");
      stdout.write("Ваш выбор: ");
      String? coffeeChoice = stdin.readLineSync();

      CoffeeType? selectedType;
      if (coffeeChoice == '1') {
        selectedType = CoffeeType.espresso;
      } else if (coffeeChoice == '2') {
        selectedType = CoffeeType.cappuccino;
      } else if (coffeeChoice == '3') {
        selectedType = CoffeeType.latte;
      } else {
        print("Неверный выбор кофе!");
        continue;
      }

      await coffeeMachine.makeCoffeeByType(selectedType);
    } else if (choice == '2') {
      print(
        "Введите количество зерен, молока и воды для добавления через пробел:",
      );
      stdout.write("Формат: зерна молоко вода -> ");
      List<String> inputs = stdin.readLineSync()?.split(" ") ?? [];
      if (inputs.length == 3) {
        try {
          int beansToAdd = int.parse(inputs[0]);
          int milkToAdd = int.parse(inputs[1]);
          int waterToAdd = int.parse(inputs[2]);
          if (beansToAdd >= 0 && milkToAdd >= 0 && waterToAdd >= 0) {
            coffeeMachine.fillResources(
              beans: beansToAdd,
              milk: milkToAdd,
              water: waterToAdd,
            );
          } else {
            print("Количество ресурсов не может быть отрицательным.");
          }
        } catch (e) {
          print("Ошибка ввода! Введите числа.");
        }
      } else {
        print("Ошибка ввода! Требуется 3 значения.");
      }
    } else if (choice == '3') {
      coffeeMachine.displayResources();
    } else if (choice == '4') {
      print("Выход...");
      break;
    } else {
      print("Неверная команда!");
    }
  }
}
