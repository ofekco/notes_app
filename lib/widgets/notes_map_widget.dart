import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text('map view', 
      style: TextStyle(
        color: Color(0xFF444444),
        fontSize: 18.0,
      ),),
      ),
    );
  }
}