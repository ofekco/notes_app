import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
        
      ]),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text('home...',
        style: TextStyle(
        color: Color(0xFF444444),
        fontSize: 18.0,
      ),),
      ),
    );
  }
}