import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/modeles/note.dart';
import 'package:notes_app/screens/note_edit_screen.dart';
import 'package:notes_app/widgets/notes_list_widget.dart';
import 'package:notes_app/modeles/user.dart';
import 'package:notes_app/widgets/notes_map_widget.dart';


class homeScreen extends StatefulWidget {
  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
   static const List<Widget> _viewOptionsWidgets = <Widget>[  
    NotesList(),
    MapView(),
    Text('Loading...', 
      style: TextStyle(
        color: Color(0xFF444444),
        fontSize: 18.0,
      ),),
  ]; 

  void _haveNotes() async {
    if(await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notes')
        .snapshots().isEmpty == true) {
           _viewOptionWidgetsIndex = 2; 
        } 
  }


  int _viewOptionWidgetsIndex = 0;

  void _onItemTapped(int index) {  
    setState(() {  
      _viewOptionWidgetsIndex = index; 
    });  
  }  

  
  @override
  Widget build(BuildContext context) {
          
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: FutureBuilder(
            future: FirebaseFirestore.instance.collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState ==  ConnectionState.waiting) {
                return Text(" ");
              } else {
                return Text("Welcome " + snapshot.data!['username'] + "!", 
                  style: TextStyle(
                    color: Color(0xFF444444),
                    fontSize: 24),
                );
              }
              
            },
        ),
        actions: <Widget>[
          OutlinedButton( //sign out button
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Icon(Icons.logout_outlined, color: Color(0xFF444444), size: 26,),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(  
        items: <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.list_alt_outlined, color: Color(0xFF444444)),   
            label: "List",
            backgroundColor: Theme.of(context).secondaryHeaderColor,
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.location_on_outlined, color: Color(0xFF444444)),
            label: "Map",    
            backgroundColor: Theme.of(context).secondaryHeaderColor,
          ),  
        ],  
        type: BottomNavigationBarType.shifting,  
        currentIndex: _viewOptionWidgetsIndex,  
        selectedItemColor: Colors.black,  
        iconSize: 35,  
        onTap: _onItemTapped,  
        elevation: 5  
      ),
      backgroundColor: Theme.of(context).primaryColor,
      //Add new note button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        child: const Icon(Icons.add, color: Color(0xFF444444)),
        onPressed: () {
          Navigator.push(context,  
            MaterialPageRoute(builder: ((context) => NoteEditScreen(Note("0", '' '', '', DateTime.now(), 0, 0)))));
        }),
      body: _viewOptionsWidgets[_viewOptionWidgetsIndex]
    );
  }
}