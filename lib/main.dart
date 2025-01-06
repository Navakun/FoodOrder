import 'dart:math';
import 'package:flutter/material.dart';
import 'FoodMenu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo :Food Order - Total Price:'),
    );
  }
}

// สร้างคลาส FoodMenu

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // รายการ FoodMenu
  List<FoodMenu> _menuItems = [];

  final Random _random = Random();

  // กำหนดราคาอาหารแบบคงที่
  final Map<String, int> _foodPrices = {
    'Steak': 200,
    'Burger': 50,
    'Pasta': 100,
    'Pizza': 150,
    'Salad': 80,
  };

  // ฟังก์ชันคำนวณราคาสุทธิรวม
  int get _totalPrice {
    int total = 0;
    for (var menu in _menuItems) {
      total += menu.price;
    }
    return total;
  }

  // ฟังก์ชันสร้างรายการอาหารแบบสุ่ม
  void _addNewMenu() {
    setState(() {
      // ข้อมูลตัวอย่างอาหาร
      List<String> dishes = ['Steak', 'Burger', 'Pasta', 'Pizza', 'Salad'];
      List<List<String>> ingredientsList = [
        ['Beef', 'Cheese', 'Potato'],
        ['Beef', 'Cheese', 'Bread'],
        ['Pasta', 'Cheese', 'Beef'],
        ['Cheese', 'Tomato', 'Bread'],
        ['Lettuce', 'Tomato', 'Cucumber']
      ];

      int index = _random.nextInt(dishes.length);
      String dish = dishes[index];
      int price = _foodPrices[dish] ?? 0; // ใช้ราคาที่กำหนดใน _foodPrices
      _menuItems.add(
        FoodMenu(
          name: dish,
          price: price,
          ingredients: ingredientsList[index],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          '${widget.title} ${_totalPrice} ฿', // แสดงราคาใน title
        ),
      ),
      body: Center(
        child: _menuItems.isEmpty
            ? const Text('No menu items yet! Click + to add one.')
            : ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  FoodMenu menu = _menuItems[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        '${menu.price}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text('Dish $index is ${menu.name}'),
                    subtitle: Text(
                        'This menu ingredients are ${menu.ingredients.join(', ')}'),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewMenu,
        tooltip: 'Add Menu Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
