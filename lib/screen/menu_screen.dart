import 'package:client/screen/draw_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final symbols = [
    '零',
    '㆒',
    '㆓',
    '㆔',
    '㆕',
    '五',
    '六',
    '七',
    '八',
    '九',
    '十',
    '十一',
    '十二',
    '十三',
    '十四',
    '十五'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(centerTitle: true, title: const Text('Menu')),
        body: ListView.builder(
          itemCount: symbols.length,
          prototypeItem: ListTile(
            title: Text(symbols.first),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DrawScreen(
                      index: index,
                      ierogliph: symbols[index],
                    ),
                  ),
                );
              },
              titleTextStyle: const TextStyle(fontSize: 30),
              tileColor: Colors.white,
              title: Text(
                symbols[index],
                textAlign: TextAlign.center,
              ),
            );
          },
        ));
  }
}
