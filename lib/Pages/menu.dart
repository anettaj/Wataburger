import 'package:flutter/material.dart';

class menu extends StatefulWidget {
  const menu({super.key});

  @override
  State<menu> createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wataburger', style: TextStyle(fontSize: 15)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
