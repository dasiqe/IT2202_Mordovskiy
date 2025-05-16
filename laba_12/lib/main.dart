import 'package:flutter/material.dart';
import 'machine.dart';
import 'ui/pages/coffee_page.dart';
import 'ui/pages/resource_page.dart';

void main() {
  runApp(const CoffeeMachineApp());
}

class CoffeeMachineApp extends StatelessWidget {
  const CoffeeMachineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      builder: (context, child) {
        return ScaffoldMessenger(child: child!);
      },
      home: const MainTabScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  final Machine coffeeMachine = Machine(
    initialBeans: 500,
    initialMilk: 1000,
    initialWater: 2000,
    initialCash: 0,
  );

  void _handleMachineStateChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Coffee Machine'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.coffee), text: 'Кофе'),
              Tab(icon: Icon(Icons.local_drink), text: 'Ресурсы'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoffeePage(
              machine: coffeeMachine,
              onMachineStateChanged: _handleMachineStateChanged,
            ),
            ResourcePage(
              machine: coffeeMachine,
              onMachineStateChanged: _handleMachineStateChanged,
            ),
          ],
        ),
      ),
    );
  }
}
