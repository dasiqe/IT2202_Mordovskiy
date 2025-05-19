class Resources {
  int _coffeeBeans;
  int _milk;
  int _water;
  int _cash;

  Resources({
    required int coffeeBeans,
    required int milk,
    required int water,
    required int cash,
  }) : _coffeeBeans = coffeeBeans,
       _milk = milk,
       _water = water,
       _cash = cash;

  int get coffeeBeans => _coffeeBeans;
  int get milk => _milk;
  int get water => _water;
  int get cash => _cash;

  set coffeeBeans(int value) => _coffeeBeans = value;
  set milk(int value) => _milk = value;
  set water(int value) => _water = value;
  set cash(int value) => _cash = value;

  @override
  String toString() {
    return 'Зерна: $_coffeeBeans г, Молоко: $_milk мл, Вода: $_water мл, Наличные: $_cash руб.';
  }
}
