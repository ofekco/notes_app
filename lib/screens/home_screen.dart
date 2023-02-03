import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum ViewOptions {
  listView,
  mapView
}

class homeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('My Notes'),
        actions: <Widget>[
          OutlinedButton( //sign out button
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout_outlined, color: Colors.white),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          PopupMenuButton(
            onSelected: (ViewOptions selectedItem) {
              //change widgets
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text("List view"), value: ViewOptions.listView),
              PopupMenuItem(child: Text("Map view"), value: ViewOptions.mapView),
            ],
          ),
        ]
      ),
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